using SolverTraces
using Formatting
using Test

stripesc(a::T) where {T<:String} = replace(a, r"\e\[(.*?)m" => "")

# We use this to compare escaped strings until
# https://github.com/JuliaLang/julia/issues/31491 is resolved
is_esc_str_equal = @static Sys.iswindows() ? ((a,b) -> stripesc(a) == stripesc(b)) : isequal

include("colors.jl")
include("current_step.jl")
include("performance.jl")
include("scalar_column.jl")
include("tolerance.jl")
