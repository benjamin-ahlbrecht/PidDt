println("\n<<discrete_data_tests.jl>>")

# 1D Vector data
a = [1, 2, 3, 4, 5, 6]
da = DiscreteData(a)
println(da)

# 1D Matrix data
b = [1 2 3 4 5 6]
db = DiscreteData(b, byrow=false)
println(db)

# 2D Matrix data
c = [
    1 2
    3 4
    5 6
]
dc = DiscreteData(c, byrow=true)
println(dc)

# Grab a 1D observation
obsb = observe(db, 3)
println(obsb)

# Grab a 2D observation
obsc = observe(dc, 2)
println(obsc)

# Iterate through 1D matrix observations
for x ∈ iter_observations(db)
    println(x)
end

# Iterate through 2D matrix observations
for x ∈ iter_observations(dc)
    println(x)
end

# Subset a 2D matrix
d = [
    1 2 3
    4 5 6
    7 8 9
    9 8 7
    6 5 4
    3 2 1
]

dd = DiscreteData(d)
dd_sub1 = subset(dd, 2)
println(dd_sub1)

# Subset multiple dimensions
dd_sub2 = subset(dd, [1, 3])
println(dd_sub2)


# Create DiscreteData using strings, chars, and floating point numbers
e = [
    'a' 'b'
    'c' 'd'
    'e' 'f'
]

de = DiscreteData(e)
println(de)

f = [
    "t1" "t2"
    "t3" "t4"
    "t5" "t6"
]

df = DiscreteData(f)
println(df)

g = [
    1.23 4.56
    7.89 1.01
    1.23 4.56
]

dg = DiscreteData(g)
println(dg)


h1 = [
    1 2
    1 2
    1 2
    1 2
]

h2 = [
    3 4
    3 4
    3 4
    3 4
]

dh1 = DiscreteData(h1)
dh2 = DiscreteData(h2)
dh3 = superset(dh1, dh2)

println(dh1)
println(dh2)
println(dh3)


# Condition tests
data_full = [
    1 1 1
    2 1 1
    1 2 1
    1 1 2
    2 2 1
    2 1 2
    1 2 2
    2 2 2
]
dd_full = DiscreteData(data_full)

# Condition on dimension 2, value 2
data_cond1 = [
    1 2 1
    2 2 1
    1 2 2
    2 2 2
]
dd_cond1 = DiscreteData(data_cond1)
dd_full_cond1 = condition(dd_cond1, 2, 2)
@test dd_cond1.observations == dd_full_cond1.observations


# Condition on dimension 1, value 2
data_cond2 = [
    2 1 1
    2 2 1
    2 1 2
    2 2 2
]
dd_cond2 = DiscreteData(data_cond2)
dd_full_cond2 = condition(dd_cond2, 1, 2)
@test dd_cond2.observations == dd_full_cond2.observations

