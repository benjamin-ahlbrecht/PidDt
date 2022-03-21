export mutual_information, mutual_information_locals


function mutual_information(pmf_source::ProbabilityMass,
                            pmf_target::ProbabilityMass; base::Number=2)
    # Generate a PMF for the joint random variable
    pmf_joint::ProbabilityMass = superset(pmf_source, pmf_target)

    # Determine where the source and target dimension indices end
    ind_source_end::Int = pmf_source.data.ndims
    ind_target_end::Int = pmf_joint.data.ndims

    mi::Float64 = 0
    # Iterate through each event, extracting joint and marginal probabilities
    for event_joint ∈ events(pmf_joint)
        event_source = event_joint[1:ind_source_end]
        event_target = event_joint[ind_source_end+1:ind_target_end]

        prob_joint::Float64 = probability(pmf_joint, event_joint)
        prob_source::Float64 = probability(pmf_source, event_source)
        prob_target::Float64 = probability(pmf_target, event_target)

        # Compute the mutual information
        mi += prob_joint * log(base, prob_joint / (prob_source * prob_target))
    end

    return mi
end


function mutual_information_locals(pmf_source::ProbabilityMass,
                                   pmf_target::ProbabilityMass; base::Number=2)
    # Generate a PMF for the joint random variable
    pmf_joint::ProbabilityMass = superset(pmf_source, pmf_target)

    # Determine where the source and target dimension indices end
    ind_source_end::Int = pmf_source.data.ndims
    ind_target_end::Int = pmf_joint.data.ndims

    mi::Dict{Vector, Float64} = Dict()
    # Iterate through each event, extracting joint and marginal probabilities
    for event_joint ∈ events(pmf_joint)
        event_source = event_joint[1:ind_source_end]
        event_target = event_joint[ind_source_end+1:ind_target_end]

        prob_joint::Float64 = probability(pmf_joint, event_joint)
        prob_source::Float64 = probability(pmf_source, event_source)
        prob_target::Float64 = probability(pmf_target, event_target)


        # Compute the local mutual information
        mi[event_joint] = log(base, prob_joint / (prob_source * prob_target))
    end

    return mi
end