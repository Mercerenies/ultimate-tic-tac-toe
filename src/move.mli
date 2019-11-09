
open Batteries

open Pos

type t = {
    state: State.t;
    last_move: (pos * pos) option;
  }

type legalpos

val pos_of_legalpos : legalpos -> pos * pos

val is_free_play : t -> bool

val is_legal_move : t -> pos * pos -> legalpos option

val legal_moves : t -> legalpos Seq.t

val make_move : legalpos -> tic -> t -> t
