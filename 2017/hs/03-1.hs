import System.IO

data Queue a = Queue [a]

shift :: Queue a -> Queue a
shift (Queue (x:xs)) = Queue (xs ++ [x])

peek :: Queue a -> a
peek (Queue (x:xs)) = x

type Position = (Int, Int)

moveUp    (x, y) = (x, y + 1)
moveDown  (x, y) = (x, y - 1)
moveLeft  (x, y) = (x - 1, y)
moveRight (x, y) = (x + 1, y)

move :: (Position, Queue (Position -> Position)) -> (Position, Queue (Position -> Position))
move (p@(x,y), q) = let newQueue = if abs x == abs y then shift q else q
                        moveFunction = peek newQueue
                        newPosition = moveFunction p
                    in  (newPosition, newQueue)

manhattan :: Position -> Position -> Int
manhattan (x,y) (a,b) = abs (x - a) + abs (y - b)

sideBounds :: Int -> (Int, Int)
sideBounds n = let sqLower = floor . sqrt $ fromIntegral n
                   sqUpper = ceiling . sqrt $ fromIntegral n
                   bdLower = if sqLower `mod` 2 == 0
                                then sqLower - 1
                                else sqLower
                   bdUpper = if sqUpper `mod` 2 == 0
                                then sqUpper + 1
                                else sqUpper
               in  (bdLower, bdUpper)

walkTo :: Int -> Position
walkTo n = let (sqLower, sqUpper) = sideBounds n
               startSquare = sqLower ^ 2 + 1
               startPosition = ((sqLower + 1) `div` 2, (- (sqLower `div` 2)))
               functionQueue = Queue [moveUp, moveLeft, moveDown, moveRight]
               startPair = (startPosition, functionQueue)
           in  fst $ foldr (\_ pair -> move pair) startPair [startSquare + 1 .. n]

main :: IO ()
main = do
    square <- read <$> getLine
    print . manhattan (0,0) $ walkTo square
