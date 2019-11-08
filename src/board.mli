
type tic = Empty | X | O

type hpos = Left | Center | Right

type vpos = Top | Middle | Bottom

type pos = Pos of hpos * vpos

type t

val total_cells : int

val init : (pos * pos -> tic) -> t

val empty : t

val get : t -> pos * pos -> tic

val set : t -> pos * pos -> tic -> t
