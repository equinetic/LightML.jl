# Changed

- Reorganized / split utils.jl by category
- Moved away from `*_` names; favoring common synonyms and symbols
- utils/scaling.jl
    * `normalize_` => `standardize`
    * Added `minmax`
    * Added `unitlength`
    * Scalers can be fitted and mapped through a helper type - this is for fitting to a training set then applying to a test set
- utils/eval.jl
    * Added ROCStats and functions
    * Added many more classification stats
    * Confusion matrix
