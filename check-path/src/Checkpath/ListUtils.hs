module Checkpath.ListUtils
( hasDuplicates
) where

import qualified Data.Set as Set -- From the 'containers' library

hasDuplicates :: (Ord a) => [a] -> Bool
hasDuplicates list = length list /= length set
  where set = Set.fromList list
