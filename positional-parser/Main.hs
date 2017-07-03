module Main where

import qualified Data.List as List
import Control.Arrow ((>>>))
import PositionalParser (prepare, consume, finish)

-- Using Currying for customizing
-- each field size
consumeFirst = consume 5
consumeSecond = consume 6
consumeThird = consume 6

-- Composing the parsing function.
-- The (>>>) operator works like the inverse order of function composition operator (.)
-- In other words: (g . f) == (f >>> g)
-- This works similar to F#, Elixir's and Elm Pipe Operator '|>'
parseLine = prepare >>> consumeFirst >>> consumeSecond >>> consumeThird >>> finish

main = do
  let line = "25101170007089280"
  let fields =  parseLine line -- This yields to a list of fields :: [String]
  let csvFields = List.intersperse ";" fields -- Interpolates ";" between fields
  mapM putStr (csvFields ++ ["\n"]) -- Print every field and a line feed at the end

