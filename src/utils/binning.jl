# Sources
# - http://www.saedsayad.com/binning.htm
# -

# [ - inclusive
# ( - exclusive
# { - extends

# ========================
# Variable Binning
# ========================
abstract type Binner end

"""
XYZ
"""
struct Cut
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

"""
QuantileBinner

Cuts a vector into quantiles of equal length. Defaults
to quartiles (0% : 25% : 100%).
"""
struct QuantileBinner <: Binner
  cuts::Vector{Cut}

  function QuantileBinner{T<:Real}(v::AbstractVector{T},
                                   qt=0:.25:1;
                                   args...)
    new(getcuts(quantile(v, qt); args...))
  end
end

"""
NumericBinner

Cuts a vector given manual specifications.

Example:\n
```julia
NumericBinner([1, 10, 30, 50])
NumericBinner("{1,10)[10,30)[30,50}")
```
"""
struct NumericBinner <: Binner
  cuts::Vector{Cut}

  function NumericBinner{T<:Real}(v::AbstractVector{T}; args...)
    new(getcuts(v; args...))
  end

  function NumericBinner(c::AbstractString)
    new(parsecuts(c))
  end
end

"""
FrequencyBinner

Choose cuts that equalizes frequency per bin with
respect to some other reference variable(s).
"""
struct FrequencyBinner <: Binner
  cuts::Vector{Cut}

  function FrequencyBinner(ncuts::Int, ref::AbstractVecOrMat)

  end
end

"""
RankBinner
"""
struct RankBinner <: Binner
  cuts::Vector{Cut}

  function RankBinner()

  end
end

"""
FunctionalBinner

Pass a custom anonymous function that returns the integer bin on a single
value.

Example:\n
```julia
FunctionalBinner(v, x->trunc(Int, floor(log(x))))
```
"""
struct FunctionalBinner <: Binner
  cuts::Vector{Cut}
  func::Function

  function FunctionalBinner{T<:Real}(v::AbstractVector{T},
                                     func::Function; encode=false)

  end
end

"""
EntropyBinner

Choose cuts that minimizes entropy (i.e. maximizes information gain)
with respect to some other dependent variable(s).
"""
struct EntropyBinner <: Binner
  cuts::Vector{Cut}

  function EntropyBinner()

  end
end


# ========================
# API
# ========================
function train!{B<:Binner,T<:Real}(Bin::Binner, v::AbstractVector{T})::B

end

function predict{B<:Binner,T<:Real}(Bin::B, v::AbstractVector{T};
            as_int::Bool=false,
            labels::AbstractVector=[],
            float_prec=16)::AbstractVector
  binned = cutvar(v, Bin.cuts)
  if as_int return binned end
  if length(labels) == length(Bin.cuts) return labels[binned] end
  return labelcuts(Bin.cuts, fprec=float_prec)[binned]
end


# ========================
#
# ========================

# xyz
function parsecut(c::AbstractString)::Cut
  p_linc = r"^\["; p_uinc = r"\]$"
  p_lexc = r"^\("; p_uexc = r"\)$"
  p_lext = r"^\{"; p_uext = r"\}$"
  pnum = r"[0-9](\.[0-9])?"

  c = replace(c, " ", "")

  # Lowerbound bracket
  lbb = nothing
  if ismatch(p_linc, c)
    lbb = :inc
  elseif ismatch(p_lexc, c)
    lbb = :exc
  elseif ismatch(p_lext, c)
    lbb = :ext
  end
  if lbb == nothing throw("Unrecognized lowerbound bracket") end

  # Upperbound bracket
  ubb = nothing
  if ismatch(p_uinc, c)
    ubb = :inc
  elseif ismatch(p_uexc, c)
    ubb = :exc
  elseif ismatch(p_uext, c)
    ubb = :ext
  end
  if ubb == nothing throw("Unrecognized upperbound bracket") end

  # Numbers
  s = split(c, ",")
  if length(s) != 2 throw("Numeric pattern not found in string") end
  num = (parse(s[1][2:end]), parse(s[2][1:(end-1)]))

  Cut(lbb, num[1], ubb, num[2])

end

# xyz
function parsecuts(c::String)::Vector{Cut}
  pcut = r"[\{\[\(][0-9]+(\.[0-9])*,[0-9]+(\.[0-9])*[\}\]\)]"
  cuts = Vector{Cut}()

  for m in eachmatch(pcut, c)
    cuts = vcat(cuts, parsecut(string(m.match)))
  end

  return cuts

end

# xyz
function incut{T<:Real}(v::T, c::Cut)::Bool
  m = Dict(
    :lb => Dict(:inc => >=, :exc => >),
    :ub => Dict(:inc => <=, :exc => <)
  )

  m[:lb][c.lbb](v, c.lb) && m[:ub][c.ubb](v, c.ub)
end

# xyz
function getcuts{T<:Real}(qs::AbstractVector{T};
                          asymptotic::Bool=true,
                          extendlbound::Bool=true,
                          extendubound::Bool=true)::Vector{Cut}
  if asymptotic==false
    extendlbound = false
    extendubound = false
  end

  cuts = Vector{Cut}()
  for i = 1:(length(qs)-1)
    lbb = (i==1 && extendlbound) ? :ext : :inc
    ubb = (i==length(qs)-1 && extendubound) ? :ext : :exc
    cuts = vcat(cuts, Cut(lbb, qs[i], ubb, qs[i+1]))
  end

  cuts
end

# xyz
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

# xyz
function cut_string(c::Cut; fprec::Int=16)::AbstractString
  lbb = c.lbb == :inc ? "[" : "("
  ubb = c.ubb == :inc ? "]" : ")"
  return string(lbb, round(c.lb, fprec), ",", round(c.ub, fprec), ubb)
end

# xyz
function cut_string(cutvec::Vector{Cut}; fprec::Int=16)::AbstractString
  s = ""
  for cut in cutvec
    s = string(s, cut_string(cut, fprec=fprec))
  end
  s
end

# xyz
function labelcuts(cuts::AbstractVector{Cut};
                   fprec::Int=16)::Vector{String}
  [cut_string(c, fprec=fprec) for c in cuts]
end
