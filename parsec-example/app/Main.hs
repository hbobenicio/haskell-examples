module Main where

import ParsecExample

import System.Environment
import System.Exit

main :: IO ()
main = do
  args <- getArgs
  contents <- if null args then getContents else readFile $ head args
  case parsePositionalFile contents of
    Right registers ->
      mapM_ print registers
    Left e -> do
      putStrLn "Parsing Error:"
      print e
