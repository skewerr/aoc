import System.IO
import qualified Data.Map.Strict as M

type RegisterMap = M.Map String Int
type Instruction = String
type Condition = [String]

memoMap = M.singleton "__max__" 0
instMap = M.fromList [ ("inc", (+)), ("dec", (-)) ]
compMap = M.fromList [ (">", (>)), ("<", (<))
                     , (">=", (>=)), ("<=", (<=))
                     , ("==", (==)), ("!=", (/=)) ]

evalCondition :: RegisterMap -> Condition -> Bool
evalCondition regmap [l,o,r] =
    let leftHS = M.findWithDefault 0 l regmap
        rightHS = read r
        operator = compMap M.! o
    in  leftHS `operator` rightHS

evalInstruction :: RegisterMap -> Instruction -> RegisterMap
evalInstruction regmap inst =
    let fields = words inst
        register = fields !! 0
        leftHS = M.findWithDefault 0 register regmap
        rightHS = read $ fields !! 2
        operator = instMap M.! (fields !! 1)
        condition = snd . splitAt 4 $ fields
    in  if evalCondition regmap condition
            then updateMaximum $ M.insert register (leftHS `operator` rightHS) regmap
            else regmap

updateMaximum :: RegisterMap -> RegisterMap
updateMaximum m = let newMaximum = max (maximum m) (m M.! "__max__")
                  in  M.insert "__max__" newMaximum m

main :: IO ()
main = do
    instructions <- lines <$> getContents
    print . (M.! "__max__") . foldl evalInstruction memoMap $ instructions
