
open Batteries

open Pos

type t = {
    state: State.t;
    last_move: pos * pos;
  }

type legalpos = { legalpos: pos * pos }

let pos_of_legalpos x = x.legalpos

let is_free_play { state; last_move } =
  Option.is_some (State.get_outcome state (snd last_move))

let is_legal_move prev next =
  let free = is_free_play prev in
  let board = State.board prev.state in
  let board_unfinished = Option.is_none (State.get_outcome prev.state (fst next)) in
  let cell_unoccupied = (Board.get board next = Empty) in
  if cell_unoccupied && board_unfinished && (free || snd prev.last_move = fst next) then
    Some { legalpos=next }
  else
    None

let legal_moves prev =
  let possible_moves = List.cartesian_product all_positions all_positions in
  Seq.filter_map (is_legal_move prev) (Seq.of_list possible_moves)
