# Sources
# - http://www.saedsayad.com/binning.htm
# -

# [ - inclusive
# ( - exclusive
# { - extends

# ========================
# Variable Binning
# ========================
abstract Binner

type Cut
  lbb::Symbol
  lb
  ubb::Symbol
  ub

  function Cut{T<:Real}(
          lbb::Symbol,
          lb::T,
          ubb::Symbol,
          ub::T)

    if lbb == :ext
      lbb = :inc
      lb = -Inf
    end

    if ubb == :ext
      ubb = :inc
      ub = Inf
    end

    new(lbb, lb, ubb, ub)
  end

  function Cut(c::String)
    lbb, lb, ubb, ub = parsecut(c)
    Cut(lbb, lb, ubb, ub)
  end

end

type QuantileBinner <: Binner
  func::Function
  cuts::Vector{Cut}

  function QuantileBinner{T<:Real}(v::AbstractVector{T},
                                   qt=0:.25:1)
    new(quantilebin, quantile(v, qt))
  end
end

# ========================
# API
# ========================
function train!{B<:Binner,T<:Real}(Bin::Binner, v::AbstractVector{T})::B

end

function predict{B<:Binner}(
            Bin::B,
            v::AbstractVector{T};
            asinteger::Bool=false,
            labels::AbstractVector=nothing, args...)::AbstractVector
  binned = cutvar(v, Bin.cuts)
  if asinteger return binned end
  if labels != nothing return labels[binned] end
  return labelcuts(Bin.cuts, args...)[binned]
end


# ========================
#
# ========================

function parsecut(c::String)::Cut
  errmsg = "Improper cut formatting"
  p_linc = r"^\["; p_uinc = r"\]$"
  p_lexc = r"^\("; p_uexc = r"\)$"
  p_lext = r"^\{"; p_uext = r"\}$"
  pnum = r"[0-9](\.[0-9])?"

  # Lowerbound bracket
  lbb = nothing
  if ismatch(p_linc, c)
    lbb = :inc
  elseif ismatch(p_lexc, c)
    lbb = :exc
  elseif ismatch(p_lext, c)
    lbb = :ext
  end
  if lbb == nothing throw(errmsg) end

  # Upperbound bracket
  ubb = nothing
  if ismatch(p_uinc, c)
    ubb = :inc
  elseif ismatch(p_uexc, c)
    ubb = :exc
  elseif ismatch(p_uext, c)
    ubb = :ext
  end
  if ubb == nothing throw(errmsg) end

  # Numbers
  num = [parse(x.match) for x in eachmatch(pnum, c)]
  if length(num) != 2 throw(errmsg) end

  Cut(lbb, num[1], ubb, num[2])

end

function parsecuts(c::String)::Vector{Cut}
  const pcut = r"([\{\[\(])([0-9](\.[0-9])?).?([0-9](\.[0-9])?)([\}\]\)])"
  cuts = Vector{Cut}()

  for m in eachmatch(pcut, c)
    cuts = vcat(cuts, parsecut(string(m.match)))
  end

  return cuts

end

function incut{T<:Real}(v::T, c::Cut)::Bool
  m = Dict(
    :lb => Dict(:inc => >=, :exc => >),
    :ub => Dict(:inc => <=, :exc => <)
  )

  m[:lb][c.lbb](v, c.lb) && m[:ub][c.ubb](v, c.ub)
end


function cutvar{T<:Real}(
            v::AbstractVector{T},
            cuts::AbstractVector{Cut})::Vector{Int}
  cutind = collect(eachindex(cuts))
  ind = Vector{Int}()
  for i in eachindex(v)
    c = [incut(v[i], x) for x in cuts]
    append!(ind, minimum(cutind[c]))
  end
  return ind
end

function cut_string(c::Cut)::String
  lbb = c.lbb == :inc ? "[" : "("
  ubb = c.ubb == :inc ? "]" : ")"
  return string(lbb, c.lb, ",", c.ub, ubb)
end


function labelcuts(cuts::AbstractVector{Cuts};
                   floatprecision::Int=4)::Vector{String}
  lbound = string.( round(cuts[1:(end-1)], floatprecision) )
  ubound = string.( round(cuts[2:end], floatprecision) )
  labels = Vector{String}()
  for i in eachindex(lbound)
    s =
  end
end
