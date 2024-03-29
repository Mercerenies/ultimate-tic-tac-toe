
open Pos

type t

val total_cells : int

val init : (pos * pos -> tic) -> t

val empty : t

val get : t -> pos * pos -> tic

val set : t -> pos * pos -> tic -> t

val abstract_to_string : (pos * pos -> tic) -> string

val to_string : t -> string
