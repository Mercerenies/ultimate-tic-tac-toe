
open Batteries
open Printf

open Pos

type board = Board of tic Vect.t
type t = board

let index_of_pos' (a, b) =
  index_of_pos a * 9 + index_of_pos b

let pos_of_index' n =
  (pos_of_index (n / 9), pos_of_index (n mod 9))

let total_cells = 81

let init f = Board (Vect.init total_cells (f % pos_of_index'))

let empty = init (fun _ -> Empty)

let get (Board vec) p = Vect.get vec (index_of_pos' p)

let set (Board vec) p v = Board (Vect.set vec (index_of_pos' p) v)

let abstract_to_string acc =
  let hpositions = List.cartesian_product [Left; Center; Right] [Left; Center; Right] in
  let vpositions = List.cartesian_product [Top; Middle; Bottom] [Top; Middle; Bottom] in
  let row v v' = List.map (fun (h, h') -> acc (Pos (h, v), Pos (h', v'))) hpositions in
  let horiz_delim = "\n---+---+---\n" in

  let rec group3 s xs = match xs with
      (a :: b :: c :: xs) -> String.concat s [a; b; c] :: group3 s xs
    | _ -> [] in

  let lines = List.map (fun (v, v') -> row v v') vpositions in
  let lines' = lines |> List.map (List.map (char_of_tic %> String.make 1) %>
                                    group3 "" %>
                                    String.concat "|") in
  lines' |> group3 "\n" |> String.concat horiz_delim

let to_string board = abstract_to_string (get board)

module Subboard = struct
  type subboard = Subboard of board * pos
  type t = subboard

  let make b p = Subboard (b, p)
  let board (Subboard (b, _)) = b
  let pos (Subboard (_, p)) = p
  let get (Subboard (b, p)) p' = get b (p, p')
  let set (Subboard (b, p)) p' tic = Subboard (set b (p, p') tic, p)

end
