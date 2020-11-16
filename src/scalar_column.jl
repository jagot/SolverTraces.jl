"""
    ScalarColumn(fmt, header, n)

Trace column for any kind of scalar, returned by the callback function
`n`. Alternatively, `n` can be a scalar set manually by the user.
"""
mutable struct ScalarColumn{R,N} <: TraceColumn
    fmt::FormatExpr
    header::String
    n::N
end

scalar_format(::Type{R}, signed) where R =
    FormatExpr("{1:$(signed ? '+' : "")10.3e}")

scalar_format(::Type{R}, signed) where {R<:Integer} =
    FormatExpr("{1:$(signed ? '+' : "")4d} ")

"""
    ScalarColumn(n, header, ::Type{R}[, signed=false]) where {R<:Real}

Construct a [`ScalarColumn`](@ref) for the callback function `n`, with
a format automatically generated depending on `R` is an integer or
not, and whether it can be signed.
"""
function ScalarColumn(n::Function, header::String, ::Type{R}, signed=false) where {R<:Real}
    fmt = scalar_format(R, signed)
    ScalarColumn{R,typeof(n)}(fmt, lpad(header, length(format(fmt, n(1)))), n)
end

"""
    ScalarColumn(n::R, header[, signed=false]) where {R<:Real}

Construct a [`ScalarColumn`](@ref) for the scalar value `n`, with
a format automatically generated depending on `R` is an integer or
not, and whether it can be signed.
"""
function ScalarColumn(n::R, header::String, signed=false) where {R<:Real}
    fmt = scalar_format(R, signed)
    ScalarColumn{R,R}(fmt, lpad(header, length(format(fmt, n))), n)
end

(c::ScalarColumn{R,<:Function})(i::Integer) where R = c.n(i)
(c::ScalarColumn{R})(i::Integer) where R = c.n

export ScalarColumn
