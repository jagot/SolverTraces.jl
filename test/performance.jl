# It is not possible to test the Performance structure, since the
# output depends on the instant the columns is created and when it is
# called. We can test the SI prefix shifting however.

using Unitful
import SolverTraces: shift_prefix, SI_prefix_convert

@testset "SI prefices" begin
    @test shift_prefix(u"MHz", 6) == u"THz"
    @test shift_prefix(u"MHz", 3) == u"GHz"
    @test shift_prefix(u"MHz", -3) == u"kHz"
    @test shift_prefix(u"MHz", -6) == u"Hz"
    @test shift_prefix(u"MHz", -9) == u"mHz"
    @test_throws ArgumentError shift_prefix(u"MHz", 2)

    @test SI_prefix_convert(1.0u"nm") == 1.0u"nm"
    @test 0.10u"nm" ≠ 100.0u"pm"
    @test SI_prefix_convert(0.10u"nm") == 100.0u"pm"
    @test SI_prefix_convert(100.0u"nm") == 100.0u"nm"
    @test SI_prefix_convert(999.0u"nm") == 999.0u"nm"
end
