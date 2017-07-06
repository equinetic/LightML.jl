# Rebuild this component
# Look into TiledIteration.jl

# ========================
# Data Partitioning
# ========================

function train_test_split(X,y;train_size=0.75,rand_seed=2135)
    srand(rand_seed)
    rand_indx = shuffle(1:size(X,1))
    train_num = Int(floor(size(X,1) * train_size))
    X_train = X[rand_indx[1:train_num],:]
    X_test = X[rand_indx[(train_num+1):end],:]
    y_train = y[rand_indx[1:train_num]]
    y_test = y[rand_indx[(train_num+1):end]]
    return  X_train, X_test, y_train, y_test
end

function get_random_subsets(X, y , n_subsets;replacement = true)
    n_sample, n_feature = size(X)

    X_y = hcat(X, y)
    X_y = X_y[shuffle(1:n_sample), :]
    subsample_size = trunc(Int64,n_sample / 2)
    if replacement == true
        subsample_size = n_sample
    end
    sets = zeros(n_subsets,subsample_size, n_feature + 1)
    for i = 1:n_subsets
        idx = sample(1:n_sample, subsample_size, replace = replacement)
        temp = X_y[idx,:]
        sets[i,:,:] = temp
    end
    return sets
end

function batch_iter(X, batch_size = 64)
    n_sample = size(X,1)
    n_batch = floor(n_sample / (batch_size))
    batch_end = 0

    batch = []
    for i = 1n_batch
        batch_begin = (i-1)*n_batch
        batch_end = i * n_batch
        if i < n_batch
            push!(batch,X[batch_beginbatch_end, ])
        else
            push!(batch,X[batch_beginend, ])
        end
    end
    return batch
end
