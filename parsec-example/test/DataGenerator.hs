line :: String
line = foldr (++) "" [replicate i c | (i,c) <- zip [1..] ['A'..'Z'] ]

putLine :: Int -> IO ()
putLine = \n -> case n of
  0 -> return ()
  n -> do
    putStrLn line
    putLine $ n - 1

main :: IO ()
main = putLine 1000
