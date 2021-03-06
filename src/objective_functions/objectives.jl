# New schema
# TODO: Fix gradients

abstract type Objective end

struct L1 <: Objective end
cost(obj::L1, y, ŷ) = abs.(y .- ŷ)
grad(obj::L1, y, ŷ) = y .- ŷ

struct L2 <: Objective end
cost(obj::L2, y, ŷ) = (y .- ŷ) .^ 2
grad(obj::L2, y, ŷ) = 2(y .- ŷ)

struct LN <: Objective end
cost(obj::LN, y, ŷ, n::Int) = (y .- ŷ) .^ n
grad(obj::LN, y, ŷ, n::Int) = n*(y .- ŷ)

struct LogLoss <: Objective end
cost(obj::LogLoss, y, ŷ) = (log.(1+y) .- log.(1+ŷ)) .^ 2
grad(obj::LogLoss, y, ŷ) = (log.(1+y) .- log.(1+ŷ)) .^ 2


function loss(obj, y, ŷ)
    buffer = zeros(y)
    buffer .= cost.(obj, y, ŷ)
    buffer
end

function lossgrad(obj, y, ŷ)

end

function agg_loss(obj, y, ŷ, aggfun::Function)
    aggfun(loss(obj, y, ŷ))
end


squared_error(y, ŷ) = loss(L2(), y, ŷ)
mean_squared_error(y, ŷ) = agg_loss(L2(), y, ŷ, mean)
root_mean_squared_error(y, ŷ) = √agg_loss(L2(), y, ŷ, mean)

absolute_error(y, ŷ) = loss(L1(), y, ŷ)
mean_absolute_error(y, ŷ) = agg_loss(L1(), y, ŷ, mean)

squared_log_error(y, ŷ) = loss(LogLoss(), y, ŷ)
mean_squared_log_error(y, ŷ) = agg_loss(LogLoss(), y, ŷ, mean)
root_mean_squared_log_error(y, ŷ) = √agg_loss(LogLoss(), y, ŷ, mean)

# Old functions
# function mean_squared_error(actual, predicted)
#     mean(squared_error(actual, predicted))
# end

# function absolute_error(actual, predicted)
#     return abs(actual - predicted)
# end

# function mean_absolute_error(actual, predicted)
#     return mean(absolute_error(actual, predicted))
# end

# function squared_error(actual, predicted)
#     return (actual - predicted) .^ 2
# end

# function squared_log_error(actual, predicted)
#     return (log(actual + 1) - log(predicted + 1)) .^ 2
# end

# function mean_squared_log_error(actual, predicted)
#     return mean(squared_log_error(actual, predicted))
# end

# function root_mean_squared_error(actual, predicted)
#     return sqrt(mean_squared_error(actual, predicted))
# end

# function root_mean_squared_log_error(actual, predicted)
#     return sqrt(mean_squared_log_error(actual, predicted))
# end

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
