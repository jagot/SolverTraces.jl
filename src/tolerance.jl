using UnicodeFun

function base_exp(v::T) where {T<:AbstractFloat}
    v == zero(T) && return (zero(T),0)
    r = log10(v)
    e = floor(Int,r)
    b = T(10)^(r-e)
    b,e
end

mutable struct Tolerance{T<:AbstractFloat} <: TraceColumn
    target::T
    current::T
    fmt::FormatExpr
    tol_fmt::FormatExpr
    lc::LinearColorant{T}
    header::String
end
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
function(t::Tolerance)(i::Integer)
    tb,te = base_exp(abs(t.current))
    (t.lc((log10(t.target)-log10(t.current))/log10(t.target)),
     format(t.tol_fmt,tb,to_superscript(te)))
end

export Tolerance
