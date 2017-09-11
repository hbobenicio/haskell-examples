module Main where

import Data.List.Split (splitOn) -- From the 'split' library
import qualified Data.Map.Strict as Map -- From the 'containers' library
import Data.Maybe (fromMaybe) -- Same behaviour as Optional::orElse from java
import System.Environment (getEnv)
import Checkpath.ListUtils (hasDuplicates)

type Path = String
type Histogram a = Map.Map a Int
type PathHistogram = Histogram Path
type PathHistogramItem = (String, Int)

pathHistogramLookup :: Path -> PathHistogram -> PathHistogramItem
pathHistogramLookup path histogram = (path, count)
  where
    count = fromMaybe 0 (Map.lookup path histogram)

showPathHistogramItem :: PathHistogramItem -> String
showPathHistogramItem (path, count) =
  if count == 1 then path else path ++ " [!!]"

showPath :: Path -> PathHistogram -> String
showPath path histogram = showPathHistogramItem $ pathHistogramLookup path histogram

printPathHistogramItem :: PathHistogramItem -> IO ()
printPathHistogramItem = putStrLn . showPathHistogramItem

expandPath :: String -> [Path]
expandPath = splitOn ":"

putPathLn :: PathHistogram -> [Path] -> IO ()
putPathLn pathHistogram pathList = mapM_ putStrLn formattedPathList
  where
    indexedPathList = zip [1..] pathList -- :: [(Int, Path)]
    formattedPathList = map (\(i,s) -> show i ++ ". " ++ showPath s pathHistogram) indexedPathList

putPathHistogramLn :: PathHistogram -> IO ()
putPathHistogramLn pathHistogram = mapM_ printPathHistogramItem histogramList
  where
    histogramList = Map.assocs pathHistogram

histogramFromPathList :: [Path] -> PathHistogram
histogramFromPathList list = histogramFromPathList' list Map.empty

histogramFromPathList' :: [Path] -> PathHistogram -> PathHistogram
histogramFromPathList' [] histogram = histogram
histogramFromPathList' (x:xs) histogram =
  Map.insertWith (+) x 1 (histogramFromPathList' xs histogram)

main :: IO ()
main = do
  path <- getEnv "PATH"
  let pathList = expandPath path
  let pathHistogram = histogramFromPathList pathList
  putPathLn pathHistogram pathList
  putStrLn ""
  putStrLn (if hasDuplicates pathList then "Your PATH has duplicates!" else "Your PATH has no duplicates.")
