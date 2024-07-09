"""
    safe_lerp(a, b, t)

Safe implementation of linear interpolation (lerp) between `a` and
`b`, where `t` is the linear parameter. If `isnan(t)`, `a` is
returned, and if `t` is infinite, `a` or `b` is returned, depending on
the sign.
"""
function safe_lerp(a, b, t::T) where T
    isnan(t) && return a
    if !isfinite(t)
        t = sign(t) == 1 ? one(T) : zero(T)
    end
    (one(T)-t)*a + t*b
end

"""
    ilerp(a, b, t)

Linear interpolation in integer steps.
"""
ilerp(a,b,t) = round(Int, safe_lerp(a, b, t))

"""
    sat_ilerp(a, b, t)

Saturated linear interpolation in integer steps, clamped to the range
`0:255` (the available colour space).
"""
sat_ilerp(a,b,t) = clamp(ilerp(2a,2b,t),0,255)

"""
    red_green_scale()

Return a red–green colour scale; on Windows (with only 16 colours
available), this is simply red, yellow, green, on other systems, the
end-points are returned instead, for use with [`sat_ilerp`](@ref).
"""
red_green_scale() = @static Sys.iswindows() ? [crayon"light_red", crayon"yellow", crayon"light_green"] : ((255, 0, 0), (0, 255, 0))

# String wrapping proxy object used to force Crayons being formatted
# as strings; necessary to play well with Format.jl. If a Crayon
# object is substituted directly into a formatting string, the escape
# code is printed (in the correct colour, style &c), but then the
# cancelling escape code is also printed.
struct StrWrap{O}
    o::O
end
Base.repr(sw::StrWrap{O}) where O = string(sw.o)

CrayonWrap(args...; kwargs...) = StrWrap(Crayon(args...; kwargs...))

"""
    LinearColorant(a, b, colors)

Helper structure to linearly interpolate between the possible values
in `colors`, where the scalar value `a` corresponds to the first value
and `b` to the last. If `colors` is a tuple of two triples, a
continuous interpolation between the endpoints will be the result,
whereas if it is a vector of `Crayon`s, nearest neighbour
interpolation will be performed instead.
"""
struct LinearColorant{T,C}
    a::T
    b::T
    colors::C
end

(lc::LinearColorant{T,C})(t::T) where {T,C<:NTuple{2,NTuple{3,Int}}} =
    CrayonWrap(foreground=sat_ilerp.(lc.colors[1], lc.colors[2],
                                     clamp((t-lc.a)/(lc.b-lc.a),zero(T),one(T))))

function (lc::LinearColorant{T,C})(t::T) where {T,C<:Vector{Crayon}}
    tt = clamp((t-lc.a)/(lc.b-lc.a), zero(T), one(T))
    i = round(Int, (1.0-tt)*1 + tt*length(lc.colors))
    StrWrap(lc.colors[i])
end

export LinearColorant
