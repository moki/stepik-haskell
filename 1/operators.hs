module Operators where

infixl 6 *+*

{-
 - prefix form
 - (*+*) a b = a ^ 2 + b ^ 2
-}

-- infix form
a *+* b = a ^ 2 + b ^ 2

infixl 6 |-|

-- (|-|) = (abs .) . (-)

(|-|) a b = if a - b >= 0 then a - b else (a - b) * (-1)

-- f $ x = f x
