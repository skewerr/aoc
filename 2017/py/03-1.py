#!/bin/python3

import math

square = int(input())
lower = math.floor(math.sqrt(square))
upper = math.ceil(math.sqrt(square))

if lower % 2 == 0:
    lower -= 1
if upper % 2 == 0:
    upper += 1

def manhattan(p1, p2):
    x1, y1 = p1
    x2, y2 = p2
    return abs(x1 - x2) + abs(y1 - y2)

def walkto(destination):
    movefs = [
        lambda p: (p[0], p[1] - 1),
        lambda p: (p[0] + 1, p[1]),
        lambda p: (p[0], p[1] + 1),
        lambda p: (p[0] - 1, p[1])
    ]

    corners = [
        (upper // 2, upper // 2),
        (- (upper // 2), upper // 2),
        (- (upper // 2), - (upper // 2)),
        (upper // 2, - (upper // 2))
    ]

    segmentsize = upper - 1
    segment = math.floor((destination - ((lower ** 2) + 1))/segmentsize)

    position = corners[segment]
    movefunc = movefs[segment]
    rangeend = (lower ** 2) + (segment + 1) * (upper - 1)

    for _ in range(rangeend, destination, -1):
        position = movefunc(position)

    return position

print(manhattan(walkto(square), (0, 0)))
