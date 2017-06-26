"""
L1 Regularization
=================


"""
function L1_regularize(θ::AbstractVector,
                       λ::AbstractFloat,
                       M::Int=1,
                       intercept::Bool=false)
 reg = (λ/M)*abs.(θ)
 if !intercept reg[1] = 0. end
 reg
end

"""
L2 Regularization
=================


"""
function L2_regularize(θ::AbstractVector,
                       λ::AbstractFloat,
                       M::Int=1,
                       intercept::Bool=false)
  reg = (λ/M)*θ.^2
  if !intercept reg[1] = 0. end
  reg
end
