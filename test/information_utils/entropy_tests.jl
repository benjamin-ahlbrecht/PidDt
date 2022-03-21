println("\n<<entropy_test.jl>>")

# Entropy from a vector of raw data
vec = [1, 1, 1, 2, 2, 3]
entropy_vec = entropy(vec)
println(entropy_vec)
@test entropy_vec ≈ 1.4591479170272448


# Entropy from a matrix of raw data
mat = [
    1 1
    1 1
    1 1
    2 2
    2 2
    3 3
]
entropy_mat = entropy(mat)
println(entropy_mat)
@test entropy_mat ≈ 1.4591479170272448

# Entropy from a DiscreteData struct
entropy_data = entropy(DiscreteData(mat))
println(entropy_data)
@test entropy_data ≈ 1.4591479170272448

# Entropy from a ProbabilityMass struct
entropy_pmf = entropy(ProbabilityMass(mat))
println(entropy_pmf)
@test entropy_pmf ≈ 1.4591479170272448

# Local entropy from a vector of raw data
local_entropy_vec = entropy_locals(vec)
println(local_entropy_vec)

# Local entropy from a matrix of raw data
local_entropy_mat = entropy_locals(mat)
println(local_entropy_mat)

# Local entropy from a DiscreteData struct
local_entropy_data = entropy_locals(DiscreteData(mat))
println(local_entropy_data)

# Local entropy from a ProbabilityMass struct
local_entropy_pmf = entropy_locals(ProbabilityMass(mat))
println(local_entropy_pmf)