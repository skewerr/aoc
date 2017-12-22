import System.IO
import Data.Char

captchaSumR :: [Char] -> Char -> Int
captchaSumR [x] h      |    x == h = digitToInt x
                       | otherwise = 0
captchaSumR (x:y:xs) h |    x == y = digitToInt x + captchaSumR (y:xs) h
                       | otherwise = captchaSumR (y:xs) h

captchaSum :: [Char] -> Int
captchaSum [] = 0
captchaSum num = captchaSumR num $ head num

main :: IO ()
main = do
    number <- getLine
    let cSum = captchaSum number in
        putStrLn $ show cSum
