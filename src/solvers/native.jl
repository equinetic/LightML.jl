

function gradient_descent!(θ::AbstractVector{T},     # Weights
                           X::AbstractVecOrMat{T},   # Features
                           y::AbstractVecOrMat{T},   # Correct values
                           J::Function;              # Cost function
                           α::AbstractFloat=1e-9,    # Learn rate
                           tol::AbstractFloat=1e-4   # Delta tolerance
                           maxIter::Int=1000)::AbstractVector{T} where T<:Real
  ϵ = 0.00     # current error
  δ = 2tol     # change in error
  n = 0        # iteration count
  while δ > tol && n < maxIter
    n += 1
    cost, grad = J(θ, X, y, λ)
    θ .-= α*grad
    if n==1
      ϵ = cost
    else
      δ = ϵ - cost
      ϵ = cost
    end
  end

  if n==maxIter && δ > tol
    warn("Gradient descent did not converge")
  end

  return θ
end
