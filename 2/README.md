# Basics

## Polymorphism

function is polymorphic if it can be called on values of different type

as an example - add is a polymorphic operator because it can be call on Integers/Ints/Floats/Doubles returning respectively Integer/Int/Float/Double

There is two types of polymorphism: via parameters and special polymorphism

parametric polymorphism - has the same code for all types of values

special polymorphism - has implementation for each value type

### Parametric polymorphism

```haskell
let id x = x
:t id

id :: t -> t
```

composition of two functions

```haskell
f :: b -> c
g :: a -> b
x :: a

c :: a -> c
-- f (g x) :: x
compose f g = \x -> f $ g x :: a -> c
```

#### Constraints

we are able to set constraints on types in the polymorphic functions

```haskell
-- monomorphic id function
mono :: Char -> Char
mono x = x

-- mono 'x'
-- 'x'

-- mono True
-- Couldnt match expected type Char with actual type Bool

semimono :: Char -> a -> Char
semimono x y = x
```

## Higher order functions

```haskell
:t ($)
($) :: (a -> b) -> a -> b
    :t (a -> b)
    (a -> b) :: a -> b
```

```haskell
apply2 :: (t -> t) -> t -> t
apply2 f x = f (f x)
```

`Data.Function` module `on` function

```haskell
on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on op f x y = f x `op` f y
```

takes four arguments:

* binary fn with same type arguments `b` returning type `c`
* unary function from `a` to `b`
* argument of type `a`
* argument of type `a`

returns: type `c`

example:

function to calculate sum of the squares of two numbers

```haskell
sumsq = (+) `on` (^2)
```

## Lambda functions

anon. functions

```haskell
add = \x \y -> x + y
add = \x y -> x + y
```

## Type classes

```haskell
:t 7
-- 7 :: Num a => a
```

`=>` - therefore

`context => expression type`

context has interface type - `Num` and type name for which type interface binded `a`

7 has polymorphic type `a`, which should have interface Num(has interface Num constraint)

```haskell
:t (>)
(>) :: Ord a => a -> a -> Bool
```

`>` takes two elements of same type, but that type `a` has constraint `Ord`, `a` should implement `Ord`

```haskell
:t (> 7)
(> 7) :: (Ord a, Num a) => a -> Bool
```

`> 7` takes one element `a`, that has constraint `Ord` and `Num`, `Ord` constraint comes from operator `>` and `Num` constrain comes from already bind value `7` implements `Num`

i.e we can compare ordered values and `7` can be compared only with another value under `Num` constraint

Type classes declares interface, that types can implement

Type classes are set of functions with signatures with type parameters

example Eq typeclass:

```haskell
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool

:t (==)
(==) :: Eq a => a -> a -> Bool

:t (/=)
(/=) :: Eq a => a -> a -> Bool
```

type called instance of a type class if it implements all of the defined type class signatures

implementing type instance:

```haskell
class Eq a where
    (==), (/=) :: a -> a -> Bool

    -- default implementation
    x /= y = not (x == y)
    -- recursive implementation
    x == y = not (x /= y)
    -- allows to choose which function to implement:
    -- (==) or (/=)

instance Eq Bool where
    True  == True  = True
    False == False = True
    _     == _     = False

    -- yet we can overwrite default implementation

instance (Eq a,  Eq b) => Eq (a, b) where
    -- context: (Eq a, Eq b) =>
    -- declare instance Eq for pair (a, b)
    -- where Eq a and Eq b
    p1 == p2 = fst p1 == fst p2 && snd p1 == snd p2

```

## class extension

extending interface

```haskell
class (Eq a) => Ord a where
    (<), (<=), (>=), (>) :: a -> a -> Bool
    max, min :: a -> a -> a
    compare :: a -> a -> Ordering
```

reads - syntax deconstruction

possible results:

* clear path - returns list with single pair
* fail path - empty list, making function total
* multiple interpretations - multiple possible ways to interpret input

```haskell
reads "5 rings" :: [(Int, String)]
```

reads is a total function

`total function is A function which is defined for all inputs of the right type, that is, for all of a domain.`

## Enum

```haskell
class Enum a where
    -- access next/prev element in enum collection
    succ, pred :: a -> a

    -- interface to convert Int into enum element
    toEnum :: Int -> a

    -- interface to conver enum element into Int
    fromEnum :: a -> Int
```
## Bounded

```haskell
class Bounded a where
    minBound, maxBound :: a


minBound :: Bool
-- False
maxBound :: Bool
-- True
```

## Num

has two "sub" types Integral and Fractional
each implements division on values of their type

### Integral

```haskell
:t Integraal
-- Word
-- Integer
-- Int
```

Num <- (Real, Enum) <- Integral

### Fractional

```haskell
:t Fractional
-- Float
-- Double
```

Num <- Fractional <- Floating <- RealFrac <- RealFloat

```haskell
class Num a where
    (+), (-), (*) :: a -> a -> a
    -- no division
    negate :: a -> a
    abs :: a -> a
    signum :: a -> a
    fromInteger :: Integer -> a

    x - y = x + negate y
    negate x = 0 - x

{-
    LAW sometimes defined for class types

    abs x * signum x == x
-}
```

