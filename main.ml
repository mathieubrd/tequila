open Types        ;;
open Alias        ;;
open Tools        ;;
open Eval         ;;
open Output       ;;
open Type_checker ;;

let aliases : (string * term) list ref = { contents = [] } ;;
 
let lexbuf = Lexing.from_channel stdin in
  while true do
    let term = Parser.main Lexer.lexer lexbuf in
    let term = substitute_aliases term in
    if is_closed term then
      try
        let term_type = type_of_term term in
        let term = eval term in
        print_endline (print_term term ^ " : " ^ print_type term_type)
      with Type_error e ->
        print_endline e
    else
      print_endline "Term no closed"
  done
;;
