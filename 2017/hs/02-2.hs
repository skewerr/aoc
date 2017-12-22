import System.IO
import Data.List

lineChecksum :: String -> Int
lineChecksum str =
    let values = map read . words $ str
        valids = [(a, b) | a <- values, b <- delete a values, a `mod` b == 0]
        validp = head valids
        valid1 = fst validp
        valid2 = snd validp
    in  valid1 `div` valid2

main :: IO ()
main = do
    tableLines <- lines <$> getContents
    putStrLn . show . sum . map lineChecksum $ tableLines
