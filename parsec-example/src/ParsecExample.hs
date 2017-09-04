module ParsecExample
( parsePositionalFile
) where

import Text.ParserCombinators.Parsec
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language


data Register = Register
  { registerUO :: String
  , registerUGR :: String
  } deriving Show

registerParser :: Parser Register
registerParser = do
  uo <- count 5 digit
  ugr <- count 6 digit
  return Register { registerUO = uo
                  , registerUGR = ugr
                  }

line :: Parser Register
line = do
  register <- registerParser
  eol
  return register

-- Borrowed from http://book.realworldhaskell.org/read/using-parsec.html
eol :: Parser String
eol = try (string "\n\r")
  <|> try (string "\r\n")
  <|> string "\n"
  <|> string "\r"
  <?> "end of line"

positionalParser :: Parser [Register]
positionalParser = do
  registers <- many line -- jump line?!
  eof
  return registers

parsePositionalFile = parse positionalParser "positionalParser"
