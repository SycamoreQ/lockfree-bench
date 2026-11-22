open Arena_1

let n = 20_000_000

let time_ns f =
  let t0 = Mtime_clock.elapsed_ns () in
  f ();
  Int64.to_float (Int64.sub (Mtime_clock.elapsed_ns ()) t0)

let loop c = for _ = 1 to n do ignore (Counter.Faa.incr c) done
let per_op ns = ns /. float_of_int n

let () =
  (* A: only the main domain exists *)
  let a = time_ns (fun () -> loop (Counter.Faa.create ())) in
  (* B: loop runs on a spawned worker; main waits in join *)
  let b =
    Domain.join (Domain.spawn (fun () ->
      time_ns (fun () -> loop (Counter.Faa.create ()))))
  in
  (* C: loop runs on main while a second domain is alive and idle *)
  let stop = Atomic.make false in
  let idle = Domain.spawn (fun () ->
    while not (Atomic.get stop) do Domain.cpu_relax () done) in
  let c = time_ns (fun () -> loop (Counter.Faa.create ())) in
  Atomic.set stop true;
  Domain.join idle;
  Printf.printf "A main only:          %.2f ns/op\n" (per_op a);
  Printf.printf "B spawned worker:     %.2f ns/op\n" (per_op b);
  Printf.printf "C main + idle domain: %.2f ns/op\n" (per_op c)
