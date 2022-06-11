# Intro

## Modules

Module names starts with Capital letter

```
module Test where

testing x = x
```

Can be loaded and reloaded inside interpretator

```haskell
-- load
:load path/to/module.hs

-- reload
:reload
```

## Functions

### Syntax

```haskell
multiply x y = x * y

multiply 2 3
(multiply 2) 3
((multiply 2) 3)
```

### Interpreter

```haskell
let sumSqrs x y = x ^ 2 + y ^ 2
```

* :load - load module
* :reload - reload module
* :type - get expression type
* :info - get implementation informationj
* :set +s - track memory usage and execution time

### Constants

```haskell
let fourtyTwo = 39 + 3

fourtyTwo
-- 42
```

### Conditions

```haskell
let ispos x = if x > 0 then True else False
let ispos x | x == 0 = True
            | x > 0 = True
            | x < 0 = False

```

### Partial application

```haskell
maxor5 = max 5

maxor5 2
-- 5

maxor5 10
-- 10
```

### Call style

by default prefix style

```haskell
max 5 2
-- 5
```

to call in infix style, wrap in reverse quotes \`

```haskell
5 `max` 2
```

## Operators

### Call style

by default infix style

```haskell
5 + 2
-- 7
```

to call in prefix style, wrap in parens `(operator)`

```haskell
(+) 5 2
-- 7
```

## Priorities and Associativity

### Priorities

#### Functions

Has the highest priority of 10

#### Operators

from 0 to 9

### Associativity

expression: `3 - 9 - 5`

left associative: `(3 - 9) - 5`

right associative: `3 - (9 - 5)`

### Syntax

```haskell
infix[l|r] [0-9] [comma separated operator names]
```

left associativity: `infixl`
right associativity: `infixr`
non-set associativity: `infix`

```haskell
infixr 8 ^, `logBase`
infixl 7 *, /, `div`, `mod`
infixl 6 +, -
infix 4 ==, /=, >, >=< <, <=
```

not set default: `infixl 9`

## Operators

haskell has no built in operators, all operators are defined inside stdlib

### Custom operators

allowed character set for usage(custom definitions):

```
! # $ % & * + . / < = > ? @ \ ^ | - ~
```

pick one or use any combination of them

```haskell
-- operators can be defined in both prefix and infix form
-- prefix form
-- (*+*) a b = a ^ 2 + b ^ 2

-- infix form
a *+* b = a ^ 2 + b ^ 2
```

### Partial application

```haskell
divideTwo x = (2 /)

divideByTwo x = (/ 2)
```

doesn't exist for subtract operator `-`

### `$` special call operator

```haskell
f (g x (h y))
f $ g x (h y)
f $ g x $ h y
```

## Types

Haskell has strongly static type system, yet it does infer implicit types for expressions

* Char `:t 'a'`
* Bool `:t True`, `:t 4 == 5`
* [Char] `:t "hello"`
* (Bool, Char) `:t (True, 'a')
* Int, means integer
* Integer, really means BigInt
* Float, real floating point single precision
* Double, real floating point double precision

### Function types

we can explicitly set type for our function

syntax: `from -> to`

```haskell
-- function from string to string, char list to char list
removeNonUppercase :: [Char] -> [Char]
-- list comprehension:
-- new list with c, where c is from s and c is element of the range
-- from 'A' to 'Z'
removeNonUppercase s = [ c | c <- s, elem c ['A'..'Z']]


addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z
```

### Number types

Int, Integer, Float, Double

#### Int - integer

bounded type on 32-bit machines 2 ^ 31 * (-1) <= Int <= 2 ^ 31 - 1

#### Integer - Big Integer

unbounded type used to represent really big integers

#### Float - real single precision

#### Double - real double precision

### Type variables

head function - takes list and returns its first element

```haskell
:t head

head :: [a] -> a
```

where a is a type variable

Functions that have type variables are called polymorphic functions

### Typeclasses 101

typeclass is a sort of interface that defines some behaviour

if type is a part of a typeclass, that means that it supports and implements the behaviour
the typeclass describes.

`=>` - everything before `=>` is called a class constraint

```haskell
(==) :: (Eq a) => a -> a -> Bool
```

can be read as the equality function takes any two values that are of the same type and returns a Bool.
The type of those two values must be a member of the Eq class(class constraint)

```haskell
elem :: (Eq a) => a -> [a] -> Bool
```

#### Basic typeclasses

* Eq - types that support equality testing. ==
* Ord - types that allow ordering. allows >,<,>=,<=, compare. Ordering: GT, LT, EQ
* Show - show, takes member of Show and presents to us string
* Read - read opposite of show takes a string and returns type
* Enum - succ, pred. (), Bool, Char, Ordering, Int, Integer, Float and Double.
* Bounded - have upper and lower bound. maxBound, minBound
* Num - numeric, types act like numbers. type also must be of Show and Eq
* Integral - only integral(whole) numbers. Integer, Int
* Floating - only floating point numbers. Float, Double

## Modules

### import

```haskell
-- import [module_name]
module Demo where

import Data.Char

-- isDigit comes from Data.Char
test = isDigit '7'
```

## Tuples

tuples are heterogeneous

common functions to work with tuples fst and snd, gives first and second element of the tuple.

```haskell
fst ("wow", False)
"wow"

snd (1, True)
True
```

## List

lists are homogeneous

functions to work with lists: head, tail, concatenation (++), append (:)

(:) - infixr 5
(++) - infixr 5

```haskell
head "Hello"
'H'

tail "Hello"
'ello'

'H' : "ello"
"Hello"

"Hello" ++ ", world!"
"Hello, world!"
```

## Recursion

undefined: bottom

## guards

```haskell
function argument | guard_expression = result
                  | guard_expression = result
                  | otherwise        = result
```

guard_expression - expression -> Bool
otherwise        - special "defaault" case
otherwise = True
