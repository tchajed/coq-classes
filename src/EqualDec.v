From Coq Require Import ProofIrrelevance.
From Coq Require Import String.

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

Hint Extern 2 (EqualDec _) => hnf; decide equality : typeclass_instances.

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

(* TODO: this could be much more efficient if it first did all the computation
and then produced the proof, opaquely *)

Definition ascii_cmp (x y: Ascii.ascii) : bool :=
  match x, y with
  | Ascii.Ascii x0 x1 x2 x3 x4 x5 x6 x7,
    Ascii.Ascii y0 y1 y2 y3 y4 y5 y6 y7 =>
    Bool.eqb x0 y0 &&
             Bool.eqb x1 y1 &&
             Bool.eqb x2 y2 &&
             Bool.eqb x3 y3 &&
             Bool.eqb x4 y4 &&
             Bool.eqb x5 y5 &&
             Bool.eqb x6 y6 &&
             Bool.eqb x7 y7
  end.

Ltac noteq := inversion 1; congruence.

Theorem ascii_cmp_ok : forall x y,
    if ascii_cmp x y then x = y else x <> y.
Proof.
  destruct x as [x0 x1 x2 x3 x4 x5 x6 x7], y as [y0 y1 y2 y3 y4 y5 y6 y7];
    simpl.
  destruct (Bool.eqb_spec x0 y0); [ | noteq ].
  destruct (Bool.eqb_spec x1 y1); [ | noteq ].
  destruct (Bool.eqb_spec x2 y2); [ | noteq ].
  destruct (Bool.eqb_spec x3 y3); [ | noteq ].
  destruct (Bool.eqb_spec x4 y4); [ | noteq ].
  destruct (Bool.eqb_spec x5 y5); [ | noteq ].
  destruct (Bool.eqb_spec x6 y6); [ | noteq ].
  destruct (Bool.eqb_spec x7 y7); [ | noteq ].
  simpl; f_equal; auto.
Qed.

Instance ascii_eq_dec : EqualDec Ascii.ascii.
Proof.
  hnf; intros.
  pose proof (ascii_cmp_ok x y).
  destruct (ascii_cmp x y); auto.
Defined.

Instance string_eq_dec : EqualDec string.
Proof.
  hnf; decide equality.
  destruct (equal a a0); auto.
Defined.
