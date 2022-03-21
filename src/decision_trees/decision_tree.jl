export DecisionTree
export predict


struct DecisionTree
    # The tree to follow when making predictions
    tree::Node

    # The type of decision tree constructed
    type::String

    # The underlying data used to construct the tree
    data::DiscreteData

    # The indices for the source variables (predictors)
    sources::Vector{Int}

    # The index of the target variable
    target::Int
end


function DecisionTree(data::DiscreteData, type::String, target::Int)
    sources::Vector{Int} = collect(1:data.ndims)
    popat!(sources, target)
    return DecisionTree(data, type, target, sources)
end


function DecisionTree(data::DiscreteData, type::String, target::Int, source::Int)
    return DecisionTree(data, type, target, [source])
end


function DecisionTree(data::DiscreteData, type::String, target::Int, sources::Vector{Int})
    methods::Dict{String, Function} = Dict(
        "ID3" => id3_tree,
        "C45" => c45_tree,
        "PID" => pid_tree
    )

    # Use a dictionary to dynamically call the right method without using ifs
    tree::Node = methods[uppercase(type)](data, sources, target)
    dtree::DecisionTree = DecisionTree(tree, uppercase(type), data, sources, target)

    return dtree
end