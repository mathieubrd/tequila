open Types ;;
open Tools ;;
open Alias ;;

let rec eval term =
  let rec aux term =
    match term with
      (* E-LetIn2 *)
      | LetIn (var, t1, t2) when is_val t1 ->
        substitute var t1 t2

      (* E-LetIn *)
      | LetIn (var, t1, t2) ->
        LetIn (var, aux t1, t2)

      (* E-Alias *)
      | Alias (var, t1) ->
        let t1 = aux t1 in
        aliases := (var, t1) :: !aliases ;
        Alias (var, t1)

      (* E-Succ *)
      | Succ (t1) when not(is_val t1) ->
        Succ (aux t1)

      (* E-PredZero *)
      | Pred (Zero) ->
        Zero

      (* E-PredSucc *)
      | Pred (Succ (t1)) ->
        t1

      (* E-Pred *)
      | Pred (t1) ->
        Pred (aux t1)

      (* E-IsZeroZero *)
      | IsZero (Zero) ->
        True

      (* E-IsZeroSucc *)
      | IsZero (Succ (t1)) ->
        False

      (* E-IsZero *)
      | IsZero (t1) ->
        IsZero (aux t1)

      (* E-IfTrue *)
      | Cond (True, t2, t3) ->
        t2

      (* E-IfFalse *)
      | Cond (False, t2, t3) ->
        t3

      (* E-If *)
      | Cond (t1, t2, t3) ->
        Cond (aux t1, t2, t3)
        
      (* E-AppAbs *)
      | Application (Abstraction (var, typ, t1), t2) when is_val t2 ->
        substitute var t2 t1

      (* E-App2   *)
      | Application (t1, t2) when is_val t1 ->
        Application (t1, aux t2)

      (* E-App1   *)
      | Application (t1, t2) ->
        Application (aux t1 , t2)

      | _ ->
        term
  in
  let term = aux term in
  if not(is_val term) then eval term else term
;;
