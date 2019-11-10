
module type GameRules = Minimax.GameRules

module Make (Rules : GameRules) : sig

  val determine_best_move : int -> Minimax.player -> Rules.state -> Rules.move option * int

end
