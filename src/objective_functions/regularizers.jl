abstract Regularizer


"""
L1 Regularization
=================


"""
struct L1_Reg
  λ::AbstractFloat
  f::Function
  HasIntercept::Bool

  function L1_Reg(λ::AbstractFloat=0.,
                  HasIntercept::Bool=false)
    new(λ, L1_regularize, HasIntercept)
  end

end

function L1_regularize(θ::AbstractVector,
                       λ::AbstractFloat)::AbstractVector
 λ*abs.(θ)
end

function regularize(θ::AbstractVector, L::L1_Reg)
  reg = L.f(θ, L.λ)
  if !L.HasIntercept reg[1] = 0. end
  reg
end

"""
L2 Regularization
=================


"""
struct L2_Reg
  λ::AbstractFloat
  f::Function
  HasIntercept::Bool

  function L2_Reg(λ::AbstractFloat=0.,
                  HasIntercept::Bool=false)
    new(λ, L2_regularize, HasIntercept)
  end

end

function L2_regularize(θ::AbstractVector,
                       λ::AbstractFloat)::AbstractVector
 λ * θ.^2
end

function regularize(θ::AbstractVector, L::L2_Reg)
  reg = L.f(θ, L.λ)
  if !L.HasIntercept reg[1] = 0. end
  reg
end
