# Module Structure

```
src/
  supervised_learning
    algorithms...
  unsupervised_learning
    algorithms...
  ensemble_learning
    algorithms...
  loss_functions
    L1, L2, etc...
  solvers
    native.jl
    backends.jl
  model_evaluation
    classification.jl
    regression.jl
  utils
    binning.jl
    partitioning.jl
    plotting.jl
    scaling.jl
    other_utils.jl

test
  [/src_mirror]
    [tst_category.jl]
  runtests.jl
```

# Notes
- **src/solvers** - if the native / backend files become too bloated this may be split to *./native* and *./backends* sub directories.
-
