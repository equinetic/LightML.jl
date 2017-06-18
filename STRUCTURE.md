# Module Structure

```
src/
  data
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
- **Common files, nomenclature** - each folder root to *src/* specificies a *component*. Each component has a *component.jl* file at the root of its own directory which is imported in the primary module file.
- **learning algos** - I think these should become more modular so people can tinker a little more. In the spirit of LightML there will still be a full suite of native implementations.
- **src/solvers** - if the native / backend files become too bloated this may be split to *./native* and *./backends* sub directories.
- **src/utils** - moving model eval & diagnostics to a dedicated directory. changing up naming convention in utils to verbs since these are all actions performed on data or models.
- **src/loss_functions** - loss functions, whether native or backend, should be formatted to return (loss, gradient).
