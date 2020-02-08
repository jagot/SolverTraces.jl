import SolverTraces: safe_lerp, ilerp, sat_ilerp,
    CrayonWrap, StrWrap
using Crayons

@testset "LERP" begin
    for t = 0.0:0.1:1.0
        @test safe_lerp(0.0, 1.0, t) == t
        @test safe_lerp(0.0, 2.0, t) == 2t
    end
    @test safe_lerp(0.0, 1.0, NaN) == 0.0
    @test safe_lerp(0.0, 1.0, -Inf) == 0.0
    @test safe_lerp(0.0, 1.0, Inf) == 1.0

    @test ilerp.(0, 2, 0:0.05:1) == vcat(repeat([0], 6),
                                         repeat([1], 9),
                                         repeat([2], 6))

    @test sat_ilerp(0, 2, 1.1) == 4
    @test sat_ilerp(0, 2, -0.1) == 0
    @test sat_ilerp(0, 128, 1.1) == 255
end

@testset "Linear colorants" begin
    @testset "Continuous" begin
        lc = LinearColorant(-1.0, 1.0, ((255, 0, 0), (0, 255, 0)))
        @test lc(-1.0) == CrayonWrap(foreground=(255, 0, 0))
        @test lc(0.0) == CrayonWrap(foreground=(255, 255, 0))
        @test lc(1.0) == CrayonWrap(foreground=(0, 255, 0))
    end

    @testset "Discrete steps" begin
        lc = LinearColorant(-1.0, 1.0, [crayon"light_red", crayon"yellow", crayon"light_green"])
        @test lc(-1.0) == StrWrap(crayon"light_red")
        @test lc(-0.6) == StrWrap(crayon"light_red")
        @test lc(-0.5) == StrWrap(crayon"yellow")
        @test lc(0.0) == StrWrap(crayon"yellow")
        @test lc(0.5) == StrWrap(crayon"yellow")
        @test lc(0.6) == StrWrap(crayon"light_green")
        @test lc(1.0) == StrWrap(crayon"light_green")
    end
end
