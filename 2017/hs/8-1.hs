import System.IO
import qualified Data.Map.Strict as M

type RegisterMap = M.Map String Int
type Instruction = String
type Condition = [String]

memoMap = M.empty
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
            then M.insert register (leftHS `operator` rightHS) regmap
            else regmap

main :: IO ()
main = do
    instructions <- lines <$> getContents
    print . maximum . foldl evalInstruction memoMap $ instructions
