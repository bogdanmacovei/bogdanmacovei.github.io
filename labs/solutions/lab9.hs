import Data.Char (isDigit, digitToInt)
 
-- Laboratorul 9 Haskell 
 
-- recursie, functii de nivel inalt (HOF), comprehensiune (LC)
-- proprietatea de universalitate a lui foldr 
-- tipuri de date algebrice
-- clase de tipuri 
 
-- Exercitiul 1 a 
-- varianta recursiva 
 
-- listele sunt reprezentate inductiv 
-- ([], (:)) [] lista vida, : adaugarea unui element la lista 
-- (x:xs) x este head, xs este tail 
 
 
-- [1..10] -> creeaza lista [1, 2, 3, ..., 10]
-- [2,4..20] -> [2, 4, 6, 8, ... 20]
-- [3,6,...,19] -> [3, 6, 9, 12, 15, 18]
-- [0..] -> creeaza lista infinita [0,1,2,...,....,.............]
 
removeOddHalfEven :: [Int] -> [Int]
removeOddHalfEven [] = [] 
removeOddHalfEven (x:xs) 
    | even x        = (x `div` 2) : removeOddHalfEven xs 
    | otherwise     = removeOddHalfEven xs 
 
-- Exercitiul 1 b 
-- map :: (a -> b) -> [a] -> [b]
-- filter :: (a -> Bool) -> [a] -> [a]
-- filter (\x -> even x) [1..10]
-- filter even [1..10]
 
-- f x  -> f $ x 
-- $ - aplicare de functie 
-- g x (f x y) 
-- g x $ f x y 
 
removeOddHalfEvenHOF :: [Int] -> [Int]
removeOddHalfEvenHOF list = map (`div` 2) 
    $ filter even list
 
-- Exericitul 1 c 
-- [ x | x <- list, prop x ]
-- lista elementelor x 
--  cu proprietatea ca x apartine lui list 
--  si x satisface prop 
 
removeOddHalfEvenLC :: [Int] -> [Int]
removeOddHalfEvenLC list = [ x `div` 2 | x <- list, even x ]
 
-- Exercitiul 2 a 
-- "abc12 d 4 e 31 f1" -> 24 
-- "abc" -> 1 
 
-- type String = [Char]
-- "" == [] 
-- ['a', 'b', 'c'] == "abc"
 
testStr :: String 
testStr = "abc12 d 4 e 31 f1"
 
multDigits :: String -> Int 
multDigits [] = 1 
multDigits (c:cs)
    | isDigit c = (digitToInt c) * multDigits cs 
    | otherwise = multDigits cs 
 
-- Exercitiul 2 b 
multDigitsHOF :: String -> Int 
multDigitsHOF str = product     -- [1, 2, 4, 3, 1, 1]   -> 24 
    $ map digitToInt            -- "124311"             -> [1, 2, 4, 3, 1, 1]
    $ filter isDigit str        -- "abc12 d 4 e 31 f1"  -> "124311"
 
-- Exercitiul 2 c 
multDigitsLC :: String -> Int
multDigitsLC str = product [ digitToInt c | c <- str, isDigit c ] 
 
-- Exercitiul 3 
 
doubleOddLTn :: [Int] -> Int -> [Int]
doubleOddLTn [] _ = [] 
doubleOddLTn (x:xs) n 
    | odd x && x < n    = (2 * x) : doubleOddLTn xs n 
    | otherwise         = doubleOddLTn xs n 
 
-- Exercitiul 6 
-- consideram doubleOddLTn si o transformam in foldr 
 
