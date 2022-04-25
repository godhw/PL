(* cond expression *)

(* if z < 0 then ~z else z *)


syntax: if e1 then e2 else e3
(* if then else --> keywords
e1, e2, e3 expressions *)

(* type checking rule:
 * if t(e1) = boolean (otherwise, type error)
 * t(e2) = t(e3)
 * then the cond expr t(e2) (or t(e3))
*)

(* evaluation rule:
 * if eval(e1) is true then eval(e2) => value of cond expr
 * false then eval(e3) => value of cond expr
*)
