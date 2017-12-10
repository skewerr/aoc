#!/bin/python3

import sys

valid = 0

for line in sys.stdin:
    words = line.split()
    wsets = [ frozenset(word) for word in words ]
    wdset = set(wsets)

    if len(wdset) == len(wsets):
        valid += 1

print(valid)
