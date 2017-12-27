import Data.Char (isDigit)
import qualified Data.Map.Strict as M
import qualified Data.List as L

type ProgramMap = M.Map String [String]

addProgram :: String -> ProgramMap -> ProgramMap
addProgram pl pm =
    let programId = (!! 0) $ words pl
        directPipes = map (filter isDigit) . drop 2 $ words pl
    in  M.insert programId directPipes pm

areLinkedR :: String -> String -> [String] -> ProgramMap -> Bool
areLinkedR p1 p2 hs pm =
    let pipes = (M.findWithDefault [] p1 pm) L.\\ hs
        newHs = p1 : hs
    in  if p1 == p2 || p2 `elem` pipes
            then True
            else foldl (||) False $ map (\p -> areLinkedR p p2 newHs pm) pipes

areLinked :: String -> String -> ProgramMap -> Bool
areLinked p1 p2 pm = areLinkedR p1 p2 [] pm

group :: String -> ProgramMap -> [String]
group t pm = filter (\p -> areLinked p t pm) . M.keys $ pm

groupCount :: ProgramMap -> Int
groupCount pm =
    if pm == M.empty
        then 0
        else let programs = M.keys pm
                 target = programs !! 0
                 group1 = group target pm
                 newMap = foldr M.delete pm group1
             in  1 + groupCount newMap

main :: IO ()
main = do
    programMap <- foldr addProgram M.empty . lines <$> getContents
    print $ groupCount programMap
