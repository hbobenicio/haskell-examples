type ParsingResult a = [(a, String)]
type Parser a = String -> ParsingResult a

char :: Parser Char
char [] = []
char (x:xs) = [(x, xs)]
char' = \input -> case input of
  [] -> []
  (x:xs) -> [(x, xs)]

failure :: Parser a
failure _ = []
failure' = \input -> []

return :: a -> Parser a
return v input = [(v, input)]
return' v = \input -> [(v, input)]

(+++) :: Parser a -> Parser a -> Parser a
p1 +++ p2 = \input -> case p1 input of
  [] -> p2 input
  p1Output -> p1Output

chunk :: Int -> Parser String
chunk _ [] = []
chunk n input = [splitAt n input]


{--
-- Tenho que ter os seguintes parsers:
staNum :: String -> Num -- (Sta Domain)
chunk :: Int -> String -> String -- (Generic Domain)
--
ug :: String -> UnidadeGestora -- (Business Domain)
gestao :: String -> Gestao -- (Business Domain)
--}
