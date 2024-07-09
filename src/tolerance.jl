using UnicodeFun

"""
    base_exp(v)

Convert the float `v` into a tuple of base and exponent in base-10.

# Examples

```julia-repl
julia> SolverTraces.base_exp(-3.5e2)
(-3.5000000000000004, 2)
```
"""
function base_exp(v::T) where {T<:AbstractFloat}
    v == zero(T) && return (zero(T),0)
    r = log10(abs(v))
    e = round(Int,r)
    b = T(10)^(r-e)
    if abs(b) < 1 && abs(abs(b)-1) > 1e-2
        b *= 10
        e -= 1
    end
    sign(v)*b,e
end

"""
    Tolerance(target, current, fmt, tol_fmt, lc, header)

Column displaying the progress of the algorithm towards a set
`target`. At each iteration, the `current` value has to be updated.
"""
mutable struct Tolerance{T<:AbstractFloat} <: TraceColumn
    target::T
    current::T
    fmt::FormatExpr
    tol_fmt::FormatExpr
    lc::LinearColorant{T}
    header::String
end

"""
     Tolerance(target[, header; print_target])

Construct a new [`Tolerance`](@ref) column with a set `target`.
"""
function Tolerance(target::T,header="Tolerance";print_target::Bool=true) where T
    tb,te = base_exp(target)
    tol_fmt = FormatExpr("{1:.2f}×10{2:3s}")
    target_str = if print_target
        "(" * (tb == one(T) ? "10$(to_superscript(te))" : strip(format(tol_fmt,tb,to_superscript(te)))) * ")"
    else
        ""
    end
    spacer = repeat(" ", max(0,length(header)-length(target_str)-10))
    fmt = FormatExpr("{1:s}{2:10s}$(crayon"reset")$(target_str)$spacer")
    lc = LinearColorant(one(T),zero(T),red_green_scale())
    Tolerance{T}(target,T(Inf),fmt,tol_fmt,lc,rpad(header,length(target_str)+10))
end

function (t::Tolerance{T})(i::Integer) where T
    if isinf(t.current) || isnan(t.current)
        t.lc(one(T)),string(t.current)
    else
        tb,te = base_exp(abs(t.current))
        (t.lc((log10(t.target)-log10(t.current))/log10(t.target)),
         format(t.tol_fmt,tb,to_superscript(te)))
    end
end

export Tolerance
