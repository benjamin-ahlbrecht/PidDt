export Node, Leaf
export add_children!, find_root


mutable struct Node
    
    # Value of the node (Index of the dimension split)
    value::Int64
    
    # Parent of the node
    parent::Node

    # Children of the node
    children::Dict{Any, Node}

    # Incomplete initialization constructor
    Node() = (x = new(); x.parent=x)
end


function Node(value::Int64)
    node::Node = Node()
    node.value = value
    node.children = Dict{Any, Node}()

    return node
end


function add_children!(parent::Node, child::Node, label::Any)
    parent.children[label] = child
    child.parent::Node = parent

    return parent
end


function add_children!(parent::Node, children::Vector{Node}, labels::Vector)
    if length(children) != length(labels)
        error("There must be an equal number of children and labels")
    end

    for i = 1:length(children)
        add_children!(parent, children[i], labels[i])
    end

    return parent
end


function find_root(node::Node)
    if node.parent == node
        return node
    end

    return find_root(node.parent)
end


function Base.:println(node::Node; depth::Int=0)
    # Print header
    if depth == 0
        printstyled("\n⟨Node⟩\n", color=:red, bold=true)
    end

    # Print body
    print(print_helper(node))
    println(node.value)

    # Recursive call (Base case when no children remain and no iteration occurs)
    for child ∈ values(node.children)
        println(child; depth=depth+1)
    end

    # Padding at end of print
    if depth == 0
        println()
    end
end


function print_helper(node::Node; line::String="", depth::Int=0)
    # If we are at the root node, then we may stop
    if node.parent == node
        return line
    end

    # Print output depends on the depth from the current node and child position
    if islast(node)
        # Either "    " or "└── "
        if depth == 0
            return print_helper(node.parent; line=string("└── ", line), depth=depth+1)
        else
            return print_helper(node.parent; line=string("    ", line), depth=depth+1)
        end
    else
        # Either "├── " or "│   "
        if depth == 0
            return print_helper(node.parent; line=string("├── ", line), depth=depth+1)
        else
            return print_helper(node.parent; line=string("│   ", line), depth=depth+1)
        end
    end

end


function islast(node::Node)
    if node.parent == node
        return false
    end

    children::Vector{Node} = collect(values(node.parent.children))
    nchildren::Int64 = length(children)
    last::Node = children[nchildren]
    
    if node == last
        return true
    end

    return false
end