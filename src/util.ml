
let intersperse y xs = match xs with
    [] -> []
  | (x :: xs) -> x :: List.concat (List.map (fun x1 -> [y; x1]) xs)
