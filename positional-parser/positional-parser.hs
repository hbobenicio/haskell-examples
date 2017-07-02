import Data.List (intersperse)
import Control.Arrow ((>>>))

-- Just prepares the datastructure for line processing
prepare :: String -> ([String], String)
prepare linha = ([], linha)

-- Consuming Logic:
--   1. Splits the line on determined position N
--   2. Appends it to the resulting list (at the head, yielding in a reversed list of fields!)
--   3. Returns the same datastructure for future processings through function composition
consume :: Int -> ([String], String) -> ([String], String)
consume n (fields, line) =
  let
    (field, consumedLine) = splitAt n line
  in
    (field : fields, consumedLine)

-- Finishes the parsing by reversing the reversed list got from consumption
-- Returns the fields list in the right order
finish :: ([String], String) -> [String]
finish (reversedFields, _) = reverse reversedFields

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
  let csvFields = intersperse ";" fields -- Interpolates ";" between fields
  mapM putStr (csvFields ++ ["\n"]) -- Print every field and a line feed at the end

