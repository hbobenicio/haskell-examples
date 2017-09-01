module Main where

import System.Environment (getEnv)
import Data.List (sort)

import qualified Data.Map as Map -- From the 'containers' library
import Data.List.Split (splitOn) -- From the 'split' library
import qualified Data.Set as Set -- From the 'containers' library

import qualified Checkpath.Histogram as Histogram

type Path = String
type PathHistogram = Histogram.Histogram Path

expandPath :: String -> [Path]
expandPath path = splitOn ":" path

expandPathAndSort :: String -> [Path]
expandPathAndSort path = sort $ expandPath path

putPathLn :: [Path] -> IO ()
putPathLn pathList = mapM_ putStrLn formattedPathList
  where
    indexedPathList = zip [1..] pathList -- :: [(Int, Path)]
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
