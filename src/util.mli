
open Batteries

val intersperse : 'a -> 'a list -> 'a list

val merge_opt : 'a option -> 'a option -> 'a option

val find : ('a -> 'b option) -> 'a Seq.t -> 'b option
