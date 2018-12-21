module SolverTraces
using Crayons
using Formatting
using ProgressMeter

abstract type TraceColumn end
export TraceColumn

include("colors.jl")
include("current_step.jl")
include("performance.jl")
include("tolerance.jl")
include("solver_trace.jl")

end # module