{-
    Avem un algoritm pentru transformare
 
    Pasul 0: scriem functia in forma recursiva 
 
    doubleOddLTn :: [Int] -> Int -> [Int]
    doubleOddLTn [] _ = [] 
    doubleOddLTn (x:xs) n 
        | odd x && x < n    = (2 * x) : doubleOddLTn xs n 
        | otherwise         = doubleOddLTn xs n 
 
    Scopul este sa aducem aceasta functie in forma proprietatii de universalitate 
 
    DACA 
        g [] = init 
        g (x:xs) = f x (g xs)
    ATUNCI 
        g = foldr f init 
 
    Pasul 1: redenumim functia doubleOddLTn cu g 
    g [] _ = [] 
    g (x:xs) n 
        | odd x && x < n    = (2 * x) : g xs n 
        | otherwise         = g xs n 
 
    Pasul 2: schimbam din guards in if-then-else
    g [] _ = []
    g (x:xs) n = if (odd x && x < n) then (2 * x) : g xs n else g xs n 
 
    Pasul 3: aplicam currying si uncurrying 
    g [] = \_ -> []
    g (x:xs) = \n -> if (odd x && x < n) then (2 * x) : g xs n else g xs n 
 
    Pasul 4: aplicam proprietatea de universalitate 
    am gasit deja ca init = \_ -> [] 
    g (x:xs) = f x (g xs)
    g (x:xs) = \n -> if (odd x && x < n) then (2 * x) : g xs n else g xs n 
    deci 
    f x (g xs) = \n -> if (odd x && x < n) then (2 * x) : g xs n else g xs n 
 
    Pasul 5: redenumim g xs = u (APROAPE DE FIECARE DATA)
    f x u = \n -> if (odd x && x < n) then (2 * x) : u n else u n 
        ^                                            ^        ^
 
    Pasul 6: extragem functia f 
    f = \x -> \u -> \n -> if (odd x && x < n) then (2 * x) : u n else u n 
 
    pe care o putem scrie mai frumos 
    f = \x u n -> if (odd x && x < n) then (2 * x) : u n else u n 
 
    in acest moment, avem f si init, deci putem scrie g = foldr f init 
 
-}
 
doubleOddLTnFoldr :: [Int] -> Int -> [Int]
doubleOddLTnFoldr = foldr (\x u n -> if (odd x && x < n) then (2 * x) : u n else u n) (\_ -> [])
 
-- Exercitiul 4 
 
testList :: [Int]
testList = [3, 24, 6, 7, 40, 20]
 
sumEvenElemOddPos :: [Int] -> Int 
sumEvenElemOddPos list = sum -- foldr (+) 0 
    $ map fst 
    $ filter (\(elem, index) -> even elem && odd index)
    $ zip list [0..]
 
-- Exercitiul 5: tema, cadou
 
-- Exercitiul 7
-- (x:xs)
 
data LList a = Nil | Cons a (LList a)
 
l1 :: LList Int 
l1 = Cons 1 $ Cons 2 $ Cons 3 Nil 
 
l2 :: LList Int 
l2 = Cons 4 $ Cons 5 $ Cons 6 $ Cons 7 Nil 
 
-- 7a 
 
-- [1 | [2 | [3 | []]]]
 
-- pentru a putea defini Show (LList a)
-- avem nevoie ca a sa fie un tip de date pentru care avem instanta pentru clasa Show 
--        \/ <- este constrangerea de tip 
instance Show a => Show (LList a) where 
    show Nil = "[]"
    show (Cons x xs) = "[" ++ show x ++ " | " ++ show xs ++ "]"
 
instance Eq a => Eq (LList a) where 
    Nil == Nil                      = True 
    (Cons x xs) == (Cons x' xs')    = x == x' && xs == xs' 
 
-- 7b 
 
lAppend :: LList a -> LList a -> LList a 
lAppend Nil l2 = l2 
lAppend (Cons x xs) l2 = Cons x (lAppend xs l2) 
 
-- 7c 
 
instance Semigroup (LList a) where 
    (<>) = lAppend 
 
instance Monoid (LList a) where 
    mempty = Nil 
 
-- 7d 
 
lFilter :: (a -> Bool) -> LList a -> LList a 
lFilter _ Nil = Nil 
lFilter pred (Cons x xs)
    | pred x = Cons x $ lFilter pred xs 
    | otherwise = lFilter pred xs 
 
lMap :: (a -> b) -> LList a -> LList b 
lMap _ Nil = Nil 
lMap f (Cons x xs) = Cons (f x) $ lMap f xs 
 
lFoldr :: (a -> b -> b) -> b -> LList a -> b 
lFoldr _ init Nil = init 
lFoldr f init (Cons x xs) = f x $ lFoldr f init xs 
 
-- d bis: cadou 
 
-- Exercitiul 8
 
-- 8a 
data Point a b = Point a b 
 
instance (Show a, Show b) => Show (Point a b) where 
    show (Point a b) = "(" ++ show a ++ ", " ++ show b ++ ")"
 
 
instance (Eq a, Eq b) => Eq (Point a b) where 
    (Point x y) == (Point x' y') = x == x' && y == y' 
 
-- 8b 
lZip :: LList a -> LList b -> LList (Point a b) 
lZip Nil _ = Nil 
lZip _ Nil = Nil 
lZip (Cons x xs) (Cons x' xs') = Cons (Point x x') $ lZip xs xs' 