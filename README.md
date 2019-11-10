
A pretty simple game. I just made this to practice a bit with OCaml.
See the rules [on
Wikipedia](https://en.wikipedia.org/wiki/Ultimate_tic-tac-toe). Right
now, it's just a simple minimax algorithm with alpha-beta pruning
that's pretty easy to beat.

If you want to play against a human (or, for that matter, a really
unintelligent random-moving AI), you can change the functor argument
in `tictactoe.ml`.

Things I'd like to do with this
 + Add command line flags so that you don't have to mess with the
   source to change AIs.
 + ✓ Alpha-beta pruning to refine the minimax algorithm a bit.
 + A Monte Carlo AI alternative to the minimax.
