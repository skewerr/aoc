import qualified Data.Set as Set

validPhrase :: String -> Bool
validPhrase line = let wordSets = Set.fromList <$> words line
                       setsSet = Set.fromList wordSets
                   in  Set.size setsSet == length wordSets

main :: IO ()
main = do
    passphrases <- lines <$> getContents
    print . length . filter validPhrase $ passphrases
