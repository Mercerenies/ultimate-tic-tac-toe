
type tic = Empty | X | O

type hpos = Left | Center | Right

type vpos = Top | Middle | Bottom

type pos = Pos of hpos * vpos

let index_of_hpos h =
  match h with
    Left   -> 0
  | Center -> 1
  | Right  -> 2

let hpos_of_index n =
  match n with
    0 -> Left
  | 1 -> Center
  | 2 -> Right
  | _ -> invalid_arg "Index out of bounds hpos_of_index"

let index_of_vpos v =
  match v with
    Top    -> 0
  | Middle -> 1
  | Bottom -> 2

let vpos_of_index n =
  match n with
    0 -> Top
  | 1 -> Middle
  | 2 -> Bottom
  | _ -> invalid_arg "Index out of bounds hpos_of_index"

let index_of_pos (Pos (h, v)) =
  index_of_hpos h * 3 + index_of_vpos v

let pos_of_index n =
  Pos (hpos_of_index (n / 3), vpos_of_index (n mod 3))
