(* (3, true) ==> (true, 3) *)
fun swap (pr : int*int) = 
  (#2 pr, #1 pr)
(* take two pairs and return the sum of all items *)
(* sum_two_pairs( (1,2), (3,4)) --> 1+2+3+4 *)
fun sum_two_pairs(pr1: int*int, pr2: int*int)=
  (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2)

(* take two ints and returns a pair of div result and remainder *)
fun div_mod (x: int, y: int)=
  (x div y, x mod y)
(* takes a pair and returns a sorted pair *)
(* (4, 3) -> (3,4)
 * (3, 4) -> (3,4) *)
fun sort_pair (pr: int * int)=
  if (#1 pr) < (#2 pr)
  then pr
  else (#2 pr, #1 pr)
