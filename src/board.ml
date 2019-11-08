
open Batteries

open Pos

type t = Board of tic Vect.t

let index_of_pos' (a, b) =
  index_of_pos a * 9 + index_of_pos b

let pos_of_index' n =
  (pos_of_index (n / 9), pos_of_index (n mod 9))

let total_cells = 81

let init f = Board (Vect.init total_cells (f % pos_of_index'))

let empty = init (fun _ -> Empty)

let get (Board vec) p = Vect.get vec (index_of_pos' p)

let set (Board vec) p v = Board (Vect.set vec (index_of_pos' p) v)
