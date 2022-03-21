println("\n<<mutual_information_tests.jl>>")

a = [1, 1, 1, 1, 1, 1]
b = [2, 2, 2, 3, 3, 4]
c = [1, 1, 1, 2, 2, 3]

pmf_a = ProbabilityMass(a)
pmf_b = ProbabilityMass(b)
pmf_c = ProbabilityMass(c)

# A and B shared no information
mi1 = mutual_information(pmf_a, pmf_b)
mi1_locals = mutual_information_locals(pmf_a, pmf_b)
println(mi1)

# A and C share no information
mi2 = mutual_information(pmf_a, pmf_c)
mi2_locals = mutual_information_locals(pmf_a, pmf_c)
println(mi2)

# B and C share maximal information (B and C fully specify eachother)
mi3 = mutual_information(pmf_b, pmf_c)
mi3_locals = mutual_information_locals(pmf_b, pmf_c)
println(mi3)

println(mi1_locals)
println(mi2_locals)
println(mi3_locals)