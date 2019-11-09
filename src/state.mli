
open Pos

type state
type t = state

val state_of_board : Board.t -> t

val init : (pos * pos -> tic) -> t

val empty : t

val board : t -> Board.t

val get : t -> pos * pos -> tic

val set : t -> pos * pos -> tic -> t

val get_outcome : t -> pos -> tic option

val to_string : t -> string

(* For compatibility with Outcome. The "larger" grid can have its
   outcomes computed with this. *)
module OutcomeGrid : sig
  type t = state
  val get : t -> pos -> tic
end

val whole_outcome : t -> tic option
