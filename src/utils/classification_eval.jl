# ------ Classification ------
# TODO:     - Make sure this works with unhot
#           - Confusion matrix
#           -


# ========================
# Classification Types
# ========================

"""
`ClassificationStatistics`
"""
immutable ClassificationStatistics
    tp::Int
    fp::Int
    tn::Int
    fn::Int
    ppv::AbstractFloat
    npv::AbstractFloat
    sensitivity::AbstractFloat
    specificity::AbstractFloat
    fpr::AbstractFloat
    fnr::AbstractFloat
    fdr::AbstractFloat
    f1score::AbstractFloat
    accuracy::AbstractFloat
    matthews_corrcoef::AbstractFloat
    informedness::AbstractFloat
    markedness::AbstractFloat

    function ClassificationStatistics(actual, predicted)
        tp = true_positives(actual, predicted)
        fp = false_positives(actual, predicted)
        tn = true_negatives(actual, predicted)
        fn = false_negatives(actual, predicted)
        ppv = positive_predictive_value(actual, predicted)
        npv = negative_predictive_value(actual, predicted)
        sense = sensitivity(actual, predicted)
        spec = specificity(actual, predicted)
        fpr = false_positive_rate(actual, predicted)
        fnr = false_negative_rate(actual, predicted)
        fdr = false_discovery_rate(actual, predicted)
        f1 = f1score(actual, predicted)
        acc = accuracy(actual, predicted)
        mcc = matthews_corrcoef(actual, predicted)
        inf = informedness(actual, predicted)
        mark = markedness(actual, predicted)
        new(tp, fp, tn, fn,ppv, npv, sense, spec, fpr,
             fnr, fdr, f1, acc, mcc, inf, mark)
    end
end

"""
`ConfusionMatrix`
"""
immutable ConfusionMatrix
    tp::Int
    fp::Int
    tn::Int
    fn::Int

    function ConfusionMatrix(actual, predicted)
        tp = true_positives(actual, predicted)
        fp = false_positives(actual, predicted)
        tn = true_negatives(actual, predicted)
        fn = false_negatives(actual, predicted)
        new(tp, fp, tn, fn)
    end
end

function Base.print(c::ConfusionMatrix)
    println("  + -")
    println("+ ", c.tp, " ", c.fn)
    println("- ", c.fp, " ", c.tn)
end

# ========================
# Classification Counts
# ========================

"""
`true_positives(actual, predicted)::Int`

Returns length of (y==1) ∩ (ŷ==1)
"""
function true_positives(actual, predicted)::Int
    return sum((actual .== 1) .& (predicted .== 1))
end

# See ?true_positives
tp = true_positives

"""
`false_positives(actual, predicted)::Int`

Returns length of (y==0) ∩ (ŷ==1)
"""
function false_positives(actual, predicted)::Int
    return sum((predicted .== 1) .& (actual .== 0))
end

# See ?false_positives
fp = false_positives

"""
`true_negatives(actual, predicted)::Int`

Returns length of (y==0) ∩ (ŷ==0)
"""
function true_negatives(actual, predicted)::Int
    return sum((actual .== 0) .& (predicted .== 0))
end

# See ?true_negatives
tn = true_negatives

"""
`false_negatives(actual, predicted)::Int`

Returns length of (y==1) ∩ (ŷ==0)
"""
function false_negatives(actual, predicted)::Int
    return sum((predicted .== 0) .& (actual .== 1))
end

# See ?false_negatives
fn = false_negatives


# ========================
# ROC Curve
# ========================

