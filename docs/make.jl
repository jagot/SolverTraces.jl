using Documenter, SolverTraces

DocMeta.setdocmeta!(SolverTraces, :DocTestSetup,
                    :(using SolverTraces, Unitful); recursive=true)

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
)

deploydocs(;
    repo="github.com/jagot/SolverTraces.jl",
)