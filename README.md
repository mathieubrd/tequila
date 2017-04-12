# Tequila
A typed λ-calculus interpreter

# Install

Before compiling, ensure you have `ocaml`, `ocamlc`, `ocamllex` and `ocamlyacc` packages.

Compile the project:
```
$ make
```

# Use

Start the interpreter :
```
$ ./lambda
```

## Expression
An expression is characterized by a term and is ending by `;;`

## Types
There are 3 types:
- Natural `Nat` ;
- Boolean `Bool` ;
- Application `T -> T`.

## Functions
A function that takes a natural and returns its successor:
```
> let func = lambda x : Nat. succ x ;;
val func = λx : Nat. 0 : (Nat -> Nat)
```

Applies the function `func` to the natural `0`:
```
> func 0 ;;
1 : Nat
```

## Arithmetic expressions
The are 2 basic arithmetics expressions:
- `succ x` - gets the successor of `x` ;
- `pred x` - gets the predecessor of `x`;

## Logical expressions
This interpreter supports logical expressions like test if a natural is equals to ``0`:
```
> iszero 0 ;;
true : Bool
```

There is the if-then-else structure as well:
```
> if iszero 0 then succ 0 else 0 ;;
1 : Nat
```

## Let-in
The Let-in expression allows you to bind a variable to a term:
```
> let x = 0 in (lambda a : nat. if iszero a then succ a else pred a) x ;;
1 : Nat
```
