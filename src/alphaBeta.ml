
open Batteries
open Minimax

module type GameRules = Minimax.GameRules

type 'a fold_state = {
    move: 'a;
    value: int;
    alpha: int;
    beta: int;
  }

let should_abort fs = fs.alpha >= fs.beta

let merge_alpha_beta player value alpha beta = match player with
    Min -> (alpha, min value beta)
  | Max -> (max value alpha, beta)

module Make (Rules : GameRules) = struct

  let rec value_of_move depth player state x =
    snd @@ determine_best_move (depth - 1) (other player) (Rules.simulate_move x state)

  and merge depth player state curr x =
    if should_abort curr then
      curr
    else
      let value = value_of_move depth player state x in
      let alpha, beta = merge_alpha_beta player value curr.alpha curr.beta in
      if criterion player value curr.value then
        { move=x; value=value; alpha=alpha; beta=beta }
      else
        { move=curr.move; value=curr.value; alpha=alpha; beta=beta }

  and determine_best_move depth player state =
    if depth <= 0 || Rules.is_terminal state then
      (* There are no longer any choices to be made, so return the
         state's value *)
       (None, Rules.heuristic_value state)
    else
      match Rules.legal_moves player state with
        [] -> failwith "No legal moves in Minimax analysis"
      | (x :: xs) ->
         let starting_condition = {
             move=x;
             value=value_of_move depth player state x;
             alpha=min_int;
             beta=max_int;
           } in
         let result = List.fold_left (merge depth player state) starting_condition xs in
         (Some result.move, result.value)

end
