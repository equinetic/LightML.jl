function gradient_descent!{T<:Real}(θ::AbstractVector{T},    # Weights
                                    X::AbstractVecOrMat{T},  # Features
                                    y::AbstractVecOrMat{T},  # Correct values
                                    J::Function;             # Cost function
                                    α::AbstractFloat=1e-9,   # Learn rate
                                    λ::AbstractFloat=0.00,   # Regularization
                                    tol::AbstractFloat=1e-4  # Delta tolerance
                                    maxIter::Int=1000)::AbstractVector{T}
  ϵ = 0.00     # current error
  δ = 1.e10    # change in error
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
    throw("WARNING: Gradient descent did not converge")
  end

  return θ
end
