module PidDt

using DocStringExtensions

include("utils/discrete_data.jl")
include("utils/probability_mass.jl")
include("utils/node.jl")

include("information_utils/entropy.jl")
include("information_utils/conditional_entropy.jl")
include("information_utils/mutual_information.jl")

include("decision_trees/decision_tree.jl")
include("decision_trees/id3_tree.jl")
include("decision_trees/c45_tree.jl")
include("decision_trees/pid_tree.jl")

end # module
