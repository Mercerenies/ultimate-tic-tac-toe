
(* Compile with ocamlbuild -use-ocamlfind tictactoe.native *)

open Printf
open Batteries

open Pos

module SubboardOutcome = Outcome.Make(Subboard)

let fn (_, Pos (x, y)) = match x, y with
    (Left, Top) | (Right, Bottom) -> X
  | (Center, Middle) -> X
  | _ -> Empty

let () =
  let board = Board.init fn in
  let state = State.state_of_board board in
  let move = { Move.state=state; Move.last_move=Some (Pos(Left, Top), Pos(Left, Middle)) } in
  (* let subboard = Subboard.make board (Pos (Left, Top)) in *)
  print_endline (Board.to_string board);
  print_endline (State.to_string state);
  let moves = Move.legal_moves move in
  let rec print_all m = match m () with
      Seq.Nil -> ()
    | Seq.Cons (a, b) ->
       let p1, p2 = (Tuple2.map string_of_pos string_of_pos) (Move.pos_of_legalpos a) in
       printf "%s %s, " p1 p2;
       print_all b in
  print_all moves;
  (* printf "%c\n" (Pos.char_of_tic @@ SubboardOutcome.determine_winner subboard); *)
  print_endline "Hello! :)"
