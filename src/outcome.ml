
open Batteries

open Pos

module type HasTic = sig
  type t
  val get : t -> pos -> tic
end

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

let empty_to_none x = match x with
    Some Empty -> None
  | x -> x

module Make (Acc : HasTic) = struct

  let free_positions b =
    let positions = List.init 9 pos_of_index in
    List.filter (fun p -> Acc.get b p = Empty) positions

  let determine_winner b =
    if free_positions b = [] then
      Some Empty (* It's a tie *)
    else
      winning_sequences |>
        List.map (List.map (Acc.get b) %> all_match %> empty_to_none) |>
        List.fold_left Util.merge_opt None

end
