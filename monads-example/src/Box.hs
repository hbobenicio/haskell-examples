module Box
( Box(..)
, incBox
)
where

data Box t = Box t deriving (Show)

instance Functor Box where
  fmap f (Box x) = Box (f x)

instance Applicative Box where
  pure = Box -- pure = return?
  Box f <*> Box x = Box (f x) -- <*> = ap ?

instance Monad Box where
  return x = Box x -- return = Box ?
  (Box x) >>= f = f x

incBox :: (Num t) => t -> Box t
incBox x = Box (x + 1)

-- >> Box 10 >>= incBox >>= incBox
-- Box 12
