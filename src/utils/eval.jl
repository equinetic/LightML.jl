# ========================
# Model Evaluation
# ========================

# ------ Distance Based ------
function absolute_error(actual, predicted)
    return abs(actual - predicted)
end

function mean_absolute_error(actual, predicted)
    return mean(absolute_error(actual, predicted))
end

function squared_error(actual, predicted)
    return (actual - predicted) .^ 2
end

function squared_log_error(actual, predicted)
    return (log(actual + 1) - log(predicted + 1)) .^ 2
end

function mean_squared_log_error(actual, predicted)
    return mean(squared_log_error(actual, predicted))
end

function mean_squared_error(actual, predicted)
    return mean(squared_error(actual, predicted))
end

function root_mean_squared_error(actual, predicted)
    return sqrt(mean_squared_error(actual, predicted))
end

function root_mean_squared_log_error(actual, predicted)
    return sqrt(mean_squared_log_error(actual, predicted))
end

function logloss(actual, predicted)
    predicted = clamp(predicted, 0, 1 - 1e-15)
    loss = -sum(actual .* log(predicted))
    return loss / size(actual,1)
end

function hinge(actual, predicted)
    return mean(max(1. - actual .* predicted, 0.))
end

function binary_crossentropy(actual, predicted)
    predicted = clamp(predicted, 1e-15, 1 - 1e-15)
    return mean(-sum(actual .* log(predicted) -
                           (1 - actual) .* log(1 - predicted)))
end

# ------ Classification ------
# TODO:     Make sure this works with unhot
#           Confusion matrix
immutable ROCStats
    tp::Int
    fp::Int
    tn::Int
    fn::Int
    precision::AbstractFloat
    recall::AbstractFloat
    f1score::AbstractFloat
    accuracy::AbstractFloat
    npv::AbstractFloat

end

true_positives(actual::Int, predicted::Int)::Int = sum((actual .== 1) .& (prediced .== 1))
false_positives(actual::Int, predicted::Int)::Int = sum((predicted .== 1) .& (actual .== 0))
true_negatives(actual::Int, predicted::Int)::Int = sum((actual .== 0) .& (predicted .== 0))
false_negatives(actual::Int, predicted::Int)::Int = sum((predicted .== 0) .& (actual .== 1))

function precision(tp::Int, fp::Int)::AbstractFloat
    return tp / (tp + fp)
end

function precision(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    fp = false_positives(actual, predicted)
    return precision(tp, fp)
end

function recall(tp::Int, fn::Int)::AbstractFloat
    return tp / (tp + fn)
end

function recall(actual, predicted)::AbstractFloat
    tp = true_positives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return recall(tp, fn)
end

function f1score(actual, predicted)::AbstractFloat
    pr = precision(actual, predicted)
    rc = recall(actual_predicted)
    return (2*pr*rc) / (pr + rc)
end

function negative_predictive_value(actual, predicted)::AbstractFloat
    tn = true_negatives(actual, predicted)
    fn = false_negatives(actual, predicted)
    return tn / (tn + fn)
end

function sensitivity(tp::Int, fn::Int)::AbstractFloat
    return tp / (tp + fn)
end

function sensitivity(actual, predicted)::AbstractFloat
end

function specificity(tn::Int, fp::Int)::AbstractFloat
    return tn / (tn + fp)
end

function specificity(actual, predicted)::AbstractFloat
end

function false_positive_rate()
end

function false_discovery_rate()
end

function matthews_corrcoef()
end

function informedness()
end

function markedness()
end

function ROCStats(actual::Int, predicted::Int)::ROCStats
    tp =
end


function classification_error(actual, predicted)
    if size(actual,2) > 1 && length(actual) > 1
        actual = unhot(actual)
        predicted = unhot(predicted)
    end
    return sum(actual .!= predicted) / size(actual,1)
end

function accuracy(actual, predicted)
    return 1.0 - classification_error(actual, predicted)
end





function calc_variance(X)
    n_sample = size(X,1)
    mean_ = repmat(mean(X, 1),n_sample,1)
    de_mean = X - mean_
    return 1/n_sample * diag(de_mean' * de_mean)
end

function calc_entropy(y)
    if size(y,2) > 1
        y = unhot(y)
    end
    feature_unique = unique(y)
    num_sample = length(y)
    entro = 0
    for i in feature_unique
        num_feature = sum(y .== i)
        p = num_feature / num_sample
        entro += - p * log2(p)
    end
    return entro
end
