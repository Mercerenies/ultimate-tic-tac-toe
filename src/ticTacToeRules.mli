
open Pos

type state = Move.t

type move = Move.legalpos * Game.player

val gplayer_of_mplayer : Minimax.player -> Game.player

val mplayer_of_gplayer : Game.player -> Minimax.player

val is_terminal : state -> bool

val legal_moves : Minimax.player -> state -> move list


val simulate_move : move -> state -> state

val heuristic_value : state -> int

