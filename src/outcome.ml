
open Batteries

open Pos

module type HasTic = sig
  type t
  val get : t -> pos -> tic
end

let first_nonempty x y = match x with
    Empty -> y
  | _     -> x

let all_match xs = match xs with
    [] -> None
  | (x :: xs) -> if List.for_all (( = ) x) xs then Some x else None

let winning_sequences = [
    (* Horizontal *)
    [Pos (Left, Top); Pos (Center, Top); Pos (Right, Top)];
    [Pos (Left, Middle); Pos (Center, Middle); Pos (Right, Middle)];
    [Pos (Left, Bottom); Pos (Center, Bottom); Pos (Right, Bottom)];
    (* Vertical *)
    [Pos (Left, Top); Pos (Center, Middle); Pos (Left, Bottom)];
    [Pos (Center, Top); Pos (Center, Middle); Pos (Center, Bottom)];
    [Pos (Right, Top); Pos (Right, Middle); Pos (Right, Bottom)];
    (* Diagonal *)
    [Pos (Left, Top); Pos (Center, Middle); Pos (Right, Bottom)];
    [Pos (Right, Top); Pos (Center, Middle); Pos (Left, Bottom)];
  ]

module Make (Acc : HasTic) = struct

  let determine_winner b =
    winning_sequences |>
      List.map (List.map (Acc.get b) %> all_match %> Option.default Empty) |>
      List.fold_left first_nonempty Empty

end
