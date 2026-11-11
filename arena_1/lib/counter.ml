module type S = sig
  type t

  val create : unit -> t
  val incr : t -> int
  val get : t -> int
end

(* Padded, alone-on-its-line atomic. Written as Stdlib.Atomic so a module
   named Atomic elsewhere in the project cannot shadow it. *)
let make_padded_atomic v = Stdlib.Atomic.make_contended v

(* A 33-word int array with the live value at index 16: at least 128 bytes of
   padding on each side of the value, which covers both a 64 B line (x86) and
   a 128 B line (M4), regardless of alignment. *)
let padded_words = 33
let value_idx = 16
let make_padded_cell () : int array = Array.make padded_words 0


let rec pause n =
  if n > 0 then begin
    Domain.cpu_relax ();
    pause (n - 1)
  end

(* Plain CAS loop: no pause, no backoff. Pikus-style baseline. *)
module Cas : S = struct
  type t = int Atomic.t

  let create () : t = make_padded_atomic 0

  let rec loop (a : int Atomic.t) retries =
    let old_val = Atomic.get a in
    if Atomic.compare_and_set a old_val (old_val + 1) then retries
    else loop a (retries + 1)

  let incr (t : t) = loop t 0
  let get (t : t) = Atomic.get t
end

(* CAS loop with a single constant pause after each failure. *)
module Cas_pause : S = struct
  type t = int Atomic.t

  let create () : t = make_padded_atomic 0

  let rec loop (a : int Atomic.t) retries =
    let old_val = Atomic.get a in
    if Atomic.compare_and_set a old_val (old_val + 1) then retries
    else begin
      Domain.cpu_relax ();
      loop a (retries + 1)
    end

  let incr (t : t) = loop t 0
  let get (t : t) = Atomic.get t
end

(* CAS loop with exponential backoff (1, 2, 4, ... up to max_backoff pauses). *)
module Cas_backoff : S = struct
  type t = int Atomic.t

  let max_backoff = 1024
  let create () : t = make_padded_atomic 0

  let rec loop (a : int Atomic.t) retries backoff =
    let old_val = Atomic.get a in
    if Atomic.compare_and_set a old_val (old_val + 1) then retries
    else begin
      pause backoff;
      let next = if backoff >= max_backoff then max_backoff else backoff * 2 in
      loop a (retries + 1) next
    end

  let incr (t : t) = loop t 0 1
  let get (t : t) = Atomic.get t
end

module Faa : S = struct
  type t = int Atomic.t

  let create () : t = make_padded_atomic 0

  (* No software retry loop. On x86 this is a single [lock xadd]; on arm64 it
     may be an LSE [ldadd] or an LL/SC loop depending on codegen -- check the
     asm. *)
  let incr (t : t) =
    ignore (Atomic.fetch_and_add t 1);
    0

  let get (t : t) = Atomic.get t
end


module Spin : S = struct
  type t = {
    lock : bool Atomic.t; (* padded: alone on its line *)
    data : int array; (* padded cell, value at value_idx *)
  }

  let create () =
    { lock = make_padded_atomic false; data = make_padded_cell () }

  (* Test-and-test-and-set. Returns the number of failed CAS attempts on the
     lock word. Waiting reads are plain loads with a pause. *)
  let rec acquire (lock : bool Atomic.t) fails =
    if Atomic.get lock then begin
      Domain.cpu_relax ();
      acquire lock fails
    end
    else if Atomic.compare_and_set lock false true then fails
    else acquire lock (fails + 1)

  (* Atomic.set is sequentially consistent: an [xchg] on x86. C++ would use a
     release store here. Keep this in mind when comparing against C++ results. *)
  let release (lock : bool Atomic.t) = Atomic.set lock false

  (* Index is a constant inside a 33-word array, so unsafe access is safe. *)
  let incr t =
    let fails = acquire t.lock 0 in
    Array.unsafe_set t.data value_idx (Array.unsafe_get t.data value_idx + 1);
    release t.lock;
    fails

  (* Call only after the workers have been joined (not in a timed loop). *)
  let get t =
    ignore (acquire t.lock 0);
    let v = Array.unsafe_get t.data value_idx in
    release t.lock;
    v
end

(* Named Std_mutex so it does not shadow Stdlib.Mutex for anyone who opens
   this module. The runtime allocates the mutex itself, so it cannot be
   padded; mention this as a limitation when comparing against Spin. *)
module Std_mutex : S = struct
  type t = {
    mutex : Mutex.t;
    data : int array;
  }

  let create () = { mutex = Mutex.create (); data = make_padded_cell () }

  let incr t =
    Mutex.lock t.mutex;
    Array.unsafe_set t.data value_idx (Array.unsafe_get t.data value_idx + 1);
    Mutex.unlock t.mutex;
    0

  let get t =
    Mutex.lock t.mutex;
    let v = Array.unsafe_get t.data value_idx in
    Mutex.unlock t.mutex;
    v
end
