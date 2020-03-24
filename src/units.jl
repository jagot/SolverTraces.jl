using Unitful

"""
    shift_prefix(u, e)

Shift the SI prefix of the unit `u` by `e` orders of magnitude (which
needs to be a multiple of 3).
"""
function shift_prefix(u::Unitful.FreeUnits{N,D,A},e) where {N,D,A}
    rem(e,3) == 0 || throw(ArgumentError("Cannot shift prefix by $(e), only multiples of 3 allowed"))
    U = first(N)
    Ũ = typeof(U)(U.tens + e, U.power)
    Unitful.FreeUnits{(Ũ,N[2:end]...),D,A}()
end

"""
    SI_prefix_convert(q)

Shift the SI prefix of the quantity `q` such that no zeros appear
before the decimal point, and at most three figures do. Note that this
conversion is not necessarily numerically accurate, it is mostly
intended for display purposes.

# Examples

```jldoctest
julia> SolverTraces.SI_prefix_convert(1.0u"nm")
1.0 nm

julia> SolverTraces.SI_prefix_convert(0.10u"nm")
100.0 pm

julia> SolverTraces.SI_prefix_convert(100.0u"nm")
100.0 nm

julia> SolverTraces.SI_prefix_convert(999.0u"nm")
999.0 nm
```
"""
function SI_prefix_convert(q::Quantity)
    v = ustrip(q)
    v == 0.0 && return q
    e = 3*(abs(v) > 1 ? floor(Int, log10(abs(v))/3) : -ceil(Int,log10(1/abs(v))/3))
    (v/10.0^e)*shift_prefix(unit(q), e)
end
