export ProbabilityMass
export events, probabilities, pmf, subset, superset, probability
export prob_max, event_max


struct ProbabilityMass{T}
    # Discrete dataset
    data::DiscreteData

    # Probability mass
    pmf::Dict{T, Float64}
end


function ProbabilityMass(data::DiscreteData)
    # Store each event in the PMF dict and increment for every observation
    pmf::Dict{Any, Float64} = Dict()

    for obs ∈ iter_observations(data)
        if !haskey(pmf, obs)
            pmf[obs] = 0
        end

        pmf[obs] += 1
    end

    # Divide by total number of observations to return PMF
    for event ∈ keys(pmf)
        pmf[event] /= data.nobs
    end

    # return ProbabilityMass(data, pmf)
    return ProbabilityMass(data, pmf)
end


function ProbabilityMass(data::Matrix; byrow=true)
    return ProbabilityMass(DiscreteData(data; byrow))
end


function ProbabilityMass(data::Vector)
    return ProbabilityMass(DiscreteData(data))
end


function events(pmf::ProbabilityMass)
    return keys(pmf.pmf)
end


function probabilities(pmf::ProbabilityMass)
    return values(pmf.pmf)
end


function prob_max(pmf::ProbabilityMass)
    prob = 0
    for p ∈ probabilities(pmf)
        if p > prob
            prob = p
        end
    end
    
    return prob
end


function event_max(pmf::ProbabilityMass)
    event = nothing
    prob = 0
    for (e, p) ∈ pairs(pmf.pmf)
        if p > prob
            event = e
            prob = p
        end
    end

    return event
end


function subset(pmf::ProbabilityMass, dims::Union{Int, Vector{Int}})
    return ProbabilityMass(subset(pmf.data, dims))
end

function superset(pmf1::ProbabilityMass, pmf2::ProbabilityMass)
    return ProbabilityMass(superset(pmf1.data, pmf2.data))
end


function probability(pmf::ProbabilityMass, event)
    if event isa Vector || event isa SubArray
        return pmf.pmf[event]
    end

    # All observations are vectors even if they are singletons
    return pmf.pmf[[event]]
end


function Base.:println(pmf::ProbabilityMass)
    printstyled("\n($(length(pmf.pmf)) events) Probability Mass\n"; color=:red, bold=true)
    for (event, prob) ∈ pairs(pmf.pmf)
        println("$event ⟶ $(round(prob; digits=5))")
    end
end