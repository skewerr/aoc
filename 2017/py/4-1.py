#!/bin/python3

import sys

valid = 0

for line in sys.stdin:
    words = line.split()
    wdset = set(words)

    if len(words) == len(wdset):
        valid += 1

print(valid)
