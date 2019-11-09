
open Batteries

open Pos

type state = Move.t

type move = Move.legalpos * Game.player

let endgame_value = 10000

let gplayer_of_mplayer p = match p with
    Minimax.Min -> Game.P1
  | Minimax.Max -> Game.P2

let mplayer_of_gplayer p = match p with
    Game.P1 -> Minimax.Min
  | Game.P2 -> Minimax.Max

let is_terminal s = Seq.is_empty (Move.legal_moves s)

let legal_moves p s =
  let p' = gplayer_of_mplayer p in
  List.map (fun x -> (x, p')) @@ Util.list_of_seq (Move.legal_moves s)

let simulate_move (mov, p) s = Move.make_move mov (Game.tic_of_player p) s

let heuristic_value { Move.state=state; Move.last_move=prev } =
  match State.whole_outcome state with
    Some X -> - endgame_value
  | Some O ->   endgame_value
  | Some Empty -> 0
  | None ->
     (* In this case, we need to estimate *)
     10 (* ///// *)
