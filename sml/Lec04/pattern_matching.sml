
datatype suit = Club | Diamond | Heart | Spade
datatype card_value = Jack | Queen | King 
                    | Ace | Num of int
datatype card =  Card of suit * card_value

(*
datatype card = Jack of suit |
                Queen of suit |
                King of suit |
                Ace of suit |
                Num of suit * int
*)


val hands = [Card(Club, Jack), Card(Club, Num(10)), Card(Club, Ace)]
val hands2 = [Card(Club, Jack), Card(Diamond, Num(10)), Card(Club, Ace)]
val hands3 = [Card(Diamond, Num(10)), Card(Club, Ace), Card(Club, Jack)]
val hands2 = [Card(Diamond, Num(10)), Card(Club, Ace), Card(Club, Jack), Card(Spade, Ace)]

fun is_flush (hand: card list) =
    case hand of
         Card(shape, _)::[] => true
       | Card(shape, _)::Card(shape2, _)::[] => shape = shape2
       | Card(shape, _)::Card(shape2, _)::_ => shape = shape2 andalso
                                                    is_flush(tl hand)

fun hasAce (hand: card list) =
    case hand of
         Card(_, Ace)::rest => true
       | _::rest => hasAce(rest)
       | [] => false

fun removeAce (hand: card list) =
    case hand of
         Card(_, Ace)::rest => rest
       | card1 :: rest => card1::removeAce(rest)
       | [] => []

fun simpleSum(hand: card list) =
    case hand of 
          Card (_, Ace)::rest => 11 + simpleSum(rest)
        | Card (_, Num(i))::rest => i + simpleSum(rest)
        | Card (_, _)::rest => 10 + simpleSum(rest)
        | _ => 0

fun blackjack(hand: card list) =
let val sum = simpleSum(hand)
in
    if sum < 21
    then sum
    else if hasAce(hand)
         then 1+blackjack(removeAce hand)
         else sum
end

(*
fun blackjack (hand: card list) =
let fun simpleSum (hand: card list) =
        case hand of 
            Card (_, Ace)::rest => 11 + simpleSum(rest)
           | Card (_, Num(i))::rest => i + simpleSum(rest)
           | Card (_, _)::rest => 10 + simpleSum(rest)
           | _ => 0
  val score = simpleSum(hand)
in
  if score > 21 andalso hasAce hand
  then 1+blackjack(removeAce hand)
  else score
end

*)

fun blackjack (score: int, hand: card list) =
  case hand of
      Card (_, Ace)::rest => let val try1 = blackjack(score+11, rest)
                             in
                               if try1 <= 21 
                               then try1
                               else blackjack(score+1, rest)
                             end
      | Card (_, Num(i))::rest => blackjack(score+i, rest)
      | Card (_, _)::rest => blackjack(score+10, rest)
      | _ => score



fun blackjack2 (score: int, hand: card list) =
  case hand of
      Card (_, Ace)::rest => let val rest_score = blackjack2(score, rest)
                             in
                               if rest_score >= 11 
                               then rest_score+1
                               else rest_score+11
                             end
      | Card (_, Num(i))::rest => blackjack2(score+i, rest)
      | Card (_, _)::rest => blackjack2(score+10, rest)
      | _ => score

(* nice example of nested pattern.  *)

(* nondecreasing: int list -> bool
 *
 * e.g.  [1,1,2, 3, 4, 5, 5] => true
 *       [1, 2, 1, 3, 5] => false
 *)
fun nondecreasing xs =
    case xs of
	[] => true
      | x::[] => true
      | head::(neck::rest) => (head <= neck andalso nondecreasing (neck::rest))

datatype sgn = P | N | Z

(* multsign: int * int -> sgn
 *
 * e.g. 1, 1 => P
 *      ~1, 10 => N
 *      ~10, ~42 => P
 *)
fun multsign (x1,x2) = 
  let fun sign x = if x=0 then Z else if x>0 then P else N 
  in
      case (sign x1,sign x2) of
	  (Z,_) => Z
	| (_,Z) => Z
	| (P,P) => P
	| (N,N) => P
	| _     => N (* many say bad style; I am okay with it *)
  end

fun len(l: 'a list) =
    case l of
         [] => 0
       | _::xs => 1+len(xs)

