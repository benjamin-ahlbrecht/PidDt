export id3_tree

# function id3_tree(data::DiscreteData, sources::Vector{Int}, target::Int)
#     return Node()
# end

function id3_tree(data::DiscreteData, sources::Vector{Int}, target::Int;
                  tree::Node=Node(-1))
    target_pmf::ProbabilityMass = ProbabilityMass(subset(data, target))

    # If the target is certain, we can make a decision on that
    argpmax = event_max(target_pmf)
    if probability(target_pmf, argpmax) == 1.0
        tree.value = argpmax[1]
        return tree
    end
    
    # Find the source shares that shares the most information with the target
    mi_max::Vector{Union{Int, Float64}} = [0, 0.0, 0]
    for (i, source) ∈ enumerate(sources)
        println(source)
        # Calculate the mutual information between the source and target
        source_pmf::ProbabilityMass = ProbabilityMass(subset(data, source))
        
        mi::Float64 = mutual_information(source_pmf, target_pmf)
        if mi > mi_max[2]
            # The current maximal mutual information
            mi_max[2] = mi

            # The index in the dataset of the current maximal MI
            mi_max[1] = source

            # The index in the sources vector holding the current maximal MI
            mi_max[3] = i
        end
    end

    # Split on the source with the most information to reduce uncertainty
    tree.value::Int = mi_max[1]
    source_max::Int = mi_max[1]
    source_data::DiscreteData = subset(data, source_max)
    source_values::Vector = unique(source_data)

    # Pop the source so we don't re-use it in further function calls
    popat!(sources, mi_max[3])

    # By splitting on the source, we will condition on each realization
    for value ∈ source_values
        # Condition the data and make a child for each realization
        data_cond::DiscreteData = condition(data, source_max, value)
        println(data_cond)

        # Recurse on the child to determine the value of its node (use -1 as tmp)
        node::Node = Node(-1)
        add_children!(tree, node, value)
        id3_tree(data_cond, sources, target; tree=tree.children[value])
    end

    # Return the final (fully-filled) tree
    return tree
end