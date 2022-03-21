println("\n<<probability_mass_tests.jl>>")

# Generate PMF from DiscreteData
a = [
    1 1
    1 1
    1 1
    1 2
    1 2
    2 2
]

da = DiscreteData(a)
pmf_a1 = ProbabilityMass(da)
println(pmf_a1)

# Generate PMF from 2D raw data
pmf_a2 = ProbabilityMass(a)
println(pmf_a2)

# Generate PMF from 1D raw data
b = [1, 1, 1, 2, 2, 3]
pmf_b = ProbabilityMass(b)
println(pmf_b)

# Iterate through events
for event ∈ events(pmf_a1)
    println(event)
end

# Iterate through probabilities
for prob ∈ probabilities(pmf_a1)
    println(prob)
end


c = [
    1 1
    1 1
    1 1
    2 2
    2 2
    3 3
]

pmf_c = ProbabilityMass(c)
println(pmf_c)
@test event_max(pmf_c) == [1, 1]
@test prob_max(pmf_c) == 0.5
