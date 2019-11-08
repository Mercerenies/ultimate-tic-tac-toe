
(* Compile with ocamlbuild -use-ocamlfind tictactoe.native *)

open Printf
open Batteries

open Board
open Subboard
open Outcome
open Pos

module SubboardOutcome = Outcome.Make(Subboard)

let fn (_, Pos (x, y)) = match x, y with
    (Left, Top) | (Right, Bottom) -> X
  | (Center, Middle) -> O
  | _ -> Empty

let () =
  let board = Board.init fn in
  let subboard = Subboard.make board (Pos (Left, Top)) in
  print_endline (Board.to_string board);
  printf "%c\n" (Pos.char_of_tic @@ SubboardOutcome.determine_winner subboard);
  print_endline "Hello! :)"
