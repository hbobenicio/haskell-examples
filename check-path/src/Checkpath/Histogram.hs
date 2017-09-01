module Checkpath.Histogram
( Histogram(..)
)
where

import qualified Data.Map as Map -- From the 'containers' library

type Histogram a = Map.Map a Int

-- fromList :: (Eq a) => [a] -> Histogram a
-- fromList xs = 
