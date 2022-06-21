module Parametric where

import Data.Function

apply2 :: (t -> t) -> t -> t
apply2 f x = f (f x)

flip' :: (t0 -> t1 -> t2) -> t1 -> t0 -> t2
flip' f x y = f y x

sumsq = on (+) (^2)

multSecond = let
        g = (*)
        h = snd
    in on g h

f' = \x -> 2 * x + 7

p1 = ((1,2), (3,4))
p2 = ((3,4), (5,6))

sumfstfst = on (+) h
    where h pp = fst $ fst pp

sumfstfst' = on (+) (\pp -> fst $ fst pp)

sumfstfst'' = on (+) (fst . fst)

on3 f3 f1 a0 a1 a2 = f3 (f1 a0) (f1 a1) (f1 a2)

compose' f g = \x -> f $ g x

cfgh :: Integer -> Integer
cfgh = round . f . g . h

f = (on (logBase) fromIntegral) 2
g = (^2)
h = max 42
