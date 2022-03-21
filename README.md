# PIDDT

PIDDT (Partial Information Decomposition Decision Trees) hopes to utilize the recently-proposed framework of Partial Information Decomposition (PID) to construct decision trees that retain explanatory and interpretive power while improving accuracy. As such, we hope to alleviate some need for black-box decision tree methods in favor of methods that can also inform the researcher, analyst, or end-user about the nature of their data. While development is in progress, we plan to bring high-performance construction of ID3, C4.5, and PIDDT decision trees implemented in Julia with function interfaces for Python and R.

## Development Plan
- [x] Custom data and probability mass structs for fast computation of decision trees from *discrete* data
- [ ] Utilities for interfacing with [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl)
- [x] Basic local and expected implementations of information theoretic measures for discrete data (entropy, conditional entropy, and mutual information)
- [ ] Implementation of pointwise partial information decomposition as proposed by [Finn and Lizier](https://www.mdpi.com/1099-4300/20/4/297)
- [x] Implementation of the ID3 decision tree
- [ ] Implementation of the C4.5 decision tree
- [ ] Implementation of the PIDDT decision tree
- [ ] Implementation of random forests for ID3, C4.5, and PIDDT decision trees
- [ ] General beautification/refactoring and potentially a name-change to something better!
- [ ] Function interfaces with Python and R

## Getting Started

When available, PidDt will be available to install directly from the Julia REPL:

```
using Pkg
Pkg.add("PidDt")
```

## Resources

The PID framework can be initially confusing and daunting, yet the idea behind it is surprisingly intuitive and simple. Here are some resources which made me realize the beauty behind information theory, helped me understand the inner-workings of the PID framework, and inspired me to begin this project:

- Williams, Paul L., and Randall D. Beer. "Nonnegative decomposition of multivariate information." arXiv preprint arXiv:1004.2515 (2010).
- Finn, Conor, and Joseph T. Lizier. "Pointwise partial information decomposition using the specificity and ambiguity lattices." Entropy 20.4 (2018): 297.
- Kunert-Graf, James, Nikita Sakhanenko, and David Galas. "Partial Information Decomposition and the Information Delta: A Geometric Unification Disentangling Non-Pairwise Information." Entropy 22.12 (2020): 1333.
- Lizier, Joseph T., et al. "Information decomposition of target effects from multi-source interactions: Perspectives on previous, current and future work." Entropy 20.4 (2018): 307.
- Griffith, Virgil, and Christof Koch. "Quantifying synergistic mutual information." Guided self-organization: inception. Springer, Berlin, Heidelberg, 2014. 159-190.
- Wollstadt, Patricia, Sebastian Schmitt, and Michael Wibral. "A rigorous information-theoretic definition of redundancy and relevancy in feature selection based on (partial) information decomposition." arXiv preprint arXiv:2105.04187 (2021).