using Documenter, SolverTraces

makedocs(;
    modules=[SolverTraces],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/jagot/SolverTraces.jl/blob/{commit}{path}#L{line}",
    sitename="SolverTraces.jl",
    authors="Stefanos Carlström <stefanos.carlstrom@gmail.com>",
)

deploydocs(;
    repo="github.com/jagot/SolverTraces.jl",
)
