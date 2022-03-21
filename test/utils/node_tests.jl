println("<<node_tests.jl>>")


# Construct a couple blank nodes
n1 = Node(1)
n2 = Node(2)
n3 = Node(3)

println(n1)
println(n2)

# Make n2 a child of n1 with a label of '1'
add_children!(n1, n2, '1')

# Make n3 a child of n2 with a label of '2'
add_children!(n2, n3, '2')


# Tests to ensure node-relationships are correct
@test n1.children['1'].parent == n1
@test n1.children['1'] == n2
@test n1.children['1'].children['2'] == n3

@test n2.parent == n1
@test n3.parent == n2
@test n3.parent.parent == n1


# Construct a few more blank nodes
n1 = Node(1)
n2 = Node(2)
n3 = Node(3)

# Make n2 and n3 children of n1 with labels '1' and '2', respectively
add_children!(n1, [n2, n3], ['1', '2'])

@test n1.children['1'].parent == n1
@test n1.children['2'].parent == n1
@test n2 != n3

# Add some more children to n1, n2, and n3, then find the root nodes
n4 = Node(4)
n5 = Node(5)
n6 = Node(6)
n7 = Node(7)
n8 = Node(8)

add_children!(n1, n4, '3')
add_children!(n2, [n5, n6], ['4', '5'])
add_children!(n4, n7, '6')
add_children!(n6, n8, '7')

@test find_root(n1) == n1
@test find_root(n2) == n1
@test find_root(n3) == n1
@test find_root(n4) == n1
@test find_root(n5) == n1
@test find_root(n6) == n1
@test find_root(n7) == n1


# Print the final tree
println(n1)

"""
n1:
    1
    |
    ---- 2
    |    |
    |    ---- 5
    |    |
    |    ---- 6
    |         |
    |         ---- 8
    |
    ---- 3
    |
    ---- 4
         |
         ---- 7
"""