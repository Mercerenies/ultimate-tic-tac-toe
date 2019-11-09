
module type DepthCfg = sig
  val depth : int
end

module MinimaxData = Minimax.Make(TicTacToeRules)

module Make (Depth : DepthCfg) = struct
  type state = unit

  let initial_state () = ()

  let decide_move player move () =
    let (move, _) = MinimaxData.determine_best_move
                      Depth.depth
                      (TicTacToeRules.mplayer_of_gplayer player)
                      move in
    match move with
      None -> failwith "Invalid game position; should have already ended"
    | Some move -> (fst move, ())
end
