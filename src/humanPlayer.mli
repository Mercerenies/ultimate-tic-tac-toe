
type state = unit

val initial_state : state

val decide_move : Game.player -> Move.t -> state -> Move.legalpos * state
