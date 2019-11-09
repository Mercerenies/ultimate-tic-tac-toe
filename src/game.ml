
open Pos

type player = P1 | P2

let other p = match p with
    P1 -> P2
  | P2 -> P1

let tic_of_player p = match p with
    P1 -> X
  | P2 -> O

module type Player = sig
  type state

  val initial_state : unit -> state

  val decide_move : player -> Move.t -> state -> Move.legalpos * state

end

module Make (Player1 : Player) (Player2 : Player) = struct

  let rec turn_of_game turn s1 s2 state =
    let next_move, s1, s2 = match turn with
        P1 -> let m, s = Player1.decide_move P1 state s1 in m, s, s2
      | P2 -> let m, s = Player2.decide_move P2 state s2 in m, s1, s in
    let state = Move.make_move next_move (tic_of_player turn) state in
    let open Move in
    match State.whole_outcome state.state with
      None -> turn_of_game (other turn) s1 s2 state
    | Some x -> (x, state.state)

  let play_game () =
    let s1 = Player1.initial_state () in
    let s2 = Player2.initial_state () in
    let move = { Move.state=State.empty; Move.last_move=None } in
    turn_of_game P1 s1 s2 move


end
