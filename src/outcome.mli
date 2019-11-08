
open Pos

module type HasTic = sig
  type t
  val get : t -> pos -> tic
end

module Make (Acc : HasTic) : sig
  val determine_winner : Acc.t -> tic
end
