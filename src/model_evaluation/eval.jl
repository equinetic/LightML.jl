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
