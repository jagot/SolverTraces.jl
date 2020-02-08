import SolverTraces: scalar_format

@testset "Scalar column" begin
    @test format(scalar_format(Float64, false), 1.0) == "1.000e+00"
    @test format(scalar_format(Float64, false), 100.0) == "1.000e+02"
    @test format(scalar_format(Float64, true), 1.0) == "+1.000e+00"
    @test format(scalar_format(Float64, true), -1.0) == "-1.000e+00"

    @test format(scalar_format(Int, false), 1) == "   1 "
    @test format(scalar_format(Int, false), 100) == " 100 "
    @test format(scalar_format(Int, true), 1) == "  +1 "
    @test format(scalar_format(Int, true), -1) == "  -1 "
    @test format(scalar_format(Int, true), 100) == "+100 "
    @test format(scalar_format(Int, true), -100) == "-100 "

    scf = ScalarColumn(identity, "", Float64)
    @test format(scf, 1) == "1.000e+00"
    @test format(scf, 100) == "1.000e+02"

    sci = ScalarColumn(i -> i^2, "", Int)
    @test format(sci, 1) == "   1 "
    @test format(sci, 10) == " 100 "
end
