using Unitful

function shift_prefix(u::Unitful.FreeUnits{N,D,A},e) where {N,D,A}
    U = first(N)
    Ũ = typeof(U)(U.tens + e, U.power)
    Unitful.FreeUnits{(Ũ,N[2:end]...),D,A}()
end

function SI_prefix_convert(q::Quantity)
    v = ustrip(q)
    e = 3*(abs(v) > 1 ? floor(Int, log10(abs(v))/3) : -ceil(Int,log10(1/abs(v))/3))
    (v/10.0^e)*shift_prefix(unit(q), e)
end

struct Performance <: TraceColumn
    load::Number
    header::String
    t₀::Float64
    fmt::FormatExpr
end

function Performance(load::Number, load_name::String="Performance")
    Performance(load, fmt(">12s", load_name), time(), FormatExpr("{1:8.3f} {2:3s}"))
end

function (p::Performance)(i::Integer)
    elapsed = time() - p.t₀
    perf = SI_prefix_convert((elapsed > 0 ? i*p.load/elapsed : 0.0)*u"Hz")
    ustrip(perf),unit(perf)
end

export Performance
