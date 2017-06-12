# Changed

- Reorganized / split utils.jl by category
- Moved away from `*_` names, now favoring common synonyms and symbols
- utils/scaling.jl
    * `normalize_` => `standardize`
    * Added `minmax`
    * Added `unitlength`
    * Scalers can be fitted and mapped through a helper type - this is for fitting to a training set then applying to a test set
- utils/classification_eval.jl
    * New type: ClassificationStatistics
    * New type: ConfusionMatrix
    * New type: ROCCurve - primarily used for convenient plotting
    * `roc` function - generalized so the X and Y functions (characteristics) can be swapped out
    * Added many more classification stats
        * tp, fp, tn, fn calculators
        * positive_predictive_value (precision)
        * negative_predictive_value
        * sensitivity (true positive rate)
        * specificity (true negative rate)
        * false_positive_rate
        * false_negative_rate
        * false_discovery_rate
        * matthews_corrcoef
        * informedness
        * markedness
        * f1score
        * accuracy (existing, listing it here for a complete list)
- utils/utils.jl
    * `classify`
- Changed "test\_" functions to "demo\_"
- Began build out of formal tests in /test
- Removed Gadfly dependency in favor of Plots.jl
-
