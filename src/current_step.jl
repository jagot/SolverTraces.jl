struct CurrentStep <: TraceColumn
    num_steps::Integer
    fmt::FormatExpr
    lc::LinearColorant{Int}
    header::String
end
function CurrentStep(num_steps::Integer;
                     lc::LinearColorant=LinearColorant(1, num_steps, red_green_scale()),
                     header::String=repeat(" ", 2length(digits(num_steps))+3))
    nd = length(digits(num_steps))
    spacer = repeat(" ", max(0,length(header)-2nd-3))
    CurrentStep(num_steps,
                FormatExpr("[{1:s}{2:$(nd)d}/{3:$(nd)d}$(crayon"reset")]$spacer"),
                lc, rpad(header, 2nd+3))
end
(c::CurrentStep)(i::Integer) = (c.lc(i), i, c.num_steps)

export CurrentStep
