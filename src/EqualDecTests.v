From Classes Require Import EqualDec.

Axiom int : Type.
Axiom toNat : int -> nat.
Axiom toNat_inj : forall x y, toNat x = toNat y -> x = y.

Instance int_eqdec : EqualDec int.
Proof.
  apply (inj_eq_dec toNat); auto using toNat_inj.
Defined.
