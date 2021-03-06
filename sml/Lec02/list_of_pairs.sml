



(* sum all the values 
   [(1,1), (2,2), (0, 3)] ==> 1+1+2+2+0+3 = 9 *)
fun sum_pair_list (xs : (int*int) list) = 
  if null xs
  then 0
  else #1(hd xs) + #2(hd xs) + sum_pair_list(tl xs)

 (* returns first elements as a list
   [(1,2), (3,4)] ==> [1,3] *)
fun firsts (xs : (int*int) list) :int list = 
  if null xs
  then []
  else #1(hd xs) :: firsts(tl xs)

 (* returns second elements as a list
   [(1,2), (3,4)] ==> [2,4] *)
fun seconds (xs : (int*int) list):int list = 
  if null xs
  then []
  else #2(hd xs) :: seconds(tl xs)

fun sum_list (xs: int list) =
  if null xs
  then 0
  else hd xs + sum_list(tl xs)

(* use sum_list, firsts, and seconds *)
(* sum all the values 
   [(1,1), (2,2)] ==> 1+1+2+2 = 6 *)
(* firsts: int*int list -> int list
   seconds: int*int list -> int list
   sum_list: int list -> int 
   sum_pair_list2: int*int list -> int
   *)
fun sum_pair_list2 (xs : (int*int) list) =
  (sum_list (firsts xs)) + (sum_list (seconds xs))
