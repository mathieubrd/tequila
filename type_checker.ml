open Types  ;;
open Output ;;
open Tools  ;;

exception Type_error of string ;;

let type_of_term term =
  let rec aux ctx term =
    match term with
    | True ->
      Bool

    | False ->
      Bool

    | Zero ->
      Nat

    | LetIn (var, t1, t2) ->
      let ctx = (var, (aux ctx t1)) :: ctx in
      aux ctx t2

    | Alias (var, t1) ->
      aux ctx t1

    | Cond (t1, t2, t3) ->
      let type_t1 = aux ctx t1 in
      let type_t2 = aux ctx t2 in
      let type_t3 = aux ctx t3 in
      if type_t1 = Bool then
        if type_t2 = type_t3 then
          type_t2
        else
          raise (Type_error (string_of_type_error type_t3 type_t2))
      else
        raise (Type_error (string_of_type_error type_t1 Bool))

    | IsZero t ->
      if aux ctx t = Nat then
        Bool
      else
        raise (Type_error (string_of_type_error (aux ctx t) Nat))

    | Succ t ->
      if aux ctx t = Nat then
        Nat
      else
        raise (Type_error (string_of_type_error (aux ctx t) Nat))

    | Pred t ->
      if aux ctx t = Nat then
        Nat
      else
        raise (Type_error (string_of_type_error (aux ctx t) Nat))

    | Variable (var) ->
      let rec aux ctx =
        match ctx with
        | (x, y) :: tl when x = var -> y
        | hd :: tl                  -> aux tl
        | _                         -> raise(Type_error "Var Type Error")
      in
      aux ctx

    | Abstraction (var, typ, t1) ->
      let ctx = (var, typ) :: ctx in
      TAbs (typ, aux ctx t1)

    | Application (t1, t2) ->
      let type_t1 = aux ctx t1 in
      let type_t2 = aux ctx t2 in
      (match type_t1 with
      | TAbs (t11, t12) when t11 = type_t2 ->
        t12
      | _                                  ->
        raise (Type_error (string_of_type_error type_t2 type_t1)))
  in

  aux [] term
;;
