using PidDt
using Test

@testset "PidDt test" begin

# include("utils/discrete_data_tests.jl")
# include("utils/probability_mass_tests.jl")
# include("utils/node_tests.jl")

# include("information_utils/entropy_tests.jl")
# include("information_utils/conditional_entropy_tests.jl")
# include("information_utils/mutual_information_tests.jl")

# include("decision_trees/decision_tree_tests.jl")
include("decision_trees/id3_tree_tests.jl")
include("decision_trees/c45_tree_tests.jl")
include("decision_trees/pid_tree_tests.jl")

end