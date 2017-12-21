import System.IO
import Data.List.Split (splitOn)
import qualified Data.Map.Strict as M

directions :: [String]
directions = ["n", "ne", "se", "s", "sw", "nw"]

count :: Eq a => a -> [a] -> Int
count e = length . filter (== e)

main :: IO ()
main = do
    steps <- splitOn "," <$> getLine
    let
        stepsMap = M.fromList [(d,c) | d <- directions, let c = count d steps]
        northCnv = min (stepsMap M.! "ne") (stepsMap M.! "nw")
        southCnv = min (stepsMap M.! "se") (stepsMap M.! "sw")
        diagWeEa = abs $ stepsMap M.! "nw" - stepsMap M.! "se"
        diagEaWe = abs $ stepsMap M.! "ne" - stepsMap M.! "sw"
        northNew = stepsMap M.! "n" + northCnv
        southNew = stepsMap M.! "s" + southCnv
        vertWalk = abs $ northNew - southNew
        diagWalk = abs $ diagWeEa - diagEaWe
    print $ vertWalk + diagWalk
