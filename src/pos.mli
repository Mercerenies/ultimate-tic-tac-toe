
type tic = Empty | X | O

type hpos = Left | Center | Right

type vpos = Top | Middle | Bottom

type pos = Pos of hpos * vpos

val index_of_hpos : hpos -> int

val hpos_of_index : int -> hpos

val index_of_vpos : vpos -> int

val vpos_of_index : int -> vpos

val index_of_pos : pos -> int

val pos_of_index : int -> pos

val char_of_tic : tic -> char

val all_positions : pos list
