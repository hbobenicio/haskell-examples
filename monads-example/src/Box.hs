module Box
( Box(..)
, incBox
)
where

data Box t = Box t deriving (Show)

instance Functor Box where
  fmap f (Box x) = Box (f x)

instance Applicative Box where
  pure = Box
  Box f <*> Box x = Box (f x)

instance Monad Box where
  return x = Box x
  (Box x) >>= f = f x

incBox :: (Num t) => t -> Box t
incBox x = Box (x + 1)

-- >> Box 10 >>= incBox >>= incBox
-- Box 12
