let min64 a b = if Int64.compare a b <= 0 then a else b
let max64 a b = if Int64.compare a b >= 0 then a else b

(* [run ~domains worker] spawns [domains] domains, releases them together from
   a barrier, and runs [worker i] on domain [i] (0-based). The worker owns its
   whole loop: it does the operations, sums retries in a local ref, and can
   measure allocation around the loop.

   Returns (seconds, results) where seconds is the time from the earliest
   worker start to the latest worker end (so spawn/join cost is excluded) and
   results are the worker return values in domain order.

   Spin barrier: arrival counter on a padded atomic. It is one-shot, so a new
   [run] call makes a fresh one. *)
let run ~domains (worker : int -> 'a) : float * 'a list =
  if domains < 1 then invalid_arg "Harness.run: domains must be >= 1";
  if domains > Domain.recommended_domain_count () then
    Printf.eprintf
      "warning: %d domains > recommended %d; results will be distorted\n%!"
      domains
      (Domain.recommended_domain_count ());
  let arrived = Stdlib.Atomic.make_contended 0 in
  let body i () =
    Atomic.incr arrived;
    while Atomic.get arrived < domains do
      Domain.cpu_relax ()
    done;
    let t0 = Mtime_clock.elapsed_ns () in
    let r = worker i in
    let t1 = Mtime_clock.elapsed_ns () in
    (t0, t1, r)
  in
  let results =
    List.init domains (fun i -> Domain.spawn (body i)) |> List.map Domain.join
  in
  let t_min =
    List.fold_left (fun a (s, _, _) -> min64 a s) Int64.max_int results
  in
  let t_max =
    List.fold_left (fun a (_, e, _) -> max64 a e) Int64.min_int results
  in
  let seconds = Int64.to_float (Int64.sub t_max t_min) /. 1e9 in
  (seconds, List.map (fun (_, _, r) -> r) results)

(* [repeat ~warmup ~reps f] runs [f] [warmup] times discarding the results
   (page faults, cold caches), then [reps] times keeping them. *)
let repeat ~warmup ~reps (f : unit -> 'a) : 'a list =
  for _ = 1 to warmup do
    ignore (f ())
  done;
  List.init reps (fun _ -> f ())

let median_of_sorted arr =
  let n = Array.length arr in
  if n = 0 then invalid_arg "Harness.median_of_sorted: empty array"
  else if n mod 2 = 1 then arr.(n / 2)
  else (arr.(n / 2 - 1) +. arr.(n / 2)) /. 2.0

(* Median and IQR. Quartiles use Tukey's hinges: the median is excluded from
   both halves when n is odd. IQR is nan for a single sample. With few samples
   (say < 8) the IQR is a rough indicator, not a reliable estimate. *)
let median_and_iqr (xs : float list) : float * float =
  match xs with
  | [] -> invalid_arg "Harness.median_and_iqr: empty list"
  | _ ->
      let sorted = Array.of_list xs in
      Array.sort Float.compare sorted;
      let n = Array.length sorted in
      let median = median_of_sorted sorted in
      if n < 2 then (median, Float.nan)
      else
        let mid = n / 2 in
        let lower = Array.sub sorted 0 mid in
        let upper = Array.sub sorted (n - mid) mid in
        (median, median_of_sorted upper -. median_of_sorted lower)

let env name ~default =
  match Sys.getenv_opt name with
  | Some s when String.trim s <> "" -> String.trim s
  | _ -> default

let machine () = env "BENCH_MACHINE" ~default:"unknown"
let git_desc () = env "GIT_DESC" ~default:"unknown"
let bench_date () = env "BENCH_DATE" ~default:"undated"

let meta_lines () =
  [
    ("machine", machine ());
    ("git", git_desc ());
    ("date", bench_date ());
    ("ocaml_version", Sys.ocaml_version);
    ("os_type", Sys.os_type);
    ("word_size", string_of_int Sys.word_size);
    ("recommended_domains", string_of_int (Domain.recommended_domain_count ()));
    ("flags", env "BENCH_FLAGS" ~default:"");
  ]


let fmt_float x = Printf.sprintf "%.9g" x

let csv_field s =
  let needs_quote =
    String.exists (fun c -> c = ',' || c = '"' || c = '\n' || c = '\r') s
  in
  if not needs_quote then s
  else begin
    let b = Buffer.create (String.length s + 2) in
    Buffer.add_char b '"';
    String.iter
      (fun c ->
        if c = '"' then Buffer.add_string b "\"\"" else Buffer.add_char b c)
      s;
    Buffer.add_char b '"';
    Buffer.contents b
  end

let csv_row fields = String.concat "," (List.map csv_field fields)

let ensure_dir d = if not (Sys.file_exists d) then Sys.mkdir d 0o755

let results_path ~bench =
  let m = machine () in
  if m = "unknown" then
    prerr_endline "warning: BENCH_MACHINE is not set; results go in results/unknown";
  ensure_dir "results";
  let dir = Filename.concat "results" m in
  ensure_dir dir;
  Filename.concat dir
    (Printf.sprintf "%s_%s_%s.csv" (bench_date ()) (git_desc ()) bench)

let write_csv ~path ~columns (rows : string list list) =
  Out_channel.with_open_text path (fun oc ->
      List.iter
        (fun (k, v) -> Printf.fprintf oc "# %s: %s\n" k v)
        (meta_lines ());
      output_string oc (csv_row columns);
      output_char oc '\n';
      List.iter
        (fun row ->
          output_string oc (csv_row row);
          output_char oc '\n')
        rows)
