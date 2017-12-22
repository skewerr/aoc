import System.IO
import Data.List.Split (splitOn)
import qualified Data.Map.Strict as M

directions :: [String]
directions = ["n", "ne", "se", "s", "sw", "nw"]

startMap :: M.Map String Int
startMap = M.fromList . zip directions $ repeat 0

compMap = M.fromList [ ("nw", ("se", ( "s", "sw"), ("ne",  "n")))
                     , ("ne", ("sw", ( "s", "se"), ("nw",  "n")))
                     , ( "n", ( "s", ("se", "ne"), ("sw", "nw")))
                     , ("se", ("nw", ( "n", "ne"), ("sw",  "s")))
                     , ("sw", ("ne", ( "n", "nw"), ("se",  "s")))
                     , ( "s", ( "n", ("ne", "se"), ("nw", "sw"))) ]

distance :: M.Map String Int -> Int
distance = sum . M.delete "_max"

updateSteps :: String -> M.Map String Int -> M.Map String Int
updateSteps k m
    | m M.!  z > 0 = dec z m
    | m M.! d1 > 0 = dec d1 . inc i1 $ m
    | m M.! d2 > 0 = dec d2 . inc i2 $ m
    |    otherwise = inc k m
    where
        (z, (d1, i1), (d2, i2)) = compMap M.! k
        dec k = M.insertWith (flip (-)) k 1
        inc k = M.insertWith (+) k 1

updateStepsWM :: String -> M.Map String Int -> M.Map String Int
updateStepsWM k m =
    let um = updateSteps k m
    in  M.insertWith max "_max" (distance um) um

main :: IO ()
main = do
    stepsMap <- foldl (flip updateStepsWM) startMap <$> splitOn "," <$> getLine
    print $ stepsMap M.! "_max"
