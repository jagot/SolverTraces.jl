"""
    Performance(load, header, t₀, fmt)

This trace column can be used to indicate the performance of a
calculation, i.e. how many units (grid points, particles, &c) can the
algorithm handle per second. The number is shifted to the appropriate
order of magnitude, changing the SI prefix to e.g. `kHz`, `MHz`, &c.
"""
struct Performance{T} <: TraceColumn
    load::T
    header::String
    t₀::Float64
    fmt::FormatExpr
end

"""
    Performance(load[, load_name="Performance"])

Constructe a [`Performance`](@ref) trace column, for `load` number of
_units_ per iteration.
"""
function Performance(load::Number, load_name::String="Performance")
    Performance(load, fmt(">12s", load_name), time(), FormatExpr("{1:8.3f} {2:3s}"))
end

function (p::Performance)(i::Integer)
    elapsed = time() - p.t₀
    perf = SI_prefix_convert((elapsed > 0 ? i*p.load/elapsed : 0.0)*u"Hz")
    ustrip(perf),unit(perf)
end

export Performance
