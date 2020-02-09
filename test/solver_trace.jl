function redirect_output(fun::Function)
    buf = IOBuffer()
    fun(IOContext(buf, :color => true))
    String(take!(buf))
end

function test_output(fun::Function, reference="")
    res = redirect_output(fun)
    test_esc_str_equal(res, reference)
end

@testset "Solver trace" begin
    @test format(ColumnSeparator(), 1) == "│"

    test_output() do io
        s = SolverTrace(10, io=io)
    end

    test_output("$(crayon"underline")       $(crayon"reset")\n") do io
        s = SolverTrace(10, io=io)
        print_header(s)
    end

    test_output("""[$(crayon"fg:(255,0,0)") 1/10$(crayon"reset")]
[$(crayon"fg:(255,57,0)") 2/10$(crayon"reset")]
[$(crayon"fg:(255,113,0)") 3/10$(crayon"reset")]
[$(crayon"fg:(255,170,0)") 4/10$(crayon"reset")]
[$(crayon"fg:(255,227,0)") 5/10$(crayon"reset")]
[$(crayon"fg:(227,255,0)") 6/10$(crayon"reset")]
[$(crayon"fg:(170,255,0)") 7/10$(crayon"reset")]
[$(crayon"fg:(113,255,0)") 8/10$(crayon"reset")]
[$(crayon"fg:(57,255,0)") 9/10$(crayon"reset")]
[$(crayon"fg:(0,255,0)")10/10$(crayon"reset")]
""") do io
    N = 10
    s = SolverTrace(N, io=io, progress_meter=false)
    for i = 1:N
        SolverTraces.next!(s)
    end
end

    test_output(
        """[$(crayon"fg:(255,0,0)") 1/20$(crayon"reset")]
[$(crayon"fg:(255,27,0)") 2/20$(crayon"reset")]
[$(crayon"fg:(255,81,0)") 4/20$(crayon"reset")]
[$(crayon"fg:(255,134,0)") 6/20$(crayon"reset")]
[$(crayon"fg:(255,188,0)") 8/20$(crayon"reset")]
[$(crayon"fg:(255,242,0)")10/20$(crayon"reset")]
[$(crayon"fg:(215,255,0)")12/20$(crayon"reset")]
[$(crayon"fg:(161,255,0)")14/20$(crayon"reset")]
[$(crayon"fg:(107,255,0)")16/20$(crayon"reset")]
[$(crayon"fg:(54,255,0)")18/20$(crayon"reset")]
[$(crayon"fg:(0,255,0)")20/20$(crayon"reset")]
"""
    ) do io
        N = 20
        s = SolverTrace(N, io=io)
        for i = 1:N
            SolverTraces.next!(s)
        end
    end

    test_output(
        "$(crayon"underline")Hello   World$(crayon"reset")\n   1  │    1 \n   2  │    4 \n   3  │    9 \n   4  │   16 \n   5  │   25 \n   6  │   36 \n   7  │   49 \n   8  │   64 \n   9  │   81 \n  10  │  100 \n"
    ) do io
        N = 10
        s =  SolverTrace(N,
                         ScalarColumn(identity, "Hello", Int),
                         ColumnSeparator(),
                         ScalarColumn(i -> i^2, "World", Int),
                         io=io)
        print_header(s)
        for i = 1:N
            SolverTraces.next!(s)
        end
    end

    @testset "Callbacks" begin
        N = 20
        iterations = Int[]
        iterations2 = Int[]
        s = SolverTrace(N, callbacks = ((i -> push!(iterations, i)),))
        for i = 1:N
            SolverTraces.next!(s) do
                push!(iterations2, i)
            end
        end

        @test iterations == iterations2 == [1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
    end
end
