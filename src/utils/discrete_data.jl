export DiscreteData
export observe, iter_observations, subset, superset, condition


"""
The DiscreteData struct groups together observations for simpler manipulation

$(FIELDS)
"""
struct DiscreteData{T}
    # The collective set of observations from the data
    observations::Matrix{T}

    # The number of observations
    nobs::Int64

    # The dimensionality of the observations
    ndims::Int64 
end


function DiscreteData(data::Vector)
    return DiscreteData(reshape(data, 1, :), length(data), 1)
end


function DiscreteData(data::Matrix; byrow::Bool=true)
    # Gather the axes of the dataset
    x = size(data, 1)
    y = size(data, 2)

    # Since Julia is column-major, transpose by-row data
    if byrow
        return DiscreteData(permutedims(data), x, y)
    end

    return DiscreteData(data, y, x)
end


function observe(data::DiscreteData, i::Int64)
    return data.observations[:, i]
end


function iter_observations(data::DiscreteData)
    return eachcol(data.observations)
end


function subset(data::DiscreteData, dims::Union{Int, Vector{Int}})
    subdata = data.observations[dims, :]
    
    # Feed subdata into the right constructor
    if length(dims) == 1
        return DiscreteData(subdata)
    end

    return DiscreteData(subdata, byrow=false)
end


function superset(data1::DiscreteData, data2::DiscreteData)
    # Concatenate the two datasets
    superdata::Matrix = [data1.observations; data2.observations]

    # Reform the DiscreteData struct
    return DiscreteData(superdata, byrow=false)
end


function condition(data::DiscreteData, dim::Int, event::Any)
    mask::Vector{Bool} = map(x -> x == event, data.observations[dim, :])
    return DiscreteData(data.observations[:, mask], byrow=false)
end


function Base.:unique(data::DiscreteData)
    return unique(data.observations)
end


function Base.:unique(data::DiscreteData, dims::Union{Int, Vector{Int}})
    return unique(subset(data, dims).observations)
end


function Base.:println(data::DiscreteData)
    printstyled("\n($(data.nobs) x $(data.ndims)) DiscreteData\n";
                color=:red, bold=true)
    for obs ∈ iter_observations(data)
        print("│ ")
        for x ∈ obs
            print("$x ")
        end
        println("│")
    end
    println()
end