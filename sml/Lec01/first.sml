(* This is comment. (* this is nested comments *) *)

(* static env:  {}
   dynamic env:  {} 
*)

val x = 42
(*
* type-checking:  static env  {x: int}
* evaluation:    dynamic env  {x: 42}
*)

val y = 30
(*
* type-checking:  static env  {x: int, y: int}
* evaluation:    dynamic env {x:42, y:30}
*)

val z = (x+y) * (x-y)
(*
* type-checking:  static env {x: int, y: int, z: int} 
* evaluation:    dynamic env {x:42, y:30, z:864}
*)

val abs_of_z = if z > 0 then z else 0 - z
(*
* type-checking:  static env {x: int, y: int, z: int, abs_of_z: int}
* evaluation:    dynamic env {x:42, y:30, z:864, abs_of_z:864}
*)

val abs_of_z_simpler = abs z
(*
* type-checking:  static env {~, abs_of_z_simpler: int}
* evaluation:    dynamic env {abs_of_z_simpler:864}
*)


