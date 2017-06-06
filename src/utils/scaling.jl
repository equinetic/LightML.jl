type FeatureScaler
    scalefun
    params
end


# ========================
# API
# ========================

function train!(scaler::FeatureScaler,
                X::AbstractVecOrMat)::FeatureScaler
    scaler.params = scaler.scalefun(X)
    scaler
end

function predict(X::AbstractVecOrMat, scaler::FeatureScaler)
    scaler.scalefun(X, scaler)
end

# ========================
# Scaling functions
# ========================


# ++++++ Standardize +++++++

type StandardizeParams
    μ::AbstractFloat
    σ::AbstractFloat
end

function StandardizeScaler()::FeatureScaler
    FeatureScaler(standardize, StandardizeParams)
end

"""
`standardize(
    X::AbstractVecOrMat,
    μ,
    σ)`

Scales feature to be mean neutral and in standard deviation units.
"""
function standardize(X::AbstractVecOrMat, μ, σ)
    (X .- μ) ./ (σ)
end

function standardize(X::AbstractVecOrMat, s::FeatureScaler)
    (X .- s.params[1]) ./ (s.params[2])
end

function standardize(X::AbstractVecOrMat)
    μ = mean(X, 1)
    σ = std(X, 1)
    return μ, σ
end


# ++++++ Rescale +++++++

type RescaleParams{T}
    xmin::T
    xmax::T
end

function RescaleScaler()::FeatureScaler
    FeatureScaler(rescale, RescaleParams)
end

"""
`rescale(
    X::AbstractVecOrMat,
    xmin,
    xmax)`

Scales feature to be between 0 and 1.
"""
function rescale(X::AbstractVecOrMat, xmin, xmax)
    (X .- xmin) ./ (xmax .- xmin)
end

function rescale(X::AbstractVecOrMat, s::FeatureScaler)
    (X .- s.params[1]) ./ (s.params[2] .- s.params[1])
end

function rescale(X::AbstractVecOrMat)
    xmin = minimum(X)
    xmax = maximum(X)
    return xmin, xmax
end


# ++++++ Unit Length +++++++

type UnitLengthParams
    euclidlength::Int
end

function UnitLengthScaler()::FeatureScaler
    FeatureScaler(unitlength, UnitLengthParams)
end

"""
`unitlength(
    X::AbstractVecOrMat,
    euclidlength::Int)`

Divides feature(s) of `X` by the vector euclidean distance.
"""
function unitlength(X::AbstractVecOrMat, euclidlength::Int)
    X ./ euclidlength
end

function unitlength(X::AbstractVecOrMat, s::FeatureScaler)
    X ./ s.params[1]
end

function unitlength(X::AbstractVecOrMat)
    euclidlength = size(X, 1)
    return euclidlength
end
