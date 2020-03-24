"""
    ETA(steps, header, t₀, fmt)

This trace column can be used to indicate the estimated time of
completion of a calculation.
"""
struct ETA <: TraceColumn
    steps::Int
    header::String
    t₀::Float64
    fmt::FormatExpr
end

"""
    ETA(steps[, name="ETA"])

Constructe a [`ETA`](@ref) trace column, for a specific number of
`steps`.
"""
function ETA(steps::Int, name::String="ETA")
    # It would possibly be good to allow for more than two-digit hour
    # counts, but still keep two-digit display for the standard case,
    # i.e. less than 100 hours. Is there a way to make fmt always
    # occupy e.g. 12 characters (and right-shifted), but keep, the
    # standard format 02d?
    ETA(steps, fmt(">8s", name), time(), FormatExpr("{1:02d}:{2:02d}:{3:02d}"))
end

function (p::ETA)(i::Integer)
    elapsed = time() - p.t₀
    seconds = (elapsed > 0 ? (p.steps-i)*elapsed/i : Inf)

    hours = div(seconds, 3600)
    seconds -= 3600hours

    minutes = div(seconds, 60)
    seconds -= 60minutes

    hours,minutes,trunc(Int, seconds)
end

export ETA
