data = DiscreteData([
    0 0 0 0 0
    0 0 0 1 0
    1 0 0 0 1
    2 1 0 0 1
    2 2 1 0 1
    2 2 1 1 0
    1 2 1 1 1
    0 1 0 0 0
    0 2 1 0 1
    2 1 1 0 1
    0 1 1 1 1
    1 1 0 1 1
    1 0 1 0 1
    2 1 0 1 0
])

id3_tree = DecisionTree(data, "ID3", 5)
println(id3_tree.tree)