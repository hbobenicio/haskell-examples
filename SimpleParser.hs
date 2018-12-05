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
consumeUO = consume 5
consumeUGR = consume 6
consumePTRes = consume 6

main = do
  let line = "25101170007089280"
  let (fields, _) = (consumePTRes . consumeUGR . consumeUO) (prepare line)
  let finalFields = (intersperse ";" fields) ++ ["\n"]
  mapM putStr finalFields

