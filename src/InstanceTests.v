From Classes Require Import Classes.

Module DefaultTests.
  Definition test1 : nat := default.
  Definition test2 : nat * nat := default.

  Inductive unit' := tt'.
  Definition test3 : unit' := default.

  Record many_things :=
    { a: nat;
      b: unit;
      c: nat * list nat; }.

  Definition test4 : many_things := default.
End DefaultTests.

Module TestUnitEq.
  Import EqualDecNotation.

  (* unit EqualDec instance should always reduce to [left pf] *)
  Definition test1 (x y:unit) :
    (if x == y then true else false) = true := eq_refl.
End TestUnitEq.
