#!/bin/python3

import sys

pcreg = 0
steps = 0
jumps = [int(line) for line in sys.stdin]
taddr = len(jumps)

while pcreg < taddr:
    newpc = pcreg + jumps[pcreg]
    jumps[pcreg] += 1 if jumps[pcreg] < 3 else -1
    pcreg = newpc
    steps += 1

print(steps)
