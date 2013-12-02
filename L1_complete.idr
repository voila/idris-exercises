module L1

import Decidable.Equality

-- 1. Write a function repeat : (n : Nat) -> a -> Vect a n which constructs a vector of n
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

-- 3. A matrix is a 2-dimensional vector, and could be deﬁned as follows:

Matrix : Type -> Nat -> Nat -> Type
Matrix a n m = Vect n (Vect m a)

-- (a) Using repeat, above, and Vect.zipWith, write a function which transposes a matrix.
-- Hints: Remember to think carefully about its type ﬁrst! zipWith for vectors is deﬁned as follows:
-- zipWith : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c
-- zipWith f [] [] = []
-- zipWith f (x::xs) (y::ys) = f x y :: zipWith f xs ys

transpose : Matrix a n m -> Matrix a m n
transpose {m} [] = repeat m []
transpose (xs :: xss) = zipWith (::) xs (transpose xss)

-- some Eq instances to test matrices equality

-- instance (Eq a) => Eq (Vect n a) where
--   (==) [] []        = True
--   (==) [] _         = False
--   (==) _  []        = False
--   (==) (x::xs) (y::ys) = x == y && xs == ys
-- 
-- instance (Eq a) => Eq (Matrix a n m) where
--   (==) [] []        = True
--   (==) [] _         = False
--   (==) _  []        = False
--   (==) (xs::xss) (ys::yss) = xs == ys && xss == yss 
--   
-- test_trans : so (transpose [[1,2,3],[4,5,6]] == [[1,4],[2,5],[3,6]]) 
-- test_trans = oh

-- (b) Write a function to multiply two matrices.
matMult : Matrix a i j -> Matrix a j k -> Matrix a i k                        

indices : Matrix a i j -> Matrix a j k -> List (Nat, Nat) -- Vect (i*k) (Nat, Nat)                        
indices {i} {k} m1 m2 = [(x,y) | x <- [0..i], y <- [0..k]]

row : Fin j -> Matrix a i j -> Vect i a
row n vs = map (\v => index n v) vs

col : Fin i -> Matrix a i j -> Vect j a
col n vs = index n vs

len : Vect n a -> Nat
len {n} v = n

m1 : Matrix Nat 3 2
m1 = [[1,4],[2,5],[3,6]]

m2 : Matrix Nat 2 3
m2 = [[1,2,3],[4,5,6]]




-- 4) The following view describes a pair of numbers as a difference:
data Cmp : Nat -> Nat -> Type where
     cmpLT : (y : _) -> Cmp x (x + S y)
     cmpEQ : Cmp x x
     cmpGT : (x : _) -> Cmp (y + S x) y

-- (a) Write the function cmp : (n : Nat) -> (m : Nat) -> Cmp n m which proves that
-- every pair of numbers can be expressed in this way.
-- Hint: recall parity from the lecture. You will ﬁnd the with construct very useful!
-- (b) Assume you have a vector xs : Vect a n, where n is unknown. How could you use cmp to
-- construct a suitable input to vtake and vdrop from xs?

  
cmp : (n : Nat) -> (m : Nat) -> Cmp n m

-- 5. Implement the following functions:

plus_nSm : (n : Nat) -> (m : Nat) -> n + S m = S (n + m)


plus_commutes : (n : Nat) -> (m : Nat) -> n + m = m + n


plus_assoc : (n : Nat) -> (m : Nat) -> (p : Nat) ->
             n + (m + p) = (n + m) + p


-- 6. One way to deﬁne a reverse function for lists is as follows:
-- reverse : List a -> List a
-- reverse xs = revAcc [] xs where
-- revAcc : List a -> List a -> List a
-- revAcc acc [] = acc
-- revAcc acc (x :: xs) = revAcc (x :: acc) xs

-- Write the equivalent function for vectors, vect reverse : Vect a n -> Vect a n
-- Hint: You can use the same structure as the deﬁnition for List, but you will need to think carefully
-- about the type for revAcc, and may need to do some theorem proving.


-- 7. You are given the following deﬁnition of binary trees:
-- data Tree a = Leaf | Node (Tree a) a (Tree a)
-- Deﬁne a membership predicate ElemTree and a function elemInTree which calculates whether a
-- value in in the tree, and a corresponding proof.

-- data ElemTree : a -> Tree a -> Type where 
-- {}  
-- elemInTree : DecEq a => (x : a) -> (t : Tree a) -> Maybe (ElemTree x t)

