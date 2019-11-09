
module type DepthCfg = sig
  val depth : int
end

module Make (Depth : DepthCfg) : sig
  type state = unit

  val initial_state : unit -> state

  val decide_move : Game.player -> Move.t -> state -> Move.legalpos * state

end
