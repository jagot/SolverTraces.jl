struct CurrentStep <: TraceColumn
    num_steps::Integer
    fmt::FormatExpr
    lc::LinearColorant{Int}
    header::String
end
function CurrentStep(num_steps::Integer)
    nd = length(digits(num_steps))
    CurrentStep(num_steps,
                FormatExpr("[{1:s}{2:$(nd)d}/{3:$(nd)d}$(crayon"reset")]"),
                LinearColorant(1, num_steps, red_green_scale()),
                repeat(" ", 2nd+3))
end
(c::CurrentStep)(i::Integer) = (c.lc(i), i, c.num_steps)

export CurrentStep
