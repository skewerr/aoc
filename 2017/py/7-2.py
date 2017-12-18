#!/bin/python3

from functools import reduce
import sys

nodes = []
bname = {}

def build_node(string):
    fields = string.split()
    node = { "name": fields[0], "disc": int(fields[1][1:-1]), "children": [] }

    if len(fields) > 2:
        node["children"] = [ cn.rstrip(',') for cn in fields[3:] ]

    bname[node["name"]] = node

    return node

def weight(program):
    w = program["disc"]

    for child in program["children"]:
        w += weight(child)

    return w

def culprit(program, parent=None):
    weights = [weight(child) for child in program["children"]]

    if min(weights) == max(weights):
        return (program, parent)
    else:
        for child in program["children"]:
            if weights.count(weight(child)) == 1:
                return culprit(child, parent=program)

for line in sys.stdin:
    nodes.append(build_node(line))

for node in nodes:
    for i, child in enumerate(node["children"]):
        node["children"][i] = bname[child]
        del bname[child]

for p in bname.values():
    child, parent = culprit(p)

    for otherchild in parent["children"]:
        if weight(otherchild) != weight(child):
            print(child["disc"] + (weight(otherchild) - weight(child)))
            break
