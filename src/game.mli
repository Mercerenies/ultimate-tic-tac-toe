
open Pos

type player = P1 | P2

val other : player -> player

val tic_of_player : player -> tic

module type Player = sig
  type state

  val initial_state : unit -> state

  val decide_move : player -> Move.t -> state -> Move.legalpos * state

end

module Make (Player1 : Player) (Player2 : Player) : sig

  val play_game : unit -> tic * State.t

end
