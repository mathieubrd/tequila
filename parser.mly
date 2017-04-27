%{
    open Types ;;
%}

%token          END
%token          COMMENT
%token          LAMBDA
%token          COLON
%token          DOT
%token <string> IDENT
%token          LET
%token          IN
%token          EQUAL
%token          ARROW
%token          SEQ
%token          LPAR
%token          RPAR
%token          IF
%token          THEN
%token          ELSE
%token          TRUE
%token          FALSE
%token          UNIT
%token          ZERO
%token          SUCC
%token          PRED
%token          ISZERO
%token          UNIT
%token          BOOL
%token          NAT

%start main
%type <Types.term> main

%%

main:
    term END                   {$1            }
    | LET IDENT EQUAL term END {Alias ($2, $4)}
;

term:
    funcTerm           {$1                  }
    | appTerm funcTerm {Application ($1, $2)}
    | seq {$1}
;

seq:
    term               {$1          }
    | seq SEQ funcTerm {Seq ($1, $3)}

appTerm:
    elemTerm           {$1                  }
    | appTerm elemTerm {Application ($1, $2)}
;

funcTerm:
    elemTerm                               {$1                     }
    | LAMBDA IDENT COLON typeTerm DOT term {Abstraction($2, $4, $6)}
    | LET IDENT EQUAL term IN term         {LetIn ($2, $4, $6)     }
    | IF term THEN term ELSE term          {Cond ($2, $4, $6)      }
    | SUCC term                            {Succ ($2)              }
    | PRED term                            {Pred ($2)              }
    | ISZERO term                          {IsZero ($2)            }
;

elemTerm:
    IDENT            {Variable($1)}
    | LPAR term RPAR {$2          }
    | TRUE           {True        }
    | FALSE          {False       }
    | ZERO           {Zero        }
    | UNIT           {Unit       }
;

typeTerm:
    typeTermElem ARROW typeTerm {TAbs($1, $3)}
    | typeTermElem              {$1          }
;

typeTermElem:
    BOOL                 {Bool }
    | UNIT               {TUnit}
    | NAT                {Nat  }
    | LPAR typeTerm RPAR {$2   }
