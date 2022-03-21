println("\n<<conditional_entropy_tests.jl>>")

# The first dimension should be independent of the second dimension
# P(2 | 1 = 2); thus the entropy is simply returned
# The second dimension provides some information about the first
a = [
    1 1 
    1 1
    1 1
    1 1
    1 2
    1 2
]

# Conditional entropy from ProbabilityMass
pmf_a = ProbabilityMass(a)
entropy_pmf_a = entropy(pmf_a)
cond_entropy_pmf_a1 = conditional_entropy(pmf_a, 1)
cond_entropy_pmf_a2 = conditional_entropy(pmf_a, 2)
@test entropy_pmf_a == cond_entropy_pmf_a1
@test entropy_pmf_a > cond_entropy_pmf_a2

# Conditional entropy from DiscreteData
data_a = DiscreteData(a)
entropy_data_a = entropy(data_a)
cond_entropy_data_a1 = conditional_entropy(data_a, 1)
cond_entropy_data_a2 = conditional_entropy(data_a, 2)
@test entropy_data_a == cond_entropy_data_a1
@test entropy_data_a > cond_entropy_data_a2

# Conditional entropy for a raw matrix
entropy_mat_a = entropy(a; byrow=true)
cond_entropy_mat_a1 = conditional_entropy(a, 1; byrow=true)
cond_entropy_mat_a2 = conditional_entropy(a, 2; byrow=true)
@test entropy_mat_a == cond_entropy_mat_a1
@test entropy_mat_a > cond_entropy_mat_a2

# All conditional entropies should be equal
@test cond_entropy_data_a1 == cond_entropy_mat_a1 == cond_entropy_pmf_a1
@test cond_entropy_data_a2 == cond_entropy_mat_a2 == cond_entropy_pmf_a2

# Local conditional entropy from a PMF
lcond_entropy_pmf_a1 = conditional_entropy_locals(pmf_a, 1)
lcond_entropy_pmf_a2 = conditional_entropy_locals(pmf_a, 2)

# Local conditional entropy from DiscreteData
lcond_entropy_data_a1 = conditional_entropy_locals(data_a, 1)
lcond_entropy_data_a2 = conditional_entropy_locals(data_a, 2)

# Local conditional entropy from a raw matrix
lcond_entropy_mat_a1 = conditional_entropy_locals(a, 1)
lcond_entropy_mat_a2 = conditional_entropy_locals(a, 2)

# All local conditional entropies should be equal
@test lcond_entropy_data_a1 == lcond_entropy_mat_a1 == lcond_entropy_pmf_a1
@test lcond_entropy_data_a2 == lcond_entropy_mat_a2 == lcond_entropy_pmf_a2

# Print the conditional entropies for verification
println(cond_entropy_pmf_a1)
println(cond_entropy_pmf_a2)
println(lcond_entropy_data_a1)
println(lcond_entropy_data_a2)