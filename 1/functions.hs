module Functions where
sum2sqrs x y = x ^ 2 + y ^ 2

-- lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)
lenVec = sqrt . sum . map (^2)
lenVec3 x y z = lenVec [x, y, z]
