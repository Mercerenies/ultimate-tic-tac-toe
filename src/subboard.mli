
open Pos

type t

val make : Board.t -> pos -> t

val board : t -> Board.t

val pos : t -> pos

val get : t -> pos -> tic

val set : t -> pos -> tic -> t
