-- Laboratorul 1 (real 8): Haskell 
 
-- este limbaj care introduce paradigma programarii functionale 
-- functiile sunt operatorii principali 
-- nu avem nevoie de parantezare in momentul in care apelam functiile 
-- f(x) -> in Haskell este f x 
-- g(x, y) -> in Haskell (g x y) 
 
-- putem scrie functii
-- putem evalua functiile/expresiile respective
-- ne intereseaza si tipul acestor functii 
 
-- avem o clasa a tipului numeric, Num 
-- pentru clasa Num, avem Int, Integer, Double, Float etc 
-- putem compune expresii aritmetice, utilizand +, -, / (exacta, double), *, ** (double), ^ (Int), `mod`, `div`
 
-- mod si div sunt doua functii 
-- in general, functii in Haskell sunt in forma prefix
-- pentru a fi in forma infix, le utilizam cu apostrofurile unghiulare `` 
-- mod 5 3 este echivalent cu 5 `mod` 3     REST
-- div 5 3 este ecvhialent cu 5 `div` 3     CAT 
 
-- putem defini variabile si le putem asigna o valoare 
-- x = 3 
-- x 
-- > 3 
 
-- intr-un program, insa, variabilele nu sunt mutabile 
 
-- Bool: True, False 
-- && - and 
-- || - or 
 
-- definim o functie 
-- <function_name> [<arg>]* = <function_body>
 
double :: Int -> Int 
double x = x + x 
 
-- pentru a incarca programul, folosim :l (load) 
-- :l file_path
 
-- :t <function_name> -- ofera informatii despre signatura 
-- :r - reload 
 
add :: Int -> Int -> Int 
add x y = x + y 
 
-- ctrl + L -- clear console 
-- din definitia functiei 
-- :t add este Int -> Int -> Int 
-- :t (add 2) este Int -> Int: este o partitie a functiei add
--                             care primeste un argument x si returneaza x + 2 
-- :t (add 3 5) este Int 
-- aceste procese se numesc currying si uncurrying 
 
maxim :: Int -> Int -> Int 
maxim x y = if x > y then x else y 
 
maxim' :: Int -> Int -> Int 
maxim' x y 
    | x > y = x 
    | otherwise = y 
 
-- punem mereu otherwise pe case-ul default 
 
-- Liste in Haskell 
-- listele in Haskell sunt structuri de date care pot retine elemente de acelasi tip 
-- au aceeasi scriere ca in Prolog: [1, 2, 3]
-- exact ca in Prolog, listele sunt definite INDUCTIV 
-- cazul de baza: lista vida este [] 
-- cazul recursiv: (h:t), dar preferam in Haskell (x:xs)
 
-- scriem o functie care sa calculeze suma elementelor dintr-o lista de elemente de tip Int 
 
sumList :: [Int] -> Int 
sumList [] = 0                      -- cazul de baza
sumList (x:xs) = x + sumList xs     -- cazul recursiv 
 
-- avem predefinita functia zip :: [a] -> [b] -> [(a, b)]
-- zip [1,2,3] [4,5,6]
-- [1,2,3] `zip` [4,5,6]
-- ambele au, ca efect, obtinerea listei [(1, 4), (2, 5), (3, 6)] 
-- daca avem o pereche (a, b), primul element se acceseaza cu fst, iar al doilea, cu snd 
-- fst :: (a, b) -> a
-- snd :: (a, b) -> b 
 
-- lucrati exercitiile 1 si 2. 
-- pauza pana la si 20. 
 
add3 :: Int -> Int -> Int -> Int 
add3 x y z = x + y + z 
 
maxim4 :: Int -> Int -> Int -> Int -> Int 
maxim4 x y z t = maxim (maxim x y) (maxim z t)
 
maxim4' :: Int -> Int -> Int -> Int -> Int 
maxim4' x y z t = maxim x (maxim y (maxim z t))
 
maxim4'' :: Int -> Int -> Int -> Int -> Int 
maxim4'' x y z t = maxim x $ maxim y $ maxim z t 
 
-- $: operator de aplicare, asociativ la dreapta 
-- g $ z t este g (z t)
 
-- pentru a nu scrie mereu tipurile explicit 
-- putem definiti functiile cu signaturi peste clase de tipuri 
 
-- Num - clasa numerica 
-- Ord - clasa tipurilor ordonabile 
-- Show - clasa tipurilor care pot fi afisate ca string 
-- Eq - clasa tipurilor pentru care este definita egalitatea 
 
-- vom lucra cu specificatii algebrice - tipuri noi de date 
-- pentru fiecare tip custom pe care il definim, va trebui sa scriem instante ale claselor de tipuri 
 
maxim'' :: Ord a => a -> a -> a 
maxim'' x y
    | x > y = x 
    | otherwise = y
 
-- exemplu pentru tipurile de date algebrice 
 
-- redefinim tipul Boolean - MyBool care sa aiba MyTrue si MyFalse 
 
-- definitia tipurilor de date algebrice se face prin intermediul keyword-ului data 
 
data MyBool = MyTrue | MyFalse 
    --deriving Show 
 
instance Show MyBool where 
    show MyTrue = "T"
    show MyFalse = "F"
 
instance Eq MyBool where 
    MyTrue == MyTrue = True         -- (==) MyTrue MyTrue = True 
    MyFalse == MyFalse = True       -- (==) MyFalse MyFalse = True 
    _ == _ = False                  -- (==) _ _ = False 
 
-- cand specificatia tipului este cu | 
-- (adica alegem sa fie sau MyTrue, sau MyFalse)
-- atunci MyBool se numeste tip SUMA 
 
myAnd :: MyBool -> MyBool -> MyBool 
myAnd MyTrue MyTrue = MyTrue 
myAnd _ _ = MyFalse 
 
myOr :: MyBool -> MyBool -> MyBool 
myOr MyFalse MyFalse = MyFalse 
myOr _ _ = MyTrue 