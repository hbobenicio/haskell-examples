module Main where

import System.Environment (getEnv)
import Data.List (sort)
import Data.List.Split (splitOn) -- From the 'split' library
import qualified Data.Set as Set -- From the 'containers' library

expandPath :: String -> [String]
expandPath path = splitOn ":" path

expandPathAndSort :: String -> [String]
expandPathAndSort path = sort $ expandPath path

putPathLn :: [String] -> IO ()
putPathLn pathList = mapM_ putStrLn formattedPathList
  where
    indexedPathList = zip [1..] pathList
    formattedPathList = map (\(i,s) -> show i ++ ". " ++ s) indexedPathList

hasDuplicates :: (Ord a) => [a] -> Bool
hasDuplicates list = length list /= length set
  where set = Set.fromList list

main :: IO ()
main = do
  path <- getEnv "PATH"
  let pathList = expandPath path
  putPathLn pathList
  putStrLn ""
  putStrLn (if hasDuplicates pathList then "Your PATH has duplicates!" else "Your PATH has no duplicates.")
