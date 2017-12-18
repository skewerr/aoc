#!/bin/python3

import sys

registers = {}
compops = {  ">": lambda a, b: a > b
          ,  "<": lambda a, b: a < b
          , ">=": lambda a, b: a >= b
          , "<=": lambda a, b: a <= b
          , "==": lambda a, b: a == b
          , "!=": lambda a, b: a != b }
instops = { "inc": lambda a, b: a + b
          , "dec": lambda a, b: a - b }

historymax = 0

def evalcond(instruction):
    fields = instruction.split(" if ", 1)[1].split()

    loperand = fields[0]
    operator = fields[1]
    roperand = fields[2]

    lnumeric = registers.get(loperand, 0)
    rnumeric = int(roperand)

    return compops[operator](lnumeric, rnumeric)

def evalline(instruction):
    global historymax
    fields = instruction.split()

    lvalue = fields[0]
    aroper = fields[1]
    rvalue = fields[2]

    lnumeric = registers.get(lvalue, 0)
    rnumeric = int(rvalue)

    if evalcond(instruction):
        registers[lvalue] = instops[aroper](lnumeric, rnumeric)

    historymax = max(* registers.values(), historymax)

for line in sys.stdin:
    evalline(line)

print(historymax)
