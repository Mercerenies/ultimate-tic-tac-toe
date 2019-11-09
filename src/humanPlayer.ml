
open Printf

open Pos

type state = unit

let initial_state () = ()

let digit_string_of_pos (Pos (h, v), Pos (h', v')) =
  let hvalue = 1 + index_of_hpos h * 3 + index_of_hpos h' in
  let vvalue = 1 + index_of_vpos v * 3 + index_of_vpos v' in
  string_of_int (hvalue * 10 + vvalue)

let parse_user_input str =
  match int_of_string_opt str with
    None -> None
  | Some n ->
     try
       let x, y = n / 10, n mod 10 in
       let h, h' = match x with
           1 -> (Left, Left)
         | 2 -> (Left, Center)
         | 3 -> (Left, Right)
         | 4 -> (Center, Left)
         | 5 -> (Center, Center)
         | 6 -> (Center, Right)
         | 7 -> (Right, Left)
         | 8 -> (Right, Center)
         | 9 -> (Right, Right)
         | _ -> failwith "Invalid x input" in
       let v, v' = match y with
           1 -> (Top, Top)
         | 2 -> (Top, Middle)
         | 3 -> (Top, Bottom)
         | 4 -> (Middle, Top)
         | 5 -> (Middle, Middle)
         | 6 -> (Middle, Bottom)
         | 7 -> (Bottom, Top)
         | 8 -> (Bottom, Middle)
         | 9 -> (Bottom, Bottom)
         | _ -> failwith "Invalid y input" in
       Some (Pos (h, v), Pos (h', v'))
     with Failure _ -> None

let decide_move p state () =
  print_endline (State.to_string state.Move.state);
  printf "%c's turn\n" (char_of_tic (Game.tic_of_player p));
  begin
    match state.Move.last_move with
      None -> ()
    | Some x ->
       printf "Last move was %s\n" (digit_string_of_pos x);
  end;
  let valid_moves = Util.list_of_seq (Move.legal_moves state) in
  let rec get_input () =
    print_endline "Enter move of the form XY:";
    let input = read_line () in
    match parse_user_input input with
      None ->
        print_endline "Invalid. Try again";
        get_input ()
    | Some p ->
       match List.find_opt (fun p' -> Move.pos_of_legalpos p' = p) valid_moves with
           None ->
             print_endline "Illegal move. Try again";
             get_input ()
         | Some x -> x
  in
  let move = get_input () in
  (move, ())
