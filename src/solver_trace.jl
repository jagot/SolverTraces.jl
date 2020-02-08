"""
    SolverTrace(num_steps, i, print_interval, io, progress, columns, callbacks)

Represents a solver trace for `num_steps` iterations, `i` being the
current one. Each time [`next!`](@ref) is called, `i` is incremented
by one, and if a multiple of `print_interval` is reached, a line is
printed in the trace. Optionally (default), a `ProgressMeter.Progress`
is shown as well, providing progress information between solver trace
printouts.
"""
mutable struct SolverTrace{P,TCs,Callbacks,IOt<:IO}
    num_steps::Int
    i::Int
    print_interval::Int
    io::IOt
    progress::P
    columns::TCs
    callbacks::Callbacks
end

function SolverTrace(num_steps::Int,
                     column::TraceColumn = CurrentStep(num_steps),
                     columns::TraceColumn...;
                     io::IO=stdout,
                     num_printouts::Integer=min(num_steps,10),
                     progress_meter::Bool=true,
                     callbacks=(),
                     print_interval = num_printouts > num_steps ? 1 : num_steps÷num_printouts,
                     kwargs...)
    columns = (column,columns...)

    progress = if progress_meter
        Progress(num_steps; kwargs...)
    else
        nothing
    end
    SolverTrace(num_steps, 0, print_interval, io, progress, columns, callbacks)
end

clear_current_line(io::IO=stdout) = print(io, "\r\u1b[K")

"""
    print_header(s)

Print the associated header of the [`SolverTrace`](@ref) `s`.
"""
print_header(s::SolverTrace) =
    println(s.io,
            crayon"underline",
            join(map(column -> column.header, s.columns), " "),
            crayon"reset")

Formatting.format(s::SolverTrace) =
    join(map(column -> format(column, s.i), s.columns), " ")

next!(::Nothing; kwargs...) = nothing
next!(progress::Progress; kwargs...) = ProgressMeter.next!(progress; kwargs...)

"""
    next!(fun, s::SolverTrace; kwargs...)

Signal to the [`SolverTrace`](@ref) `s` that the next iteration has
been performed, increasing the internal counter `s.i`. If a multiple
of `s.print_interval` is reached, a line in the solver trace is
printed, formatting each and every trace column, the callback function
`fun` is called, as well as all the registered callbacks.

`kwargs` are passed on to `ProgressMeter.next!` to allow
e.g. `showvalues` functionality.

"""
function next!(fun::Function, s::SolverTrace; kwargs...)
    s.i += 1
    if s.i%s.print_interval == 0 || s.i==1
        fun()
        # Carriage return & clearing has to be done on stderr since
        # ProgressMeter prints to that stream; this is important on
        # Windows.
        isnothing(s.progress) || clear_current_line(stderr)
        println(s.io, format(s))
        foreach(f -> f(s.i), s.callbacks)
    end
    next!(s.progress; kwargs...)
end
next!(s::SolverTrace; kwargs...) = next!(() -> nothing, s; kwargs...)

"""
    ColumnSeparator(fmt, header)

Simple separator between columns, that by default simply prints a
pipe.
"""
struct ColumnSeparator <: TraceColumn
    fmt::FormatExpr
    header::String
end

ColumnSeparator() = ColumnSeparator(FormatExpr("│"), " ")
(c::ColumnSeparator)(i::Integer) = ()

export SolverTrace, print_header, ColumnSeparator
