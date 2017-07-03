module Main where

add :: Int -> Int -> Int
add x y = x + y

-- With Currying, you can 'partially' apply
-- some function with fewer parameters.
-- Doing so will give you a function as result.
-- This resulting function would accept the remaining parameters
-- that were not applyed and return the same result as the
-- original function.
addFive = add 5
addTen = add 10

main = do
  let x = addFive 10
  let y = addTen 5
  let thirty = x + y
  putStrLn $ show thirty
