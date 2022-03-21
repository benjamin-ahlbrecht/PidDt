export conditional_entropy, conditional_entropy_locals


function conditional_entropy(pmf::ProbabilityMass,
                             conds::Union{Int, Vector{Int}}; base::Number=2)
    entropy::Float64 = 0.0

    # Determine the marginal PMF
    pmf_marginal::ProbabilityMass = subset(pmf, conds)

    # Iterate over each observed combination of events
    for joint_event::Vector ∈ events(pmf)
        marginal_event = joint_event[conds]

        # Extract the probabilities the joint and marginal events
        p_joint::Float64 = probability(pmf, joint_event)
        p_marginal::Float64 = probability(pmf_marginal, marginal_event)

        entropy -= p_joint * log(base, p_joint / p_marginal)
    end

    return entropy
end


function conditional_entropy(data::DiscreteData,
                             conds::Union{Int, Vector{Int}}; base::Number=2)
    return conditional_entropy(ProbabilityMass(data), conds; base=base)
end


function conditional_entropy(data::Matrix, conds::Union{Int, Vector{Int}};
                             base::Number=2, byrow::Bool=true)
    return conditional_entropy(ProbabilityMass(data; byrow=byrow), conds;
                               base=base)
end


function conditional_entropy_locals(pmf::ProbabilityMass,
                                    conds::Union{Int, Vector{Int}};
                                    base::Number=2)
    # Determine the marginal PMF
    pmf_marginal::ProbabilityMass = subset(pmf, conds)

    # We will hold the joint event as a key and conditional entropy as a value
    entropy::Dict{Vector, Float64} = Dict()
    for joint_event::Vector ∈ events(pmf)
        marginal_event = joint_event[conds]
        
        # Find marginal and joint probabilites
        p_joint::Float64 = probability(pmf, joint_event)
        p_marginal::Float64 = probability(pmf_marginal, marginal_event)

        # Compute the local conditional entropy for the joint/marginal event
        entropy[joint_event] = -log(base, p_joint / p_marginal)
    end

    return entropy
end


function conditional_entropy_locals(data::DiscreteData,
                                    conds::Union{Int, Vector{Int}};
                                    base::Number=2)
    return conditional_entropy_locals(ProbabilityMass(data), conds; base=base)
end


function conditional_entropy_locals(data::Matrix,
                                    conds::Union{Int, Vector{Int}};
                                    base::Number=2, byrow::Bool=true)
    return conditional_entropy_locals(ProbabilityMass(data; byrow=byrow),
                                      conds; base=base)
end