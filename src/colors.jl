function safe_lerp(a, b, t::T) where T
    isnan(t) && return a
    if !isfinite(t)
        t = sign(t) == 1 ? one(T) : zero(T)
    end
    (one(T)-t)*a + t*b
end
ilerp(a,b,t) = round(Int, safe_lerp(a, b, t))
sat_ilerp(a,b,t) = clamp(ilerp(2a,2b,t),0,255)

red_green_scale() = @static Sys.iswindows() ? [crayon"light_red", crayon"yellow", crayon"light_green"] : ((255, 0, 0), (0, 255, 0))

# String wrapping proxy object used to force Crayons being formatted
# as strings.
struct StrWrap{O}
    o::O
end
Base.repr(sw::StrWrap{O}) where O = string(sw.o)

CrayonWrap(args...; kwargs...) = StrWrap(Crayon(args...; kwargs...))

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
