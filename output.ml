open Types ;;
open Tools ;;

let rec print_type term_type =
  match term_type with
  | Bool ->
    "Bool"

  | Nat ->
    "Nat"

  | TAbs (typ1, typ2) ->
    "(" ^ print_type typ1 ^ " -> " ^ print_type typ2 ^ ")"
;;

let print_type_error actual_type excepted_type =
  "This expression has type " ^ print_type actual_type ^ " but an expression was excepted of type " ^ print_type excepted_type
;;

let print_numeric_val term =
    let rec aux term count =
        match term with
        | Zero -> string_of_int count
        | Succ (t1) -> aux t1 (count + 1)
        | Pred (t1) -> aux t1 (count - 1)
        | _ -> "0"
    in

    aux term 0
;;

let rec print_term term =
  match term with
    | True ->
      "true"

    | False ->
      "false"

    | Zero ->
      print_numeric_val Zero

    | Succ (t1) ->
      let t1 = Succ (t1) in
      print_numeric_val t1

    | Pred (t1) ->
      let t1 = Pred (t1) in
      print_numeric_val t1

    | IsZero (t1) when is_val t1 ->
      "iszero (" ^ print_term t1 ^ ")"

    | IsZero(t) ->
      "iszero (" ^ print_term t ^ ")"

    | Cond (t1, t2, t3) ->
      "if " ^ print_term t1 ^ " then " ^ print_term t2 ^ " else " ^ print_term t3

    | Abstraction (var, typ, t1) ->
      "λ" ^ var ^ " : " ^ print_type typ ^ ". " ^ print_term t1
    
    | Application (Abstraction(var, typ, t1), t2) ->
      "(λ" ^ var ^ ": " ^ print_type typ ^ ". " ^ print_term t1 ^ ") " ^ print_term t2
    
    | Application (t1, t2) ->
      "(" ^ print_term t1 ^ " " ^ print_term t2 ^ ")"
    
    | Variable (var) -> var
    
    | LetIn (var, t1, t2) ->
      "let " ^ var ^ " = " ^ print_term t1 ^ " in " ^ print_term t2

    | Alias (var, t1) ->
      "val " ^ var ^ " = " ^ print_term t1
;;
