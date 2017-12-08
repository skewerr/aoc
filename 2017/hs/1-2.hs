import System.IO
import Data.Char

-- this is so bad, it's just a for loop done poorly

captchaSumR :: [Char] -> Int -> Int
captchaSumR s i =
    let nlen = length s
        step = nlen `div` 2
        cind = (i + step) `mod` nlen
        tsum = if i == nlen - 1 then 0 else captchaSumR s (i + 1)
    in  if s !! i == s !! cind
            then tsum + digitToInt (s !! i)
            else tsum

captchaSum :: [Char] -> Int
captchaSum s = captchaSumR s 0

main :: IO ()
main = do
    num <- getLine
    putStrLn . show . captchaSum $ num
