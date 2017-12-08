#!/bin/python3

captchasum = 0
num = input()
numlen = len(num)

for i in range(numlen):
    if num[i] == num[(i + 1) % numlen]:
        captchasum += int(num[i])

print(captchasum)
