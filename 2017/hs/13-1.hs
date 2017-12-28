import Debug.Trace
import Data.Char (isDigit)
import Data.Maybe (fromMaybe)
import qualified Data.Map.Strict as M

data ScanDir = Up | Down deriving Eq
type Layer = ([Bool], ScanDir)
type LayerWD = (Int, Layer)
type Firewall = M.Map Int Layer

shift :: [a] -> ScanDir -> [a]
shift [] _ = []
shift (x:xs) Up = xs ++ [x]
shift l Down = (last l) : (take (length l - 1) l)

layerStep :: Layer -> Layer
layerStep ([], d) = ([], d)
layerStep (r, d) =
    let nd | r !! 0 = Down
           | last r = Up
           | otherwise = d
    in  (shift r nd, nd)

firewallStep :: Firewall -> Firewall
firewallStep = fmap layerStep

createLayerWD :: String -> LayerWD
createLayerWD s =
    let [depth, range] = map (read . filter isDigit) . words $ s
        rangeList = True : (take (range - 1) . repeat $ False)
        initialDir = Down
    in  (depth, (rangeList, initialDir))

populateWall :: Firewall -> Firewall
populateWall fw =
    let keys = M.keys fw
        depthR = [minimum keys .. maximum keys]
    in  foldr (M.alter (Just . fromMaybe ([], Down))) fw depthR

severity :: LayerWD -> Int
severity (_,([],_)) = 0
severity (d,(r,_))
    | r !! 0 = d * length r
    | otherwise = 0

tripSeverity :: Firewall -> Int
tripSeverity fw =
    let keys = M.keys fw
        depthR = [minimum keys .. maximum keys]
        states = zip depthR $ iterate firewallStep fw
        severities = map (\(d,m) -> severity (d, m M.! d)) states
    in  sum severities

main :: IO ()
main = do
    initialWall <- M.fromList . map createLayerWD . lines <$> getContents
    let populatedWall = populateWall initialWall
    print $ tripSeverity populatedWall
