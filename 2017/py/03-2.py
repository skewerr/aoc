#!/bin/python3

from collections import deque

ground = int(input())
memory = { (0,0): 1 }

def sumneighbors(position):
    nsum = 0
    x, y = position

    for i in range(x - 1, x + 2):
        for j in range(y - 1, y + 2):
            if (i,j) == position:
                continue
            else:
                nsum += memory.get((i,j), 0)

    memory[position] = nsum

    return nsum

def walkto(query):
    movefs = deque([
        lambda p: (p[0], p[1] + 1),
        lambda p: (p[0] - 1, p[1]),
        lambda p: (p[0], p[1] - 1),
        lambda p: (p[0] + 1, p[1])
    ])

    cpos = (0,0)
    csum = memory[cpos]

    while csum <= query:
        cpos = movefs[0](cpos)
        csum = sumneighbors(cpos)

        # turn when there's no one to my left
        if movefs[1](cpos) not in memory:
            movefs.rotate(-1)

    return (cpos, csum)

print(walkto(ground))
