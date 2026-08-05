import Data.Maybe 


data Line = L [Int] deriving (Eq, Show)
data Matrix = M [Line] deriving (Eq, Show)

linesN :: Matrix -> Int -> [Line]
linesN (M lines) n = filter (\(L line) -> length line == n) lines

onlyPosElems :: Matrix -> Int -> Bool 
onlyPosElems m n = and $ map (\(L line) -> and $ map (>0) line) $ linesN m n

type Name = String
data Prop
    = Var Name
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    deriving Eq
infixr 2 :|:
infixr 3 :&:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

instance Show Prop where 
    show (Var x) = show x 
    show F = "F"
    show T = "T"
    show (Not p) = "(~" ++ show p ++ ")"
    show (p :|: q) = "(" ++ show p ++ " | " ++ show q ++ ")"
    show (p :&: q) = "(" ++ show p ++ " & " ++ show q ++ ")"

type Env = [(Name, Bool)]

impureLookup :: Eq a => a -> [(a, b)] -> b 
impureLookup key list = fromJust $ lookup key list 

env :: Env 
env = [("P", True), ("Q", False)]

eval :: Prop -> Env -> Bool 
eval (Var x) env = impureLookup x env 
eval F _ = False 
eval T _ = True 
eval (Not p) env = not $ eval p env 
eval (p :|: q) env = (eval p env) || (eval q env)
eval (p :&: q) env = (eval p env) && (eval q env)

data Expr = Const Int 
    | Expr :+: Expr 
    | Expr :*: Expr 
    deriving Eq 

data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int 
    | Node Operation Tree Tree 
    deriving (Eq, Show)

expr :: Expr 
expr = (Const 2) :+: ((Const 3) :*: (Const 4))

instance Show Expr where 
    show (Const x) = show x 
    show (e1 :+: e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
    show (e1 :*: e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"

evalExp :: Expr -> Int 
evalExp (Const x) = x 
evalExp (e1 :+: e2) = (evalExp e1) + (evalExp e2)
evalExp (e1 :*: e2) = (evalExp e1) * (evalExp e2)

evalArb :: Tree -> Int 
evalArb (Lf x) = x 
evalArb (Node Add left right) = (evalArb left) + (evalArb right)
evalArb (Node Mult left right) = (evalArb left) * (evalArb right)

expToArb :: Expr -> Tree 
expToArb (Const x) = Lf x
expToArb (e1 :+: e2) = Node Add (expToArb e1) (expToArb e2)
expToArb (e1 :*: e2) = Node Mult (expToArb e1) (expToArb e2)

-- acum trebuie ca evalExp expr == evalArb $ expToArb expr 
