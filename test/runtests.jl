using SolverTraces
using Format
using Test

stripesc(a::T) where {T<:String} = replace(a, r"\e\[(.*?)m" => "")

# We use this to compare escaped strings until
# https://github.com/JuliaLang/julia/issues/31491 is resolved
function test_esc_str_equal(a,b)
    A,B = @static if Sys.iswindows()
        stripesc(a), stripesc(b)
    else
        a,b
    end
    if A ≠ A
        println("Got:")
        println(a)
        println("Expected:")
        println(b)
    end
    @test A == A
end

include("colors.jl")
include("current_step.jl")
include("performance.jl")
include("scalar_column.jl")
include("tolerance.jl")
include("solver_trace.jl")
