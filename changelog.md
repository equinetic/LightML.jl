# Changed

- Reorganized / split utils.jl by category
- Moved away from `*_` names; favoring common synonyms and symbols
- utils/scaling.jl
    * `normalize_` => `standardize`
    * Added `minmax`
    * Added `unitlength`
    * Scalers can be fitted and mapped through a helper type - this is for fitting to a training set then applying to a test set
- utils/classification_eval.jl
    * New type: ClassificationStatistics
    * New type: ConfusionMatrix
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
    * Receiver Operating Characteristics
- utils/utils.jl
    * `classify`
