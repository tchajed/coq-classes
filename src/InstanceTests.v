From SimpleClasses Require Import Classes.

Definition __test1 : nat := default.
Definition __test2 : nat * nat := default.

Import EqualDecNotation.

(* unit EqualDec instance should always reduce to [left pf] *)
Definition __test3 (x y:unit) :
  (if x == y then true else false) = true := eq_refl.
