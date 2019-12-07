struct ScalarColumn{R} <: TraceColumn
    fmt::FormatExpr
    header::String
    n::Function
end

scalar_format(::Type{R}, signed) where R =
    FormatExpr("{1:$(signed ? '+' : "")9.3e}")

scalar_format(::Type{R}, signed) where {R<:Integer} =
    FormatExpr("{1:$(signed ? '+' : "")4d} ")

function ScalarColumn(n::Function, header::String, ::Type{R}, signed=false) where {R<:Real}
    fmt = scalar_format(R, signed)
    ScalarColumn{R}(fmt, lpad(header, length(format(fmt, n(1)))), n)
end

(c::ScalarColumn{R})(i::Integer) where R = c.n(i)

export ScalarColumn
