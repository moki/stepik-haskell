module Recursion where

factorial n | n < 0 = error "function defined for natural numbers"
            | n == 0 = 1
            | otherwise = (* n) $ factorial (n - 1)

fib' n | n < 0 = error "function defined for natural numbers"
       | n == 0 = 0
       | n == 1 = 1
       | otherwise = (+) (fib' (n - 1)) (fib' (n - 2))

fib = fib' . abs
-- | n < 0 = (fib' . abs) n
--      | otherwise = fib' n

helper acc 0 = acc
helper acc n = helper (acc * n) (n - 1)

fac' n | n >= 0 = helper 1 n
       | otherwise = error "function defined for natural numbers"


nat n | n == 1 = 1
      | otherwise = n + nat (n - 1)

nat'' acc 1 = acc
nat'' acc n = nat'' (acc + n) (n - 1)

nat' n | n >= 1 = nat'' 1 n
       | otherwise = error "function defined for natural numbers"

fibonacci' p c 0 = c
fibonacci' p c n = fibonacci' c (p + c) (n - 1)

fibonacci n | n == 0 = 0
            | n > 0 = fibonacci' 0 1 (n - 1)
            | otherwise = if odd n then fibonacci' 0 1 ((abs n) - 1) else fibonacci' 0 1 ((abs n) - 1) * (-1)
