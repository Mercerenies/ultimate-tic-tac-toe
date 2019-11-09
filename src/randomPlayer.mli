
type state = Random.State.t

val initial_state : unit -> state

val decide_move : Game.player -> Move.t -> state -> Move.legalpos * state
