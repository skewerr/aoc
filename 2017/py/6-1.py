#!/bin/python3

banks = [int(word) for word in input().split()]
state = tuple(banks)
bankn = len(banks)
seen = []

while state not in seen:
    seen.append(state)

    redistb = max(banks)
    redisti = banks.index(redistb)

    banks[redisti] = 0

    while redistb > 0:
        redisti = (redisti + 1) % bankn
        banks[redisti] += 1
        redistb -= 1

    state = tuple(banks)

print(len(seen))
