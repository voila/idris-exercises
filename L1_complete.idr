module L1

import Decidable.Equality

-- vtake, vdrop, types and implementations missing


-- Write a function repeat : (n : Nat) -> a -> Vect a n which constructs a vector of n
-- copies of an item.

repeat : (n : Nat) -> a -> Vect n a
repeat Z     _ = [] 
repeat (S n) x = x :: repeat n x

-- 2. Consider the following functions over Lists:
-- take : Nat -> List a -> List a
-- drop : Nat -> List a -> List a
-- (a) What are the types of the corresponding functions for Vect, vtake and vdrop?
-- Hint: What are the invariants? i.e. how many items need to be in the vector in each case?
-- (b) Implement vtake and vdrop

vtake : (n:Nat) -> Vect (n+m) a -> Vect n a
vtake Z     xs      = []
vtake (S k) (x::xs) = x :: (vtake k xs)
                      
vdrop : (n:Nat) -> Vect (n+m) a -> Vect m a 
vdrop Z     xs      = xs
vdrop (S k) (x::xs) = vdrop k xs

-- (a) Using repeat, above, and Vect.zipWith, write a function which transposes a matrix.

Matrix : Type -> Nat -> Nat -> Type
Matrix a n m = Vect n (Vect m a)

-- Hints: Remember to think carefully about its type ﬁrst! zipWith for vectors is deﬁned as follows:

transpose : Matrix a n m -> Matrix a m n
transpose {m} [] = repeat m []
transpose (xs :: xss) = zipWith (::) xs (transpose xss)

instance (Eq a) => Eq (Vect n a) where
  (==) [] []        = True
  (==) [] _         = False
  (==) _  []        = False
  (==) (x::xs) (y::ys) = x == y && xs == ys

instance (Eq a) => Eq (Matrix a n m) where
  (==) [] []        = True
  (==) [] _         = False
  (==) _  []        = False
  (==) (xs::xss) (ys::yss) = xs == ys && xss == yss 
  
test_trans : so (transpose [[1,2,3],[4,5,6]] == [[1,4],[2,5],[3,6]]) 
test_trans = oh

-- (b) Write a function to multiply two matrices.
matMult : Matrix a i j -> Matrix a j k -> Matrix a i k                        


data Cmp : Nat -> Nat -> Type where
     cmpLT : (y : _) -> Cmp x (x + S y)
     cmpEQ : Cmp x x
     cmpGT : (x : _) -> Cmp (y + S x) y

cmp : (n : Nat) -> (m : Nat) -> Cmp n m
-- implementation missing

plus_nSm : (n : Nat) -> (m : Nat) -> n + S m = S (n + m)
-- implementation missing

plus_commutes : (n : Nat) -> (m : Nat) -> n + m = m + n
-- implementation missing

plus_assoc : (n : Nat) -> (m : Nat) -> (p : Nat) ->
             n + (m + p) = (n + m) + p
-- implementation missing

-- vect_reverse : Vect a n -> Vect a n
-- implementation missing

data Tree a = Leaf | Node (Tree a) a (Tree a)

data ElemTree  : a -> Tree a -> Type where 
     {} -- constructors

elemInTree : DecEq a => (x : a) -> (t : Tree a) -> Maybe (ElemTree x t)
-- implementation missing

