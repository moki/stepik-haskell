module Typeclasses where

class Printable a where
    toString :: a -> [Char]

instance Printable Bool where
    toString True = "true"
    toString False = "false"

instance Printable () where
    toString () = "unit type"

instance (Printable a, Printable b) => Printable (a, b) where
    toString (a,b) = "(" ++ (toString a) ++ "," ++ (toString b) ++ ")"

class KnownToGork a where
    stomp :: a -> a
    doesEnrageGork :: a -> Bool

class KnownToMork a where
    stab :: a -> a
    doesEnrageMork :: a -> Bool

class (KnownToGork a, KnownToMork a) => KnownToGorkAndMork a where
    stompOrStab :: a -> a
    {--stompOrStab a = let
        helper True False = stab a
        helper False True = stomp a
        helper True True = (stomp . stab) a
        helper _ _ = a in helper (doesEnrageMork a) (doesEnrageGork a)
    --}
    stompOrStab a | (doesEnrageMork a) && (doesEnrageGork a) = (stomp . stab) a
                  | doesEnrageMork a = stomp a
                  | doesEnrageGork a = stab a
                  | otherwise = a

ip = show a ++ show b ++ show c ++ show d

a = 127.22 :: Double
b = 4.1 :: Double
c = 20.1 :: Double
d = 2 :: Integer

class (Bounded a, Enum a, Eq a) => SafeEnum a where
  ssucc :: a -> a
  ssucc a | a == maxBound = minBound
          | otherwise = succ a

  spred :: a -> a
  spred a | a == minBound = maxBound
          | otherwise = pred a

instance SafeEnum Bool
instance SafeEnum Int

avg :: Int -> Int -> Int -> Double
-- avg a b c = let helper x y = (x / y) in helper (fromInteger (sum [fromIntegral a, fromIntegral b, fromIntegral c])) (fromIntegral 3)
avg a b c = ((/ 3) . sum . map fromIntegral) [a,b,c]
