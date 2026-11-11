module type S = sig
  type t
  val create : unit -> t
  val incr : t -> int      (* returns number of failed CAS attempts / retries *)
  val get : t -> int
end

module Cas : S
module Cas_pause: S
module Cas_backoff : S
module Faa : S
module Spin : S
module Std_mutex : S
