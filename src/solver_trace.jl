mutable struct SolverTrace{P}
    num_steps::Int
    i::Int
    print_interval::Int
    progress::P
    columns::Vector{TraceColumn}
    callbacks::Vector
end

function SolverTrace(num_steps::Int,
                     columns::TraceColumn...;
                     num_printouts::Integer=min(num_steps,10),
                     progress_meter::Bool=true,
                     callbacks::Vector=[],
                     print_interval = num_printouts > num_steps ? 1 : num_steps÷num_printouts,
                     kwargs...)
    columns = Vector{TraceColumn}([columns...])
    isempty(columns) && push!(columns, CurrentStep(num_steps))

    progress = if progress_meter
        Progress(num_steps; kwargs...)
    else
        nothing
    end
    SolverTrace(num_steps, 0, print_interval, progress, columns, callbacks)
end

Base.push!(s::SolverTrace, column::TraceColumn) = push!(s.columns, column)

clear_current_line(io::IO=stdout) = print(io, "\r\u1b[K")

print_header(s::SolverTrace) =
    println(crayon"underline",
            join(map(column -> column.header, s.columns), " "),
            crayon"reset")

next!(::Nothing; kwargs...) = nothing
next!(progress::Progress; kwargs...) = ProgressMeter.next!(progress; kwargs...)

function next!(s::SolverTrace; kwargs...)
    s.i += 1
    if s.i%s.print_interval == 0 || s.i==1
        # Carriage return & clearing has to be done on stderr since
        # ProgressMeter prints to that stream; this is important on
        # Windows.
        clear_current_line(stderr)
        println(join(map(column -> format(column.fmt, column(s.i)...), s.columns), " "))
        foreach(f -> f(s.i), s.callbacks)
    end
    next!(s.progress; kwargs...)
end

struct ColumnSeparator <: TraceColumn
    fmt::FormatExpr
    header::String
end

ColumnSeparator() = ColumnSeparator(FormatExpr("│"), " ")
(c::ColumnSeparator)(i::Integer) = ()

export SolverTrace, print_header, ColumnSeparator
