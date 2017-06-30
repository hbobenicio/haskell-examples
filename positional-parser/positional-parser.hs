import Data.List

-- Just preparing the datastructure for line processing
prepare :: String -> ([String], String)
prepare linha = ([], linha)

-- Consuming Logic:
--   1. Splits the line on determined position N
--   2. Appends it to the resulting list
--   3. Returns the same datastructure for future processings through composition
consume :: Int -> ([String], String) -> ([String], String)
consume n (fields, line) = (fields ++ [field], consumedLine)
  where (field, consumedLine) = splitAt n line

-- Using Currying for customizing
-- each field size
consumeFirst = consume 5
consumeSecond = consume 6
consumeThird = consume 6

main = do
  let line = "25101170007089280"
  let (fields, _) = (consumeThird . consumeSecond . consumeFirst) (prepare line)
  let finalFields = (intersperse ";" fields) ++ ["\n"]
  mapM putStr finalFields

