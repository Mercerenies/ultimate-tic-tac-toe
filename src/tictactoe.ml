
(* Compile with ocamlbuild -use-ocamlfind tictactoe.native *)

open Board
open Subboard
open Outcome
open Pos

let fn (_, Pos (x, _)) = match x with
    Left -> X
  | Center -> Empty
  | Right -> O

let () =
  let board = Board.init fn in
  print_endline (Board.to_string board);
  print_endline "Hello! :)"
