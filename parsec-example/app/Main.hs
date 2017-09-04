module Main where

import ParsecExample

main :: IO ()
main = do
  contents <- getContents
  case parsePositionalFile contents of
    Right registers -> mapM_ (putStrLn . show) registers
    Left e -> do
      putStrLn "Parsing Error:"
      print e
