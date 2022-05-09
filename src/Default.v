Class Default T := default : T.
(* should address most instances *)
Local Ltac mkDefault := unfold Default; constructor; exact default.
#[export] Hint Extern 1 (Default _) => mkDefault : typeclass_instances.

Local Notation cache_default := (ltac:(mkDefault)) (only parsing).

Instance unit_def : Default unit := cache_default.
Instance nat_def : Default nat := cache_default.
Instance list_def A : Default (list A) := cache_default.
Instance option_def A : Default (option A) := cache_default.
Instance pair_def A B (defA: Default A) (defB: Default B)
  : Default (A * B) := cache_default.
