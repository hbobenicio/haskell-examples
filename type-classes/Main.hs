-- Example borrowed from
-- http://learnyouahaskell.com/making-our-own-types-and-typeclasses#a-yes-no-typeclass
module Main where

class YesNo a where
  yesno :: a -> Bool

instance YesNo Int where
  yesno 0 = False
  yesno _ = True

instance YesNo [a] where
  yesno [] = False
  yesno _  = True

instance YesNo Bool where
  yesno = id

instance YesNo (Maybe a) where
  yesno (Just _) = True
  yesno Nothing = False

yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf ynVal ynTrue ynFalse = if yesno ynVal then ynTrue else ynFalse

data Caixa x = Algo x
             | Nada
             deriving Show

instance YesNo (Caixa x) where
  yesno (Algo _) = True
  yesno Nada = False

-- instance Show (Caixa x) where
--   show (Algo x) = "Algo " ++ (show x)
--   show Nada = ""

instance Functor Caixa where
  fmap f (Algo x) = Algo (f x)
  fmap _ Nada = Nada
