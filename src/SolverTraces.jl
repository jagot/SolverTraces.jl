module SolverTraces
using Crayons
using Formatting
using ProgressMeter
using Compat

"""
    TraceColumn

Base type for all columns that can appear in a
[`SolverTrace`](@ref). Each subtype is expected to have a property
named `fmt` containing a formatting string, and to be callable with
the current step number as argument, returning the necessary values to
render the formatting string, alternatively overload
`Formatting.format(c::C, i::Integer) where {C<:TraceColumn}`.
"""
abstract type TraceColumn end
export TraceColumn

Formatting.format(c::TraceColumn, i::Integer) =
    format(c.fmt, c(i)...)

include("colors.jl")
include("current_step.jl")
include("units.jl")
include("performance.jl")
include("scalar_column.jl")
include("tolerance.jl")
include("solver_trace.jl")

end # module
