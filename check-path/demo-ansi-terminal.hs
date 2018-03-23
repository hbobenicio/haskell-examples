import System.Console.ANSI

main = do
  setSGR [ SetConsoleIntensity BoldIntensity
         , SetColor Foreground Vivid Red
         ]
  putStr "Hello"

  setSGR [ SetConsoleIntensity NormalIntensity
         , SetColor Foreground Vivid White
         , SetColor Background Dull Blue
         ]
  putStrLn "World!"
  setSGR [Reset]
