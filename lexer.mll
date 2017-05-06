{
  open Parser;;
}

rule lexer = parse
    | [' ' '\t' '\n' ]         {lexer lexbuf}
    | '#'[^'\n']*'\n'          {lexer lexbuf}
    | ";;"                     {END         }
    | "let"                    {LET         }
    | "in"                     {IN          }
    | "lambda"                 {LAMBDA      }
    | ":"                      {COLON       }
    | "."                      {DOT         }
    | ","                      {COMMA       }
    | ";"                      {SEQ         }
    | "("                      {LPAR        }
    | ")"                      {RPAR        }
    | "{"                      {LBRACE      }
    | "}"                      {RBRACE      }
    | "if"                     {IF          }
    | "then"                   {THEN        }
    | "else"                   {ELSE        }
    | "true"                   {TRUE        }
    | "false"                  {FALSE       }
    | "0"                      {ZERO        }
    | "succ"                   {SUCC        }
    | "pred"                   {PRED        }
    | "iszero"                 {ISZERO      }
    | "="                      {EQUAL       }
    | "->"                     {ARROW       }
    | ('B'|'b')"ool"           {BOOL        }
    | ('N'|'n')"at"            {NAT         }
    | ('U'|'u')"nit"           {UNIT        }
    | ['a'-'z''0'-'9']+ as str {IDENT(str)  }