"""
```julia
roccurve(
    actual,
    ŷ,
    increment::AbstractFloat=0.01,
    charX::Function=false_positive_rate,
    charY::Function=true_positive_rate
)
```

where
    `actual` = vector of labels\n
    `ŷ` = vector of non-classified predicted labels\n
    `increment` = the step between 0.00 and 1.00 for the discriminat threshold\n
    `charX` = receiver operating characteristic along the X-axis\n
    `charY` = receiver operating characterstic along the Y-axis\n

The ROC curve measures the predictive effectiveness of a binary
classifier when adjusting the discriminant threshold value.

The default charX and charY functions will measure the false
positive rate along the X-axis and the true positive rate
along the Y-axis.
"""
function roccurve(actual,
                  ŷ,
                  increment::AbstractFloat=0.01,
                  charX::Function=false_positive_rate,
                  charY::Function=true_positive_rate)::Tuple(Vector{AbstractFloat}, Vector{AbstractFloat})
    charX_vals = Vector{AbstractFloat}()
    charY_vals = Vector{AbstractFloat}()

    for t in 0.:increment:1.
        predicted = classify(ŷ, t)
        append!(charX_vals, charX(actual, predicted))
        append!(chary_vals, chary(actual, predicted))
    end

    return charX_vals, charY_vals
end


# ========================
# Evaluation Functions
# ========================

"""
Classification Accuracy
=========================

```julia
accuracy(actual, predicted)
```

"""
function accuracy(actual, predicted)
    return 1.0 - classification_error(actual, predicted)
end

"""
Classification Error
=========================

```julia
classification_error(actual, predicted)
```

"""
function classification_error(actual, predicted)
    if size(actual,2) > 1 && length(actual) > 1
        actual = unhot(actual)
        predicted = unhot(predicted)
    end
    return sum(actual .!= predicted) / size(actual,1)
end

"""
F1 Score
=========================

```julia
f1score(actual, predicted)
f1score(; ppv::AbstractFloat=NaN, tpr::AbstractFloat=NaN)
```

"""
function f1score(actual, predicted)::AbstractFloat
    ppv = positive_predictive_value(actual, predicted)
    tpr = sensitivity(actual, predicted)
    return f1score(ppv=ppv, tpr=tpr)
end

function f1score(; ppv::AbstractFloat=NaN, tpr::AbstractFloat=NaN)::AbstractFloat
    return (2*ppv*tpr) / (ppv + tpr)
end

"""
False Discover Rate (FDR)
=========================

```julia
false_discovery_rate(actual, predicted)
false_discovery_rate(; fp::Int=NaN, tp::Int=NaN)
```

"""
function false_discovery_rate(actual, predicted)::AbstractFloat
    fp = false_positives(actual, predicted)
    tp = true_positives(actual, predicted)
    return false_discovery_rate(fp=fp, tp=tp)
end

function false_discovery_rate(; fp::Int=NaN, tp::Int=NaN)
    return fp / (fp + tp)
end

# See `?false_discovery_rate`
fdr = false_discovery_rate

"""
False Negative Rate (FNR)
=========================

```julia
false_negative_rate(actual, predicted)
false_negative_rate(; fn::Int=NaN, tp::Int=NaN)
```
"""
function false_negative_rate(actual, predicted)::AbstractFloat
    fn = false_negatives(actual, predicted)
    tp = true_positives(actual, predicted)
    return false_negative_rate(fn=fn, tp=tp)
end

function false_negative_rate(; fn::Int=NaN, tp::Int=NaN)
    return fn  / (fn + tp)
end

# See `?false_negative_rate`
fnr = false_negative_rate

"""
False Positive Rate (FPR, Fallout)
=========================

```julia
false_positive_rate(actual, predicted)
false_positive_rate(; fp::Int=NaN, tn::Int=NaN)
```

"""
function false_positive_rate(actual, predicted)::AbstractFloat
    fp = false_positives(actual, predicted)
    tn = true_negatives(actual, predicted)
    return false_positive_rate(fp=fp, tn=tn)
end

function false_positive_rate(; fp::Int=NaN, tn::Int=NaN)
    return fp / (fp + tn)
end

# See `?false_positive_rate`
fallout = false_positive_rate

# See `?false_positive_rate`
fpr = false_positive_rate

"""
Informedness
=========================

```julia
Informedness(actual, predicted)
Informedness(; tpr::AbstractFloat=NaN, spc::AbstractFloat=NaN)
```

"""
function informedness(actual, predicted)::AbstractFloat
    tpr = sensitivity(actual, predicted)
    spc = specificity(actual, predicted)
    return informedness(tpr=tpr, spc=spc)
