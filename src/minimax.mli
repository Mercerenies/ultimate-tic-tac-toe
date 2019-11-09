
type player = Min | Max

val other : player -> player

val criterion : player -> int -> int -> bool

module type GameRules = sig
  type state
  type move

  val is_terminal : state -> bool

  val legal_moves : player -> state -> move list

  val simulate_move : move -> state -> state

  val heuristic_value : state -> int

end

module Make (Rules : GameRules) : sig

  val determine_best_move : int -> player -> Rules.state -> Rules.move option * int

end
