open Types ;;
open Tools ;;

let rec string_of_type term_type =
  match term_type with
  | TUnit ->
    "Unit"

  | Bool ->
    "Bool"

  | Nat ->
    "Nat"

  | TAbs (typ1, typ2) ->
    "(" ^ string_of_type typ1 ^ " -> " ^ string_of_type typ2 ^ ")"
;;

let string_of_type_error actual_type excepted_type =
  "This expression has type " ^ string_of_type actual_type ^ " but an expression was excepted of type " ^ string_of_type excepted_type
;;

let string_of_numeric_val term =
    let rec aux term count =
        match term with
        | Zero -> string_of_int count
        | Succ (t1) -> aux t1 (count + 1)
        | Pred (t1) -> aux t1 (count - 1)
        | _ -> "0"
    in

    aux term 0
;;

let rec string_of_term term =
  match term with
    | Unit ->
      "unit"

    | True ->
      "true"

    | False ->
      "false"

    | Zero ->
      string_of_numeric_val Zero

    | Succ (t1) ->
      let t1 = Succ (t1) in
      string_of_numeric_val t1

    | Pred (t1) ->
      let t1 = Pred (t1) in
      string_of_numeric_val t1

    | IsZero (t1) when is_val t1 ->
      "iszero (" ^ string_of_term t1 ^ ")"

    | IsZero(t1) ->
      "iszero (" ^ string_of_term t1 ^ ")"

    | Cond (t1, t2, t3) ->
      "if " ^ string_of_term t1 ^ " then " ^ string_of_term t2 ^ " else " ^ string_of_term t3

    | Abstraction (var, typ, t1) ->
      "λ" ^ var ^ " : " ^ string_of_type typ ^ ". " ^ string_of_term t1

    | Application (Abstraction(var, typ, t1), t2) ->
      "(λ" ^ var ^ ": " ^ string_of_type typ ^ ". " ^ string_of_term t1 ^ ") " ^ string_of_term t2

    | Application (t1, t2) ->
      "(" ^ string_of_term t1 ^ " " ^ string_of_term t2 ^ ")"

    | Variable (var) -> var

    | LetIn (var, t1, t2) ->
      "let " ^ var ^ " = " ^ string_of_term t1 ^ " in " ^ string_of_term t2

    | Alias (var, t1) ->
      "val " ^ var ^ " = " ^ string_of_term t1

    | Seq (t1, t2) ->
      string_of_term t1 ^ " ; " ^ string_of_term t2
;;
