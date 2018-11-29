import Base: push!

mutable struct SolverTrace
    num_steps::Int
    i::Int
    num_printouts::Int
    progress::Progress
    columns::Vector{TraceColumn}
end

function SolverTrace(num_steps::Int,
                     columns::TraceColumn...;
                     num_printouts::Integer=min(num_steps,10),
                     barglyphs=BarGlyphs("[+> ]"), barlen=50)
    columns = Vector{TraceColumn}([columns...])
    isempty(columns) && push!(columns, CurrentStep(num_steps))

    progress = Progress(num_steps; barglyphs=barglyphs, barlen=barlen)
    SolverTrace(num_steps, 0, num_printouts, progress, columns)
end

push!(trace::SolverTrace, column::TraceColumn) =
    push!(trace.columns, column)

function clear_current_line()
    print("\33[2K\r")
end

function print_header(s::SolverTrace)
    println(crayon"underline", join(map(column -> column.header, s.columns), " "), crayon"reset")
end

function next!(s::SolverTrace)
    s.i += 1
    if s.i%(s.num_steps÷s.num_printouts) == 0 || s.i==1
        clear_current_line()
        println(join(map(column -> format(column.fmt, column(s.i)...), s.columns), " "))
    end
    ProgressMeter.next!(s.progress)
end

export SolverTrace, print_header
