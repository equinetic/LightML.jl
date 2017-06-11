# ========================
# Data Generation
# ========================

function make_cla(;n_samples = 1200, n_features = 10, n_classes = 2)
    X, y = dat.make_classification(n_samples=n_samples, n_features=n_features,
                               random_state=1111, n_classes= n_classes)
    # Convert y to {-1, 1}
    y = (y * 2) - 1
    X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8,
                                                        rand_seed=1111)
    X_train, X_test, y_train, y_test
end

function make_reg(;n_samples = 200,
                   n_features = 10)
    X, y = dat.make_regression(n_samples=n_samples, n_features=n_features, n_targets=1, noise=0.05,
                           random_state=1111, bias=0.5)
    X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8,
                                                        rand_seed=1111)
    X_train, X_test, y_train, y_test
end

function make_iris()
    data= dat.load_iris()
    X = data["data"]
    y = data["target"]
    X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8,
                                                        rand_seed=1111)
    X_train, X_test, y_train, y_test
end

function make_blo()
    X, y = dat.make_blobs(centers=4, n_samples=500, n_features=2,
                          random_state=42)
    return  X, y
end

function make_digits()
    data = dat.load_digits()
    X = data["data"]
    y = data["target"]
    X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8,
                                                         rand_seed=1111)
    X_train, X_test, y_train, y_test
end


# ========================
# Miscellaneous
# ========================

function one_hot(y)
    n = length(unique(y))
    if minimum(y) == 0
        return eye(n)[(y+1),:]
    elseif minimum(y) == -1 && n == 2
        y = trunc(Int64,(y + 1)/2+1)
        return eye(2)[y,:]
    end
    return eye(n)[y,:]
end

function softmax(x::Vector)
    x = exp(x)
    pos = x./sum(x)
    return indmax(pos)
end

function softmax(X::Matrix)
    n_sample = size(X,1)
    res = zeros(n_sample)
    for i = 1:n_sample
        res[i] = softmax(X[i,:])
    end
    return res
end

function euc_dist(x,y)
    return norm(x-y)
end

function l2_dist(X)
    sum_X = sum(X .* X, 1)
    return (-2 * X * X' + sum_X)' + sum_X
end

function unhot(predicted)
    """Convert one-hot representation into one column."""
    actual = zeros(size(predicted,1))
    for i = 1:size(predicted, 1)
        predicted_data = predicted[i,:]
        actual[i] = indmax(predicted_data)
    end
    return actual
end

function sigmoid_tanh(x)
    return 0.5 * (tanh(x) + 1)
end


function sigmoid(x)
    return 1./(1+exp(-x))
end

function sigmoid_prime(x)
    return sigmoid(x).*(1-sigmoid(x))
end

function classify(predicted, threshold::AbstractFloat=0.50)
  return map(x-> x > threshold ? 1 : 0, predicted)
end

function classify2(predicted, threshold::AbstractFloat=0.50)
  return ifelse(predicted .> threshold, 1, 0)
end
