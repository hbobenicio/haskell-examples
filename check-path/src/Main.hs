module Main where

import System.Environment (getEnv)
import Data.List.Split (splitOn)

expandPath :: String -> [String]
expandPath path = splitOn ":" path

putPathLn :: [String] -> IO ()
putPathLn pathList = mapM_ putStrLn pathList

main :: IO ()
main = do
  path <- getEnv "PATH"
  (putPathLn . expandPath) path
