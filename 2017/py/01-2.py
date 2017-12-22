#!/bin/python3

captchasum = 0
num = input()
numlen = len(num)
step = numlen >> 1

for i in range(numlen):
    if num[i] == num[(i + step) % numlen]:
        captchasum += int(num[i])

print(captchasum)
