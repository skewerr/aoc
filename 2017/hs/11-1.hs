import System.IO
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

replace :: Eq a => a -> a -> [a] -> [a]
replace n r h = foldr (\e l -> if e == n then r:l else e:l) [] h

distance :: M.Map String Int -> Int
distance = sum

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

main :: IO ()
main = do
    stepsList <- words . replace ',' ' ' <$> getLine
    let stepsMap = foldr updateSteps startMap stepsList
    print $ distance stepsMap
