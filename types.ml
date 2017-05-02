type term_type =
    | TUnit
    | Bool
    | Nat
    | TAbs of term_type * term_type
;;

type term =
    | Variable    of string
    | Abstraction of string * term_type * term
    | Application of term * term
    (* | Record      of (string * term) list *)
    | Alias       of string * term
    | LetIn       of string * term * term
    | Seq         of term * term
    | Cond        of term * term * term
    | Succ        of term
    | Pred        of term
    | IsZero      of term
    | Zero
    | True
    | False
    | Unit
;;
