
exception ListLengthMismatch;

(* ([1,2,3,4], [10,20,30,40], [100,200,300,400])
   ==> [(1,10,100), (2, 20, 200), (3, 30, 300), (4, 40, 400)]
 *)
fun zip3 (lists) = 
    case lists of
         ([],[],[]) => []
       | (x::xs, y::ys, z::zs) => (x,y,z)::zip3(xs,ys,zs)
       | _ => raise ListLengthMismatch

(* [(1,10,100), (2, 20, 200), (3, 30, 300), (4, 40, 400)]
   ==> ([1,2,3,4], [10,20,30,40], [100,200,300,400])
 *)
fun unzip3 (triples) = 
  case triples of
       [] => ([], [], [])
     | (x,y,z)::rest => let val (xs,ys,zs) = unzip3 (rest)
                        in (x::xs, y::ys, z::zs)
                        end
