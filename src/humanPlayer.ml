
type state = unit

let initial_state = ()

let decide_move p { Move.state=state; Move.last_move=prev } () =
  print_endline (State.to_string state);
  failwith "I'm not done implementing this yet :)"
