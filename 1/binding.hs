module Binding where

roots a b c =
    let d  = sqrt (b ^ 2 - 4 * a * c)
        x1 = (-b - d) / (2 * a)
        x2 = (-b + d) / (2 * a) in
    (x1, x2)

rootsdiff a b c = let
    (x1, x2) = roots a b c
    in x2 - x1

seqa x | x == 0 = 1
       | x == 1 = 2
       | x == 2 = 3
       | otherwise = (seqa (x - 1) + seqa (x - 2) - (seqa (x - 3) * 2))

seqA n  | n == 0 = 1
        | n == 1 = 2
        | n == 2 = 3
        | otherwise = let
            recurse a0 a1 a2 (-1) = a2
            recurse a0 a1 a2 n =
                recurse a1 a2 (a1 + a2 - 2 * a0) (n - 1)
        in recurse 1 2 3 (n - 3)

sum'n'count :: Integer -> (Integer, Integer)
sum'n'count x | x == 0 = (0, 1)
              | x < 0 = helper (abs x) 0 0
              | otherwise = helper x 0 0
    where helper x s c | x == 0 = (s, c)
                     | otherwise = helper (quot x 10) (s + (mod x 10)) (c + 1)

integration :: (Double -> Double) -> Double -> Double -> Double
integration f a b = let
    limit = 1000
    h = (b - a) / limit
    sum acc x 0 = acc
    sum acc x n = sum (acc + f x) (x + h) (n - 1)
  in h * (f a + f b + 2 * (sum 0 (a + h) (limit - 1))) / 2
