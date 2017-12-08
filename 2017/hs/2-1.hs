import System.IO

lineChecksum :: String -> Int
lineChecksum str =
    let values = map read . words $ str
        minVal = minimum values
        maxVal = maximum values
    in  maxVal - minVal

main :: IO ()
main = do
    tableLines <- lines <$> getContents
    putStrLn . show . sum . map lineChecksum $ tableLines
