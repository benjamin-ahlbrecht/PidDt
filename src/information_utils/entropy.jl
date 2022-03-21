export entropy, entropy_locals


function entropy(pmf::ProbabilityMass; base::Number=2)
    return -sum([p * log(base, p) for p in probabilities(pmf)])
end


function entropy(data::DiscreteData; base::Number=2)
    return entropy(ProbabilityMass(data); base)
end


function entropy(data::Matrix; base::Number=2, byrow::Bool=true)
    return entropy(DiscreteData(data; byrow); base)
end


function entropy(data::Vector; base::Number=2)
    return entropy(DiscreteData(data); base)
end


function entropy_locals(pmf::ProbabilityMass; base::Number=2)
    entropy::Dict{Vector, Float64} = Dict(
        event => -log(base, prob) for (event, prob) ∈ pairs(pmf.pmf))
    
    return entropy
end


function entropy_locals(data::DiscreteData; base::Number=2)
    return entropy_locals(ProbabilityMass(data); base)
end


function entropy_locals(data::Matrix; base::Number=2, byrow::Bool=true)
    return entropy_locals(DiscreteData(data; byrow); base)
end


function entropy_locals(data::Vector; base::Number=2)
    return entropy_locals(DiscreteData(data); base)
end