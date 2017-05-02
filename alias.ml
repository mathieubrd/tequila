open Types ;;

let aliases : (string * term) list ref = { contents = [] }

let substitute_aliases term =
  let rec aux term alias =
    match term with
    | Variable (var) when var = fst alias ->
      snd alias

    | Seq (t1, t2) ->
      Seq (aux t1 alias, aux t2 alias)

    | Abstraction (var, typ, t1) ->
      Abstraction (var, typ, aux t1 alias)

    | Application (t1, t2) ->
      Application (aux t1 alias, aux t2 alias)

    | Alias (var, t1) ->
      Alias (var, aux t1 alias)

    | LetIn (var, t1, t2) ->
      LetIn (var, aux t1 alias, aux t2 alias)

    | Cond (t1, t2, t3) ->
      Cond (aux t1 alias, aux t2 alias, aux t3 alias)

    | Succ (t1) ->
      Succ (aux t1 alias)

    | Pred (t1) ->
      Pred (aux t1 alias)

    | IsZero (t1) ->
      IsZero (aux t1 alias)

    | _ ->
      term
  in

  let rec loop aliases =
    match aliases with
    | [] -> term
    | (var, t1) :: tl -> aux (loop tl) (var, t1)
  in

  loop !aliases
;;

let add_alias (var, term) =
  aliases := (var, term) :: !aliases
;;
