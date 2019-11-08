
open Pos

type t = Subboard of Board.t * pos

let make b p = Subboard (b, p)

let board (Subboard (b, _)) = b

let pos (Subboard (_, p)) = p

let get (Subboard (b, p)) p' = Board.get b (p, p')

let set (Subboard (b, p)) p' tic = Subboard (Board.set b (p, p') tic, p)
