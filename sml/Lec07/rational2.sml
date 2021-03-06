signature RATIONAL_A = 
sig
datatype rational = Frac of int * int | Whole of int
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end

signature RATIONAL_B =
sig
type rational (* type now abstract *)
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end
        
structure Rational1 :> RATIONAL_B = 
struct

(* Invariant 1: all denominators > 0
   Invariant 2: rationals kept in reduced form *)

  datatype rational = Whole of int | Frac of int*int
  exception BadFrac

(* gcd and reduce help keep fractions reduced, 
   but clients need not know about them *)
(* they _assume_ their inputs are not negative *)
  fun gcd (x,y) =
       if x=y
       then x
       else if x < y
       then gcd(x,y-x)
       else gcd(y,x)

   fun reduce r =
       case r of
           Whole _ => r
         | Frac(x,y) => 
           if x=0
           then Whole 0
           else let val d = gcd(abs x,y) in (* using invariant 1 *)
                    if d=y 
                    then Whole(x div d) 
                    else Frac(x div d, y div d) 
                end

(* when making a frac, we forbid zero denominators *)
   fun make_frac (x,y) =
       if y = 0
       then raise BadFrac
       else if y < 0
       then reduce(Frac(~x,~y))
       else reduce(Frac(x,y))

(* using math properties, both invariants hold of the result
   assuming they hold of the arguments *)
   fun add (r1,r2) = 
       case (r1,r2) of
           (Whole(i),Whole(j))   => Whole(i+j)
         | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
         | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
         | (Frac(a,b),Frac(c,d)) => reduce (Frac(a*d + b*c, b*d))

(* given invariant, prints in reduced form *)
   fun toString r =
       case r of
           Whole i => Int.toString i
         | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)

end

(* this structure can have all three signatures we gave
   Rationa1, and/but it is /equivalent/ under signatures 
   RATIONAL_B and RATIONAL_C 

   this structure does not reduce fractions until printing
*)

(* Invariant 1: all denominators > 0
   Invariant 2: toString gives a reduced representation of
                the rational number*)

structure Rational2 :> RATIONAL_B =
struct


  datatype rational = Whole of int | Frac of int*int 
  exception BadFrac

  (* make_frac and add *)
   fun make_frac (x,y) =
       if y = 0
       then raise BadFrac
       else if y < 0
       then Frac(~x,~y)
       else Frac(x,y)

(* using math properties, both invariants hold of the result
   assuming they hold of the arguments *)
   fun add (r1,r2) = 
       case (r1,r2) of
           (Whole(i),Whole(j))   => Whole(i+j)
         | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
         | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
         | (Frac(a,b),Frac(c,d)) => (Frac(a*d + b*c, b*d))


  (* toString (frac is reduced here) *)
   fun toString r =
   let 
      fun gcd (x,y) =
           if x=y
           then x
           else if x < y
           then gcd(x,y-x)
           else gcd(y,x)
       fun reduce r =
           case r of
               Whole _ => r
             | Frac(x,y) => 
               if x=0
               then Whole 0
               else let val d = gcd(abs x,y) in (* using invariant 1 *)
                        if d=y 
                        then Whole(x div d) 
                        else Frac(x div d, y div d) 
                    end
   in
       case __________  of
            Whole x => Int.toString x
          | Frac(x, y) => Int.toString x ^ "/" ^ Int.toString y
   end
end
