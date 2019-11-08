
open Batteries

let intersperse y xs = match xs with
    [] -> []
  | (x :: xs) -> x :: List.concat (List.map (fun x1 -> [y; x1]) xs)

let merge_opt a b = match a with
    None -> b
  | Some x -> Some x

let find f s =
  try
    Some (Seq.hd (Seq.filter_map f s))
  with
    Invalid_argument _ -> None
