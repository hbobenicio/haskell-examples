module Main where

import System.Environment (getEnv)
import Data.List.Split (splitOn) -- From the 'split' library

expandPath :: String -> [String]
expandPath path = splitOn ":" path

putPathLn :: [String] -> IO ()
putPathLn pathList = mapM_ putStrLn formattedPathList
  where
    indexedPathList = zip [1..] pathList
    formattedPathList = map (\(i,s) -> show i ++ ". " ++ s) indexedPathList

main :: IO ()
main = do
  path <- getEnv "PATH"
  (putPathLn . expandPath) path
