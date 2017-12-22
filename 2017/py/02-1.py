#!/bin/python3

import sys

checksum = 0

for line in sys.stdin:
    values = list(map(int, line.split()))
    minval = min(values)
    maxval = max(values)
    checksum += maxval - minval

print(checksum)
