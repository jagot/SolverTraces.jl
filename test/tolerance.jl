import SolverTraces: base_exp

function test_base_exp(v, b, e)
    bv,be = base_exp(v)
    @test bv ≈ b
    @test be == e
end

@testset "Tolerance" begin
    test_base_exp(0.0, 0.0, 0)
    test_base_exp(3.5e2, 3.5, 2)
    test_base_exp(-3.5e2, -3.5, 2)
    test_base_exp(0.1, 1.0, -1)
    test_base_exp(-0.01π, -π, -2)

    t = Tolerance(1e-3)
    t.current=1.0
    @test format(t, 1) == "\e[38;2;255;0;0m1.00×10⁰  \e[0m(10⁻³)"

    t.current=1e-1
    @test format(t, 1) == "\e[38;2;255;170;0m1.00×10⁻¹ \e[0m(10⁻³)"

    t.current=1e-2
    @test format(t, 1) == "\e[38;2;170;255;0m1.00×10⁻² \e[0m(10⁻³)"

    t.current=1e-3
    @test format(t, 1) == "\e[38;2;0;255;0m1.00×10⁻³ \e[0m(10⁻³)"
    
    t = Tolerance(1e-3, print_target=false)
    t.current=1.0
    @test format(t, 1) == "\e[38;2;255;0;0m1.00×10⁰  \e[0m"

    t.current=1e-1
    @test format(t, 1) == "\e[38;2;255;170;0m1.00×10⁻¹ \e[0m"

    t.current=1e-2
    @test format(t, 1) == "\e[38;2;170;255;0m1.00×10⁻² \e[0m"

    t.current=1e-3
    @test format(t, 1) == "\e[38;2;0;255;0m1.00×10⁻³ \e[0m"
end
