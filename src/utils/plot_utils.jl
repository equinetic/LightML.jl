# =====================
# Plots.jl Extensions
# =====================

function Plots.plot(r::ROCCurve, x...)
    Plots.plot(r.x_vals, r.y_vals,
        xlabel=r.xlabel,
        ylabel=r.ylabel,
        title=r.fundesc, x...)
end

function Plots.scatter(r::ROCCurve, x...)
    Plots.plot(r.x_vals, r.y_vals,
        xlabel=r.xlabel,
        ylabel=r.ylabel,
        title=r.fundesc, x...)
end

# =====================
# Base.print Extensions
# =====================

function Base.print(c::ConfusionMatrix)
    println("  + -")
    println("+ ", c.tp, " ", c.fn)
    println("- ", c.fp, " ", c.tn)
end
