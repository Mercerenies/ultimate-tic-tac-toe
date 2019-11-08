
open Pos

type board
type t = board

val total_cells : int

val init : (pos * pos -> tic) -> t

val empty : t

val get : t -> pos * pos -> tic

val set : t -> pos * pos -> tic -> t

val abstract_to_string : (pos * pos -> tic) -> string

val to_string : t -> string

module Subboard : sig
  type subboard
  type t = subboard

  val make : board -> pos -> t
  val board : t -> board
  val pos : t -> pos
  val get : t -> pos -> tic
  val set : t -> pos -> tic -> t

end
