
open Batteries

type player = Min | Max

let other p = match p with
    Min -> Max
  | Max -> Min

let criterion p = match p with
    Min -> ( < )
  | Max -> ( > )

module type GameRules = sig
  type state
  type move

  val is_terminal : state -> bool

  val legal_moves : player -> state -> move list

  val simulate_move : move -> state -> state

  val heuristic_value : state -> int

end

module Make (Rules : GameRules) = struct

  let rec value_of_move depth player state x =
    snd @@ determine_best_move (depth - 1) (other player) (Rules.simulate_move x state)

  and merge depth player state (x, value) x' =
    let value' = value_of_move depth player state x' in
    if criterion player value' value then
      (x', value')
    else
      (x, value)

  and determine_best_move depth player state =
    if depth <= 0 || Rules.is_terminal state then
      (* There are no longer any choices to be made, so return the
         state's value *)
       (None, Rules.heuristic_value state)
    else
      match Rules.legal_moves player state with
        [] -> failwith "No legal moves in Minimax analysis"
      | (x :: xs) ->
         List.fold_left (merge depth player state) (x, value_of_move depth player state x) xs |>
           Tuple2.map1 Option.some

end
