
open Batteries

open Pos

module SubboardOutcome = Outcome.Make(Subboard)

type state = {
    board: Board.t;
    outcomes: tic Vect.t;
  }
type t = state

let update_outcome pos state =
  let index = index_of_pos pos in
  match Vect.get state.outcomes index with
    X | O -> state
    | Empty ->
       let subboard = Subboard.make state.board pos in
       {
         board=state.board;
         outcomes=Vect.set state.outcomes index (SubboardOutcome.determine_winner subboard)
       }

let update_outcomes (state : t) =
  let positions = Array.init 9 (update_outcome % pos_of_index) in
  Array.fold_left ( |> ) state positions

let state_of_board b =
  update_outcomes {
      board=b;
      outcomes=Vect.make 9 Empty
    }

let init f = state_of_board (Board.init f)

let empty = state_of_board Board.empty

let board s = s.board

let get s p = Board.get s.board p

let set s p t =
  update_outcome (fst p) {
      board=Board.set s.board p t;
      outcomes=s.outcomes
    }

let get_outcome s p = Vect.get s.outcomes (index_of_pos p)

let to_string state =
  Board.abstract_to_string (fun (p, p') ->
      match get_outcome state p with
        Empty  -> get state (p, p')
      | result -> result
    )

module OutcomeGrid = struct
  type t = state
  let get = get_outcome
end
