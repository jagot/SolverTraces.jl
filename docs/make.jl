using Documenter, SolverTraces

makedocs(;
    modules=[SolverTraces],
    format=Documenter.HTML(assets=["assets/style.css"]),
    pages=[
        "Home" => "index.md",
        "Solver Trace Columns" => "columns.md",
        "Colors" => "colors.md",
    ],
    repo="https://github.com/jagot/SolverTraces.jl/blob/{commit}{path}#L{line}",
    sitename="SolverTraces.jl",
    authors="Stefanos Carlström <stefanos.carlstrom@gmail.com>",
    doctest=false
)

deploydocs(;
    repo="github.com/jagot/SolverTraces.jl",
)
