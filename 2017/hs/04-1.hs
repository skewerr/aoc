import qualified Data.Set as Set

validPhrase :: String -> Bool
validPhrase line = let wordList = words line
                       wordSet = Set.fromList wordList
                   in  Set.size wordSet == length wordList

main :: IO ()
main = do
    passphrases <- lines <$> getContents
    print . length . filter validPhrase $ passphrases
