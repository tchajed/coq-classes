From Coq Require Import ProofIrrelevance.

Class EqualDec A :=
  equal : forall x y : A, { x = y } + { x <> y }.

Module EqualDecNotation.
  Infix "==" := (equal) (no associativity, at level 70).
End EqualDecNotation.

(* For unit, an explicit definition has better computational behavior.
Specifically it is syntactically a [left], so any matches on [u == u']
automatically reduce to the true case; [decide equality] would first destruct
the arguments before producing [left]. *)
Instance unit_equal_dec : EqualDec unit :=
  fun x y => left (match x, y with
                | tt, tt => eq_refl
                end).

Hint Extern 3 (EqualDec _) => hnf; decide equality : typeclass_instances.

Instance nat_equal_dec : EqualDec nat := _.
Instance bool_equal_dec : EqualDec bool := _.

Instance sigT_eq_dec A (P: A -> Prop) (dec:EqualDec A) : EqualDec (sig P).
Proof.
  hnf; intros.
  destruct x as [x ?], y as [y ?].
  destruct (equal x y); subst; [ left | right ].
  - f_equal.
    apply proof_irrelevance.
  - intro.
    inversion H; congruence.
Qed.
