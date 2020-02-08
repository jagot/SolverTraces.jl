# Solver Trace Columns

```@docs
TraceColumn
```

## CurrentStep
```@docs
CurrentStep
CurrentStep(num_steps::Integer;
            lc::LinearColorant=LinearColorant(1, num_steps, red_green_scale()),
            header::String=repeat(" ", 2length(digits(num_steps))+3))
```

## Performance
```@docs
Performance
Performance(load::Number, load_name::String="Performance")
SolverTraces.shift_prefix
SolverTraces.SI_prefix_convert
```

## ScalarColumn
```@docs
ScalarColumn
ScalarColumn(n::Function, header::String, ::Type{R}, signed=false) where {R<:Real}
```


## Tolerance
```@docs
Tolerance
Tolerance(target::T,header="Tolerance";print_target::Bool=true) where T
SolverTraces.base_exp
```

## ColumnSeparator

```@docs
ColumnSeparator
```
