@testset "Current step" begin
    N = 10
    lc = LinearColorant(1, N, [crayon"light_red", crayon"yellow", crayon"light_green"])
    c = CurrentStep(N, lc=lc, header="Current step")
    for (i,color) in enumerate([crayon"light_red",
                                crayon"light_red",
                                crayon"light_red",
                                crayon"yellow",
                                crayon"yellow",
                                crayon"yellow",
                                crayon"yellow",
                                crayon"light_green",
                                crayon"light_green",
                                crayon"light_green"])
        si = i == 10 ? "10" : " $i"
        @test format(c.fmt, c(i)...) == "[$(color)$(si)/$(N)$(crayon"reset")]     "
    end
end