## semantics

### computations models
haskell execution consists of expressions reduction

important quality of FPLs are identical behaviour of pure function execution despite of the execution model that have been chosen(as long as programs are finitely terminating)

```haskell
sumIt :: Int -> Int -> Int
sumIt x y = x + y

sumIt (1 + 2) 3
-- 6

-- imperative languages use energetic strategy executing functions
-- sumIt (1 + 2) 3 as energetic strategy
-- look at first argument -> expression that needs execution
-- compute (1 + 2) -> 6 is a first argument
-- look at second argument -> value, leave as is
-- execute sumIt 3 3 -> 6

-- fp languages lazy evaluation
-- sumIt (1 + 2) 3 as lazy strategy
-- pass inside sumIt (1 + 2) expression, and replace function body
-- since we are calling function execute its body
-- (1 + 2) + 3
-- 3 + 3
-- 6

-- redux: (1 + 2), sumIt (1 + 2) 3
```


```haskell
fn             a                  b                   = a
function name  formal parameter   formal parameter    = body

fn              3                   4
function name   factual parameter   factual parameter
```

#### redux
redux - is a expression that can be reduced right at this moment

### lazy model pros

#### lazy model being more effective example:

```haskell
add7 :: Int -> Int -> Int
add7 x y = x + 7

{- lazy eval
add7 1 (2 + 3)
     1 + 7
     8
-}

{- energetic eval
add7 1 (2 + 3)
add7 1 5
     1 + 7
     8
-}
```

#### lazy model being less effective example:

```haskell
dup :: INt -> (Int, Int)
dup x = (x, x)

{- lazy eval
dup (2 + 3)
    (2 + 3, 2 + 3)
    (5, 2 + 3)
    (5, 5)
-}

{- vm has optimization
dup (2 + 3)
    (p, p)          p = 2 + 3
    (5, p)          p = 5
    (5, 5)

-}

{- energetic eval
dup (2 + 3)
dup 5
    (5, 5)
-}
```

```haskell
bar x y z = x + y

foo a b = bar a a (a + b)

value = foo (3 * 10) (5 - 2)

foo (3 * 10) (5 - 2)
    bar (p0) (p0) (p0 + p1)     p0 = 3 * 10 = 30, p1 = 5 - 2 = 3
        p0 + p0
        30 + 30
        60
```

#### non-strict function
if to function can be passed divergent computation and result is non-divergent that function called non-strict

#### strict function
if to function can be passed divergent computation and result is divergent that function called strict

functions can be strict by their second argument according to their first argument

```haskell
const42 :: a -> Int
const42 = const 42

const42 123
-- 42
const42 (1 + 3)
-- 42
const42 undefined
-- 42
```

#### fp execution - reduction

expression is reduced untill there is reduxes to reduce

when there is no reduxes expression is called to be in a normal form

normal form(NF): `42`, `(3, 4)`, `\x -> x + 2`

non-normal form(NNF):
```haskell
"Real " ++ "world"
sin (pi / 2)
(\x -> x + 2) 5
(3, 1 + 5)
```

weak head normal form(WHNF):
```haskell
\x -> x + 2 * 3 -- lambda abstraction
(3, 1 + 5)      -- data constructor
(,)  (4, 5)     -- partially applied data constructor
(+)  (7^2)      -- partially applied INNER function
```

WHNF <- NF

##### seq forcing execution

seq allows forcing delayed computation

seq forcing up to weak head normal form

```haskell
seq :: a -> b -> b
seq _|_ b = _|_
seq a   b = b

seq 1 2
-- 2

seq undefined 2
seq (id undefined) 2
-- **** exception: Prelude.undefined

seq (undefined, undefined) 2
-- 2

seq (\x -> undefined) 2
-- 2

($!) :: (a -> b) -> a -> b
f $! x = x `seq` f x
-- calls f x, but first redux x to WHNF

factorial :: Integer -> Integer
factorial n | n >= 0 = helper 1 n
factorial   | otherwise = error "arg must be >= 0"
    where
        helper acc 0 = acc
        helper acc n = (helper $! (acc * n)) (n - 1)
-- calculate actual parameter (acc * n) and the apply it to formal parameter helper acc
```


## Modules
haskell program consists of collection of modules

haskell should have Main module, all module names start with uppercase letter and should be inside a file with name identical to module name

```haskell
-- import syntax

-- import whole module
import Data.Char

-- import listed functions from module
import Data.Char (toUpper, toLower)

-- import whole module but listed functions
import Data.Char hiding (toLower)

-- resolving naming conflicts
import Data.List
import Data.Set
-- both has union
-- can be used as:
Data.Set.union
-- or
Data.List.union
-- or mark one of the modules as qualified
-- forcing to specify whole name for every function in that module
import qualified Data.List

Data.List.union
-- but
union -- to use Data.Set.union

-- local pseudo name for a module
import qualified Data.Set as Set

-- exporting exact set of functions from module

-- Test.hs
module Test (sumIt, foo) where
foo a = a
sumIt a b = a + b

-- Main.hs
module Main where

import Test (sumIt)

sumIt 2 2
-- 4
-- foo not in scope
```
