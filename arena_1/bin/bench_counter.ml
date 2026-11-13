open Arena_1


let variants : (string * (module Counter.S)) list =
  [
    ("cas", (module Counter.Cas : Counter.S));
    ("cas_pause", (module Counter.Cas_pause : Counter.S));
    ("cas_backoff", (module Counter.Cas_backoff : Counter.S));
    ("faa", (module Counter.Faa : Counter.S));
    ("spin", (module Counter.Spin : Counter.S));
    ("std_mutex", (module Counter.Std_mutex : Counter.S));
  ]

(* Keep to the clean region: 1-4 domains (M4 P cores / one domain per physical
   core on the i5). 5+ goes in a separate run: E cores on the M4, SMT siblings
   on the i5. *)
let domain_counts = [ 1; 2; 3; 4 ]

(* Private work between operations, in nanoseconds (converted to loop
   iterations via the calibration below). 0 = back-to-back operations. *)
let work_ns_list = [ 0; 200; 5000 ]
let rep_runs = 3

let shuffle_seed = 42

(* Each iteration goes through opaque_identity so the loop cannot be removed
   or folded. For work_iters = 0 the call is still made, so the code path is
   the same in every config. *)
let work n =
  let r = ref 0 in
  for i = 1 to n do
    r := Sys.opaque_identity (!r + i)
  done;
  !r

(* Nanoseconds per iteration of [work], measured on a worker domain (the same
   kind of domain the benchmark uses). One discarded sample, then the median
   of five. Note the result depends on the core the domain lands on and on
   current frequency. *)
let calibrate () =
  let iters = 20_000_000 in
  let sample () =
    let secs, _ = Harness.run ~domains:1 (fun _ -> ignore (work iters)) in
    secs *. 1e9 /. float_of_int iters
  in
  ignore (sample ());
  let samples = List.init 5 (fun _ -> sample ()) in
  fst (Harness.median_and_iqr samples)

(* Ops per domain depends only on the work size, so every variant and domain
   count at the same work size does the same amount of work per domain.
   Aims for roughly 100 ms per uncontended run, within bounds. *)
let ops_for work_ns =
  let target_ns = 100_000_000 in
  let per_op_ns = work_ns + 20 in
  max 100_000 (min 2_000_000 (target_ns / per_op_ns))

type config = {
  variant : string;
  m : (module Counter.S);
  domains : int;
  work_ns : int;
  work_iters : int;
  ops : int;
}

type outcome = { seconds : float; retries : int }

let one_run (cfg : config) : outcome =
  let (module C : Counter.S) = cfg.m in
  let t = C.create () in
  let ops = cfg.ops and work_iters = cfg.work_iters in
  let worker _id =
    let retries = ref 0 in
    let w0 = Gc.minor_words () in
    for _ = 1 to ops do
      retries := !retries + C.incr t;
      ignore (work work_iters)
    done;
    let w1 = Gc.minor_words () in
    (!retries, w1 -. w0)
  in
  let seconds, results = Harness.run ~domains:cfg.domains worker in
  (* Checks happen here, on the main domain, after the join. *)
  List.iter
    (fun (_, alloc) ->
      if alloc <> 0. then
        failwith
          (Printf.sprintf "[%s] allocated %.0f minor words in the hot loop"
             cfg.variant alloc))
    results;
  let expected = cfg.domains * ops in
  let actual = C.get t in
  if actual <> expected then
    failwith
      (Printf.sprintf "[%s] lost updates: expected %d, counter is %d"
         cfg.variant expected actual);
  { seconds; retries = List.fold_left (fun a (r, _) -> a + r) 0 results }

let shuffle rng a =
  for i = Array.length a - 1 downto 1 do
    let j = Random.State.int rng (i + 1) in
    let tmp = a.(i) in
    a.(i) <- a.(j);
    a.(j) <- tmp
  done

let columns =
  [
    "variant"; "domains"; "work_ns"; "work_iters"; "ns_per_iter";
    "ops_per_domain"; "rep"; "seconds"; "ops_per_sec"; "total_retries";
    "retries_per_op";
  ]

let () =
  let ns_per_iter = calibrate () in
  Printf.eprintf "calibration: %.4f ns per work iteration\n%!" ns_per_iter;
  let configs =
    List.concat_map
      (fun (variant, m) ->
        List.concat_map
          (fun domains ->
            List.map
              (fun work_ns ->
                let work_iters =
                  if work_ns = 0 then 0
                  else
                    max 1
                      (int_of_float
                         (Float.round (float_of_int work_ns /. ns_per_iter)))
                in
                { variant; m; domains; work_ns; work_iters;
                  ops = ops_for work_ns })
              work_ns_list)
          domain_counts)
      variants
    |> Array.of_list
  in
  let rng = Random.State.make [| shuffle_seed |] in
  let path = Harness.results_path ~bench:"counter" in
  let rows = ref [] in
  let flush () =
    (* Also runs when a check fails, so partial data is not lost. *)
    Harness.write_csv ~path ~columns (List.rev !rows);
    Printf.eprintf "wrote %s\n%!" path
  in
  let record cfg rep o =
    let total_ops = cfg.domains * cfg.ops in
    rows :=
      [
        cfg.variant;
        string_of_int cfg.domains;
        string_of_int cfg.work_ns;
        string_of_int cfg.work_iters;
        Harness.fmt_float ns_per_iter;
        string_of_int cfg.ops;
        string_of_int rep;
        Harness.fmt_float o.seconds;
        Harness.fmt_float (float_of_int total_ops /. o.seconds);
        string_of_int o.retries;
        Harness.fmt_float (float_of_int o.retries /. float_of_int total_ops);
      ]
      :: !rows
  in
  Fun.protect ~finally:flush (fun () ->
      Printf.eprintf "warm-up pass over %d configs\n%!" (Array.length configs);
      Array.iter (fun c -> ignore (one_run c)) configs;
      for rep = 1 to rep_runs do
        let order = Array.copy configs in
        shuffle rng order;
        Array.iter (fun c -> record c rep (one_run c)) order;
        Printf.eprintf "round %d/%d done\n%!" rep rep_runs
      done)
