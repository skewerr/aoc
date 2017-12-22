#!/bin/python3

import sys

nodes = []
bname = {}

def build_node(string):
    fields = string.split()
    node = { "name": fields[0], "disc": fields[1], "children": [] }

    if len(fields) > 2:
        node["children"] = [ cn.rstrip(',') for cn in fields[3:] ]

    bname[node["name"]] = node

    return node

for line in sys.stdin:
    nodes.append(build_node(line))

for node in nodes:
    for i, child in enumerate(node["children"]):
        node["children"][i] = bname[child]
        del bname[child]

print(bname.keys())
