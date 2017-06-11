# ------ Classification ------
# TODO:     - Make sure this works with unhot
#           - Confusion matrix
#           -
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


true_positives(actual, predicted)::Int = sum((actual .== 1) .& (predicted .== 1))
false_positives(actual, predicted)::Int = sum((predicted .== 1) .& (actual .== 0))
true_negatives(actual, predicted)::Int = sum((actual .== 0) .& (predicted .== 0))
false_negatives(actual, predicted)::Int = sum((predicted .== 0) .& (actual .== 1))


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


"""
PPV
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
precision = positive_predictive_value

# See `?positive_predictive_value`
ppv = positive_predictive_value

"""
NPV
"""
function negative_predictive_value(actual, predicted)::AbstractFloat
    tn = true_negatives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return negative_predictive_value(tn=tn, fn=fn)
end

function negative_predictive_value(; tn::Int=NaN, fn::Int=NaN)
    return tn / (tn + fn)
end

# See `?negative_predictive_value`
npv = negative_predictive_value

"""
TPR / Recall
"""
function sensitivity(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return sensitivity(tp=tp, fn=fn)
end

function sensitivity(; tp::Int=NaN, fn::Int=NaN)::AbstractFloat
    return tp / (tp + fn)
end

# See `?sensitivity`
true_positive_rate = sensitivity

# See `?sensitivity`
tpr = sensitivity

# See `?sensitivity`
recall = sensitivity

"""
SPC
"""
function specificity(actual, predicted)::AbstractFloat
    tn = true_negatives(actual, predicted)
    fp = false_positives(actual, predicted)
    return specificity(tn=tn, fp=fp)
end

function specificity(; tn::Int=NaN, fp::Int=NaN)::AbstractFloat
    return tn / (tn + fp)
end

# See `?specificity`
true_negative_rate = specificity

# See `?specificity`
spc = specificity

"""
FPR
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
FNR
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
FDR
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
MCC
"""
function matthews_corrcoef(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    tn = true_negatives(actual, predicted)
    fp = false_positives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return matthews_corrcoef(tp=tp, tn=tn, fp=fp, fn=fn)
end

function matthews_corrcoef(; tp::Int=NaN, tn::Int=NaN, fp::Int=NaN, fn::Int=NaN)
    return (tp*tn - fp*fn) / sqrt( (tp+fp)*(tp+fn)*(tn+fp)*(tn+fn) )
end

# See `?matthews_corrcoef`
mcc = matthews_corrcoef

"""
Informedness
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
F1 Score
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
Classification Error
"""
function classification_error(actual, predicted)
    if size(actual,2) > 1 && length(actual) > 1
        actual = unhot(actual)
        predicted = unhot(predicted)
    end
    return sum(actual .!= predicted) / size(actual,1)
end

"""
Classification Accuracy
"""
function accuracy(actual, predicted)
    return 1.0 - classification_error(actual, predicted)
end
