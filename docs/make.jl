using SolverTraces
using Documenter

DocMeta.setdocmeta!(SolverTraces, :DocTestSetup, :(using SolverTraces); recursive=true)

makedocs(;
    modules=[SolverTraces],
    authors="Stefanos Carlström <stefanos.carlstrom@gmail.com>",
    sitename="SolverTraces.jl",
    format=Documenter.HTML(;
        canonical="https://www.tipota.org/SolverTraces.jl",
        edit_link="master",
        assets=["assets/style.css"],
    ),
    pages=[
        "Home" => "index.md",
        "Solver Trace Columns" => "columns.md",
        "Colors" => "colors.md",
    ],
    doctest=false
)

deploydocs(;
    repo="github.com/jagot/SolverTraces.jl",
    push_preview = true
)