end

function informedness(; tpr::AbstractFloat=NaN, spc::AbstractFloat=NaN)
    return tpr + spc - 1
end


"""
Markedness
=========================

```julia
markedness(actual, predicted)
markedness(; ppv::AbstractFloat=NaN, npv::AbstractFloat=NaN)
```

"""
function markedness(actual, predicted)::AbstractFloat
    ppv = positive_predictive_value(actual, predicted)
    npv = negative_predictive_value(actual, predicted)
    return markedness(ppv=ppv, npv=npv)
end

function markedness(; ppv::AbstractFloat=NaN, npv::AbstractFloat=NaN)
    return ppv + npv - 1
end

"""
Matthew's Correlation Coefficient (MCC)
=========================

```julia
matthews_corrcoef(actual, predicted)
matthews_corrcoef(; tp::Int=NaN, tn::Int=NaN, fp::Int=NaN, fn::Int=NaN)
```

"""
function matthews_corrcoef(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    tn = true_negatives(actual, predicted)
    fp = false_positives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return matthews_corrcoef(tp=tp, tn=tn, fp=fp, fn=fn)
end

function matthews_corrcoef(; tp::Int=NaN,
        tn::Int=NaN, fp::Int=NaN, fn::Int=NaN::AbstractFloat
    return (tp*tn - fp*fn) / sqrt( (tp+fp)*(tp+fn)*(tn+fp)*(tn+fn) )
end

# See `?matthews_corrcoef`
mcc = matthews_corrcoef

"""
Negative Predictive Value (NPV)
=========================

```julia
negative_predictive_value(actual, predicted)
negative_predictive_value(; tn::Int=NaN, fn::Int=NaN)
```

"""
function negative_predictive_value(actual, predicted)::AbstractFloat
    tn = true_negatives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return negative_predictive_value(tn=tn, fn=fn)
end

function negative_predictive_value(; tn::Int=NaN, fn::Int=NaN)::AbstractFloat
    return tn / (tn + fn)
end

# See `?negative_predictive_value`
npv = negative_predictive_value


"""
Postive Predictive Value (PPV, Precision)
=========================

```julia
positive_predictive_value(actual, predicted)
positive_predictive_value(; tp::Int=NaN, fp::Int=NaN)
```

"""
function positive_predictive_value(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    fp = false_positives(actual, predicted)
    return positive_predictive_value(tp=tp, fp=fp)
end

function positive_predictive_value(; tp::Int=NaN, fp::Int=NaN)::AbstractFloat
    return tp / (tp + fp)
end

# See `?positive_predictive_value`
ppv = positive_predictive_value

# See `?positive_predictive_value`
precision = positive_predictive_value


"""
True Negative Rate (TNR, Specificity, SPC)
=========================

```julia
true_negative_rate(actual, predicted)
true_negative_rate(; tn::Int=NaN, fp::Int=NaN)
```

"""
function true_negative_rate(actual, predicted)::AbstractFloat
    tn = true_negatives(actual, predicted)
    fp = false_positives(actual, predicted)
    return true_negative_rate(tn=tn, fp=fp)
end

function true_negative_rate(; tn::Int=NaN, fp::Int=NaN)::AbstractFloat
    return tn / (tn + fp)
end

# See `?true_negative_rate`
spc = true_negative_rate

# See `?true_negative_rate`
specificity = true_negative_rate


"""
True Positive Rate (TPR, Sensitivity, Recall)
=========================

```julia
true_positive_rate(actual, predicted)
true_positive_rate(; tp::Int=NaN, fn::Int=NaN)
```

"""
function true_positive_rate(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return true_positive_rate(tp=tp, fn=fn)
end

function true_positive_rate(; tp::Int=NaN, fn::Int=NaN)::AbstractFloat
    return tp / (tp + fn)
end

# See `?true_positive_rate`
recall = true_positive_rate

# See `?true_positive_rate`
sensitivity = true_positive_rate

# See `?true_positive_rate`
tpr = true_positive_rate
