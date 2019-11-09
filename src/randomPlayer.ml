
open Batteries

type state = Random.State.t

let initial_state = Random.State.make_self_init

let decide_move _ move rand =
  let moves = Util.list_of_seq (Move.legal_moves move) in
  (List.at moves (Random.State.int rand (List.length moves)), rand)
