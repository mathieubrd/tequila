open Types ;;

let rec substitute x s term =
  match term with
    | Variable (var) when var = x -> s

    | Abstraction (var, typ, t1) when var <> x ->
      Abstraction(var, typ, (substitute x s t1))

    | Application (t1, t2) ->
      Application((substitute x s t1), (substitute x s t2))

    | LetIn (var, t1, t2) ->
      LetIn (var, substitute x s t1, substitute x s t2)

    | Succ (t1) ->
      Succ (substitute x s t1)

    | Pred (t1) ->
      Pred (substitute x s t1)

    | IsZero (t1) ->
      IsZero (substitute x s t1)

    | Cond (t1, t2, t3) ->
      Cond (substitute x s t1, substitute x s t2, substitute x s t3)

    | _ -> term
;;


let rec is_numeric_val term =
  match term with
  | Zero        -> true
  | Succ (t1)   -> is_numeric_val t1
  | _           -> false
;;

let is_val term =
  match term with
    | Abstraction (var, typ, term) -> true
    | Alias (var, t1)              -> true
    | Unit                         -> true
    | True                         -> true
    | False                        -> true
    | _                            -> is_numeric_val term
;;

let is_closed term =
  let rec aux term bound_vars =
    match term with
    | Variable (var) ->
      List.mem var bound_vars

    | Abstraction (var, typ, t1) ->
      aux t1 (var :: bound_vars)

    | Succ t ->
      aux t bound_vars

    | Pred t ->
      aux t bound_vars

    | IsZero t ->
      aux t bound_vars

    | Cond (t1, t2, t3) ->
      aux t1 bound_vars && aux t2 bound_vars && aux t3 bound_vars

    | Application (t1, t2) ->
      aux t1 bound_vars && aux t2 bound_vars

    | LetIn (var, t1, t2) ->
      let bound_vars = var :: bound_vars in
      aux t1 bound_vars && aux t2 bound_vars

    | Alias(var, t1) ->
      aux t1 bound_vars

    | _ ->
      true
  in
  aux term []
;;
