
open Pos

module type HasTic = sig
  type t
  val get : t -> pos -> tic
end

(* As a note, None means there is no winner yet. X or O means that
   player won. Empty is a draw. *)
module Make (Acc : HasTic) : sig
  val free_positions : Acc.t -> pos list
  val determine_winner : Acc.t -> tic option
end
