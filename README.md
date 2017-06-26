# LightML.jl


[![Build Status](https://travis-ci.org/memoiry/LightML.jl.svg?branch=master)](https://travis-ci.org/memoiry/LightML.jl)

### Equinetic Branch

LightML can fulfill a longer term need in the Julia and data science community. A "light" machine learning package is suitable for many applications - not everyone needs a super optimized package for working with big data.

In short, I believe LightML should fulfill the following two needs:
1. Providing a robust suite of standard algorithms and functionality for predictive modeling and data processing.
2. Packing the above in structured, readable, and well-documented code to aide (human) learners.

#### Initial Release / Pull Request
* Restructure sections of code base for purposes of extending current capabilities and to make the algorithms more modular.
* Eliminate unnecessary dependencies to keep LightML light. Most of these needs had already been identified by memoiry - PyCall, ForwardDiff, etc.
* Expand the "utilities" section:
    * Feature scaling
    * Binning
    * Plot recipes
* Expand model evaluation:
    * Classification - ROC curves, confusion matrices, every specificity/sensitivity/true-positive-rate type of metric you can think of
    * Similar build out for non classification models
    * Learning curves
* Modularize learning algorithms
    * Parameterized loss (& gradient) function with native implementations
    * Parameterized solver method - again with native implementations

#### Long Term Discussion
The work of the JuliaML organization seems to be a sensible direction for the Julia community. With breadth as the overarching goal of this branch I believe LightML can be included by both a reexport of the utilities and potentially as a backend, if that's the direction they take.

```julia
using Learn
lightml()
```

#### Notes

[TODO](./todo.md)

[New Module Structure](./STRUCTURE.md)

~~[Change Log](./changelog.md)~~
