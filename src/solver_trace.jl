import Base: push!

mutable struct SolverTrace
    num_steps::Int
    i::Int
    print_interval::Int
    progress::Progress
    columns::Vector{TraceColumn}
end

function SolverTrace(num_steps::Int,
                     columns::TraceColumn...;
                     num_printouts::Integer=min(num_steps,10),
                     kwargs...)
    print_interval = num_printouts > num_steps ? 1 : num_steps÷num_printouts

    columns = Vector{TraceColumn}([columns...])
    isempty(columns) && push!(columns, CurrentStep(num_steps))

    progress = Progress(num_steps; kwargs...)
    SolverTrace(num_steps, 0, print_interval, progress, columns)
end

push!(trace::SolverTrace, column::TraceColumn) =
    push!(trace.columns, column)

clear_current_line(io::IO=stdout) = print(io, "\r\u1b[K")

function print_header(s::SolverTrace)
    println(crayon"underline", join(map(column -> column.header, s.columns), " "), crayon"reset")
end

function next!(s::SolverTrace)
    s.i += 1
    if s.i%s.print_interval == 0 || s.i==1
        # Carriage return & clearing has to be done on stderr since
        # ProgressMeter prints to that stream; this is important on
        # Windows.
        clear_current_line(stderr)
        println(join(map(column -> format(column.fmt, column(s.i)...), s.columns), " "))
    end
    ProgressMeter.next!(s.progress)
end

export SolverTrace, print_header
