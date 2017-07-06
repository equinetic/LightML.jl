mutable struct LinearRegression <: Model
  wts::AbstractVector
  obj::Function
  reg
  function LinearRegression(wts::AbstractVector=[],
                            obj::Function=L2,
                            reg=nothing)
    new(wts, obj, reg)
  end
end

function cost(M::LinearRegression, y::T, ŷ::T where T<:AbstractVector)
  J, g = M.Objective(y, ŷ)
end

function predict(M::LinearRegression, x::AbstractMatrix)
  return M.wts * X'
end

function train!(M::LinearRegression,
                x::AbstractMatrix,
                y::AbstractVector;
                solver::Function = gradient_descent,
                args...)
  if length(M.wts)==0 M.wts=repeat([0], inner=size(x, 2)) end

end
