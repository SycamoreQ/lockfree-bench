(* Correctness tests for every Counter variant.

   For each variant and each domain count we check:
   1. final value = domains * ops              (no lost updates)
   2. zero minor-heap allocation in the loop   (measured inside each worker,
                                                around the whole loop)
   3. retries = 0 when there is one domain     (nothing to contend with)

   Retry counts at >1 domains are printed, not asserted: they are
   nondeterministic. Eyeball that they grow with the domain count. *)

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

let ops = 200_000

(* 1, 2, 4 and the recommended count, deduplicated, never above the
   recommended count (oversubscribing makes spinlock runs misleading). *)
let domain_counts () =
  let rec_count = Domain.recommended_domain_count () in
  List.sort_uniq compare [ 1; 2; 4; rec_count ]
  |> List.filter (fun d -> d <= rec_count)

type worker_result = { retries : int; alloc_words : float }

let run_variant (module C : Counter.S) ~domains =
  let t = C.create () in
  let arrived = Atomic.make 0 in
  let worker () =
    (* Barrier: maximise overlap between domains. *)
    Atomic.incr arrived;
    while Atomic.get arrived < domains do
      Domain.cpu_relax ()
    done;
    let retries = ref 0 in
    let w0 = Gc.minor_words () in
    for _ = 1 to ops do
      retries := !retries + C.incr t
    done;
    let w1 = Gc.minor_words () in
    (* The record is allocated after the measurement. *)
    { retries = !retries; alloc_words = w1 -. w0 }
  in
  let results =
    List.init domains (fun _ -> Domain.spawn worker) |> List.map Domain.join
  in
  let final = C.get t in
  let total_retries = List.fold_left (fun a r -> a + r.retries) 0 results in
  let max_alloc =
    List.fold_left (fun a r -> Float.max a r.alloc_words) 0. results
  in
  (final, total_retries, max_alloc)

let () =
  let failures = ref 0 in
  let fail fmt =
    Printf.ksprintf
      (fun s ->
        incr failures;
        Printf.printf "    FAIL: %s\n%!" s)
      fmt
  in
  Printf.printf "ops per domain = %d, recommended domains = %d\n%!" ops
    (Domain.recommended_domain_count ());
  List.iter
    (fun (name, m) ->
      List.iter
        (fun domains ->
          let final, retries, alloc = run_variant m ~domains in
          let expected = domains * ops in
          Printf.printf "%-12s domains=%-2d final=%-9d retries=%-10d alloc_words=%.0f\n%!"
            name domains final retries alloc;
          if final <> expected then
            fail "%s: final=%d expected=%d (lost updates)" name final expected;
          if alloc <> 0. then
            fail "%s: allocated %.0f minor words in the hot loop" name alloc;
          if domains = 1 && retries <> 0 then
            fail "%s: %d retries with a single domain" name retries)
        (domain_counts ()))
    variants;
  if !failures > 0 then begin
    Printf.printf "\n%d check(s) failed\n%!" !failures;
    exit 1
  end
  else Printf.printf "\nall checks passed\n%!"
