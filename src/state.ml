
open Batteries

open Pos

module SubboardOutcome = Outcome.Make(Subboard)

type state = {
    board: Board.t;
    outcomes: tic option Vect.t;
  }
type t = state

let update_outcome pos state =
  let index = index_of_pos pos in
  match Vect.get state.outcomes index with
    Some _ -> state
    | None ->
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
      outcomes=Vect.make 9 None
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
        None | Some Empty -> get state (p, p')
      | Some result -> result
    )

module OutcomeGrid = struct
  type t = state
  let get s p = get_outcome s p |? Empty
end

module BigOutcomeGrid = Outcome.Make(OutcomeGrid)

let free_positions s =
  let positions = List.cartesian_product all_positions all_positions in
  List.filter (fun p -> (Option.is_none (get_outcome s (fst p))) && get s p = Empty) positions

let whole_outcome s =
  match BigOutcomeGrid.determine_winner s with
    Some x -> Some x
  | None ->
     if free_positions s == [] then
       Some Empty
     else
       None
