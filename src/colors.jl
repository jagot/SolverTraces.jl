import Base: repr

ilerp(a,b,t) = round(Int, (1-t)*a + t*b)
sat_ilerp(a,b,t) = round(Int,clamp(2(1-t)*a + 2t*b,0,255))

red_green_scale() = @static Sys.iswindows() ? [crayon"light_red", crayon"yellow", crayon"light_green"] : ((255, 0, 0), (0, 255, 0))

# String wrapping proxy object used to force Crayons being formatted
# as strings.
struct StrWrap{O}
    o::O
end
repr(sw::StrWrap{O}) where O = string(sw.o)

CrayonWrap(args...; kwargs...) = StrWrap(Crayon(args...; kwargs...))

struct LinearColorant{T,C}
    a::T
    b::T
    colors::C
end

(lc::LinearColorant{T,C})(t::T) where {T,C<:NTuple{2,NTuple{3,Int}}} =
    CrayonWrap(foreground=sat_ilerp.(lc.colors[1], lc.colors[2], (t-lc.a)/(lc.b-lc.a)))

function (lc::LinearColorant{T,C})(t::T) where {T,C<:Vector{Crayon}}
    tt = (t-lc.a)/(lc.b-lc.a)
    i = round(Int, (1.0-tt)*1 + tt*length(lc.colors))
    StrWrap(lc.colors[i])
end

export LinearColorant
