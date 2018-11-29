import Base: repr

ilerp(a,b,t) = round(Int, (1-t)*a + t*b)
sat_ilerp(a,b,t) = round(Int,clamp(2(1-t)*a + 2t*b,0,255))
red = (255, 0, 0)
green = (0, 255, 0)

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
    ca::C
    cb::C
end

(lc::LinearColorant{T,C})(t::T) where {T,C} =
    CrayonWrap(foreground=sat_ilerp.(lc.ca, lc.cb, (t-lc.a)/(lc.b-lc.a)))

export LinearColorant
