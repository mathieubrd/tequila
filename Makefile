OCAMLC=ocamlc
OCAMLLEX=ocamllex
OCAMLYACC=ocamlyacc

APPLI_OBJS=types.cmo lexer.cmo parser.cmo alias.cmo tools.cmo eval.cmo output.cmo type_checker.cmo main.cmo

lambda:$(APPLI_OBJS)
	$(OCAMLC) -o lambda $(APPLI_OBJS)

types.cmo:types.ml
	$(OCAMLC) -c types.ml

alias.cmo:alias.ml
	$(OCAMLC) -c alias.ml

tools.cmo:tools.ml
	$(OCAMLC) -c tools.ml

output.cmo:output.ml
	$(OCAMLC) -c output.ml

eval.cmo:eval.ml
	$(OCAMLC) -c eval.ml

type_checker.cmo:type_checker.ml
	$(OCAMLC) -c type_checker.ml

parser.ml:parser.mly
	$(OCAMLYACC) -v parser.mly

parser.mli:parser.mly
	$(OCAMLYACC) -v parser.mly

parser.cmi:parser.mli
	$(OCAMLC) -c parser.mli

parser.cmo:parser.ml
	$(OCAMLC) -c parser.ml

lexer.ml:lexer.mll
	$(OCAMLLEX) lexer.mll

lexer.cmo:lexer.ml parser.cmi
	$(OCAMLC) -c lexer.ml

main.cmo:main.ml
	$(OCAMLC) -c main.ml

clean:
	rm -rf $(APPLI_OBJS) lambda types.cmi eval.cmi parser.mli parser.cmi parser.ml lexer.ml type_checker.cmi lexer.cmi main.cmi tools.cmi output.cmi alias.cmi
