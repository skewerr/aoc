#!/bin/python3

import sys

checksum = 0

def divpair(lst):
    for a in lst:
        for b in lst:
            if a == b:
                continue
            elif a % b == 0:
                return (a, b)

    return None

for line in sys.stdin:
    values = list(map(int, line.split()))
    nu, de = divpair(values)
    checksum += nu // de

print(checksum)
