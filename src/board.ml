
open Batteries

type tic = Empty | X | O

type hpos = Left | Center | Right

type vpos = Top | Middle | Bottom

type pos = Pos of hpos * vpos

type t = Board of tic Vect.t

let index_of_pos (Pos (h, v)) =
  let h' = match h with
      Left   -> 0
    | Center -> 1
    | Right  -> 2 in
  let v' = match v with
      Top -> 0
    | Middle -> 3
    | Bottom -> 6 in
  h' + v'

let pos_of_index n =
  if n < 0 || n >= 9 then
    invalid_arg "Index out of bounds pos_of_index";
  let h = match n mod 3 with
      0 -> Left
    | 1 -> Center
    | 2 -> Right
    | _ -> failwith "Error in pos_of_index" in
  let v = match n / 3 with
      0 -> Top
    | 1 -> Middle
    | 2 -> Bottom
    | _ -> failwith "Error in pos_of_index" in
  Pos (h, v)

let index_of_pos' (a, b) =
  index_of_pos a * 9 + index_of_pos b

let pos_of_index' n =
  (pos_of_index (n / 9), pos_of_index (n mod 9))

let total_cells = 81

let init f = Board (Vect.init total_cells (f % pos_of_index'))

let empty = init (fun _ -> Empty)

let get (Board vec) p = Vect.get vec (index_of_pos' p)

let set (Board vec) p v = Board (Vect.set vec (index_of_pos' p) v)
