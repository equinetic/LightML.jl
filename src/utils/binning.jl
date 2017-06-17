# Sources
# - http://www.saedsayad.com/binning.htm
# -

# ========================
# Variable Binning
# ========================

type Binner
    method
    params 
end

type QuantileBinner <: Binner

end


function binvar{T <: Real}(
            v::AbstractVector{T},
            method::Function;
            floatprecision::Int=4,
            labelwithindex::Bool=false,
            boundaryrule::Function= .<=,
            labels=Void,
            args...)

    ind = method(v; args...)
    if labelwithindex
        return ind
    elseif labels != Void
        return labels[ind]
    else

    end
end

# typealias QuantileRng Union{
#             FloatRange{Float64},
#             FloatRange{Float32},
#             FloatRange{Float16},
#             Vector{Float64},
#             Vector{Float32},
#             Vector{Float16},
#         }



function quantilebin{T <: Real}(
            v::AbstractVector{T};
            q=0:.25:1)::Vector{Int}
    qt = quantile(v, q)
    l = v .- qt'
    ind = Vector{Int}()

    for i = 1:size(l, 1)
        append!(ind, find(l[i,:] .== maximum(l[i,:][l[i,:] .<= 0.])))
    end

    return ind
end
