# SolverTraces.jl

# Usage example

Using SolverTraces.jl is very easy:

```julia
N = 20 # Number of iterations

tol = Tolerance(1e-3)
tols = 10 .^ range(0, stop=-3, length=N)

trace = SolverTrace(N, CurrentStep(N),
                    ColumnSeparator(),
                    Performance(100), # Could be number of points processed each iteration
                    ColumnSeparator(),
                    tol)
print_header(trace)
for i = 1:N
    # Do work
    # ...
    # Set which tolerance was achieved in this iteration:
    tol.current = tols[i]

    SolverTraces.next!(trace)
end
```

which will give output similar to this:

```@raw html
<div class="repl"><u>           Performance   Tolerance       </u>
[<span style="color:#ff0000"> 1/20</span>] │  970.904 kHz │ <span style="color:#ff0000">1.00×10⁰  </span>(10⁻³)
[<span style="color:#ff1b00"> 2/20</span>] │  436.679 kHz │ <span style="color:#ff1b00">6.95×10⁻¹ </span>(10⁻³)
[<span style="color:#ff5100"> 4/20</span>] │  672.164 kHz │ <span style="color:#ff5100">3.36×10⁻¹ </span>(10⁻³)
[<span style="color:#ff8600"> 6/20</span>] │  892.722 kHz │ <span style="color:#ff8600">1.62×10⁻¹ </span>(10⁻³)
[<span style="color:#ffbc00"> 8/20</span>] │    1.074 MHz │ <span style="color:#ffbc00">7.85×10⁻² </span>(10⁻³)
[<span style="color:#fff200">10/20</span>] │    1.168 MHz │ <span style="color:#fff200">3.79×10⁻² </span>(10⁻³)
[<span style="color:#d7ff00">12/20</span>] │    1.207 MHz │ <span style="color:#d7ff00">1.83×10⁻² </span>(10⁻³)
[<span style="color:#a1ff00">14/20</span>] │    1.303 MHz │ <span style="color:#a1ff00">8.86×10⁻³ </span>(10⁻³)
[<span style="color:#6bff00">16/20</span>] │    1.431 MHz │ <span style="color:#6bff00">4.28×10⁻³ </span>(10⁻³)
[<span style="color:#36ff00">18/20</span>] │    1.561 MHz │ <span style="color:#36ff00">2.07×10⁻³ </span>(10⁻³)
[<span style="color:#00ff00">20/20</span>] │    1.685 MHz │ <span style="color:#00ff00">1.00×10⁻³ </span>(10⁻³)
</div>
```

## Optim.jl

It is similarly very easy to add colour to your
[Optim.jl](https://github.com/JuliaNLSolvers/Optim.jl/) runs:

```julia
f(x) = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
x0 = [0.0, 0.0]

max_iter = 100
tol = 1e-8

value = ScalarColumn(Inf, "Value")
tolerance = Tolerance(tol, "|∇|")

trace = SolverTrace(max_iter,
                    CurrentStep(max_iter), ColumnSeparator(), value, tolerance,
                    print_interval=1)
trace_callback = opt_state -> begin
    tolerance.current = opt_state.g_norm
    value.n = opt_state.value
    SolverTraces.next!(trace)
    false
end
options = Optim.Options(iterations=max_iter, g_tol=tol,
                        callback=trace_callback)
print_header(trace)
optimize(f, x0, options)
```

which will result in something similar to

```@raw html
<div class="repl"><u>                Value |∇|             </u>
[<span style="color:#ff0000">  1/100</span>] │ 9.507e-01 <span style="color:#ff5500">4.58×10⁻² </span>(10⁻⁸)
[<span style="color:#ff0500">  2/100</span>] │ 9.507e-01 <span style="color:#ff6c00">2.02×10⁻² </span>(10⁻⁸)
[<span style="color:#ff0a00">  3/100</span>] │ 9.507e-01 <span style="color:#ff6a00">2.17×10⁻² </span>(10⁻⁸)
[<span style="color:#ff0f00">  4/100</span>] │ 9.262e-01 <span style="color:#ff5200">5.24×10⁻² </span>(10⁻⁸)
[<span style="color:#ff1500">  5/100</span>] │ 8.292e-01 <span style="color:#ff5700">4.26×10⁻² </span>(10⁻⁸)
[<span style="color:#ff1a00">  6/100</span>] │ 8.292e-01 <span style="color:#ff5700">4.27×10⁻² </span>(10⁻⁸)
[<span style="color:#ff1f00">  7/100</span>] │ 8.139e-01 <span style="color:#ff6000">3.11×10⁻² </span>(10⁻⁸)
[<span style="color:#ff2400">  8/100</span>] │ 7.570e-01 <span style="color:#ff5f00">3.22×10⁻² </span>(10⁻⁸)
[<span style="color:#ff2900">  9/100</span>] │ 7.383e-01 <span style="color:#ff6700">2.42×10⁻² </span>(10⁻⁸)
[<span style="color:#ff2e00"> 10/100</span>] │ 6.989e-01 <span style="color:#ff6700">2.43×10⁻² </span>(10⁻⁸)
[<span style="color:#ff3400"> 11/100</span>] │ 6.800e-01 <span style="color:#ff6b00">2.12×10⁻² </span>(10⁻⁸)
[<span style="color:#ff3900"> 12/100</span>] │ 6.475e-01 <span style="color:#ff6f00">1.81×10⁻² </span>(10⁻⁸)
[<span style="color:#ff3e00"> 13/100</span>] │ 6.377e-01 <span style="color:#ff6a00">2.15×10⁻² </span>(10⁻⁸)
[<span style="color:#ff4300"> 14/100</span>] │ 5.978e-01 <span style="color:#ff7200">1.65×10⁻² </span>(10⁻⁸)
[<span style="color:#ff4800"> 15/100</span>] │ 5.978e-01 <span style="color:#ff6300">2.78×10⁻² </span>(10⁻⁸)
[<span style="color:#ff4d00"> 16/100</span>] │ 5.476e-01 <span style="color:#ff6700">2.43×10⁻² </span>(10⁻⁸)
[<span style="color:#ff5200"> 17/100</span>] │ 5.449e-01 <span style="color:#ff7000">1.75×10⁻² </span>(10⁻⁸)
[<span style="color:#ff5800"> 18/100</span>] │ 5.091e-01 <span style="color:#ff7500">1.47×10⁻² </span>(10⁻⁸)
[<span style="color:#ff5d00"> 19/100</span>] │ 5.091e-01 <span style="color:#ff6200">2.93×10⁻² </span>(10⁻⁸)
[<span style="color:#ff6200"> 20/100</span>] │ 4.564e-01 <span style="color:#ff6700">2.39×10⁻² </span>(10⁻⁸)
[<span style="color:#ff6700"> 21/100</span>] │ 4.564e-01 <span style="color:#ff5700">4.39×10⁻² </span>(10⁻⁸)
[<span style="color:#ff6c00"> 22/100</span>] │ 3.654e-01 <span style="color:#ff5a00">3.91×10⁻² </span>(10⁻⁸)
[<span style="color:#ff7100"> 23/100</span>] │ 3.654e-01 <span style="color:#ff5c00">3.66×10⁻² </span>(10⁻⁸)
[<span style="color:#ff7600"> 24/100</span>] │ 2.994e-01 <span style="color:#ff6300">2.79×10⁻² </span>(10⁻⁸)
[<span style="color:#ff7c00"> 25/100</span>] │ 2.994e-01 <span style="color:#ff5c00">3.62×10⁻² </span>(10⁻⁸)
[<span style="color:#ff8100"> 26/100</span>] │ 2.598e-01 <span style="color:#ff6100">2.98×10⁻² </span>(10⁻⁸)
[<span style="color:#ff8600"> 27/100</span>] │ 2.266e-01 <span style="color:#ff5400">4.85×10⁻² </span>(10⁻⁸)
[<span style="color:#ff8b00"> 28/100</span>] │ 1.445e-01 <span style="color:#ff5c00">3.58×10⁻² </span>(10⁻⁸)
[<span style="color:#ff9000"> 29/100</span>] │ 1.445e-01 <span style="color:#ff6100">2.98×10⁻² </span>(10⁻⁸)
[<span style="color:#ff9500"> 30/100</span>] │ 1.445e-01 <span style="color:#ff6700">2.45×10⁻² </span>(10⁻⁸)
[<span style="color:#ff9b00"> 31/100</span>] │ 9.866e-02 <span style="color:#ff6e00">1.91×10⁻² </span>(10⁻⁸)
[<span style="color:#ffa000"> 32/100</span>] │ 9.866e-02 <span style="color:#ff6500">2.64×10⁻² </span>(10⁻⁸)
[<span style="color:#ffa500"> 33/100</span>] │ 6.483e-02 <span style="color:#ff7300">1.58×10⁻² </span>(10⁻⁸)
[<span style="color:#ffaa00"> 34/100</span>] │ 6.483e-02 <span style="color:#ff6f00">1.84×10⁻² </span>(10⁻⁸)
[<span style="color:#ffaf00"> 35/100</span>] │ 5.485e-02 <span style="color:#ff8b00">6.61×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffb400"> 36/100</span>] │ 4.880e-02 <span style="color:#ff6e00">1.88×10⁻² </span>(10⁻⁸)
[<span style="color:#ffb900"> 37/100</span>] │ 1.220e-02 <span style="color:#ff7400">1.49×10⁻² </span>(10⁻⁸)
[<span style="color:#ffbf00"> 38/100</span>] │ 1.220e-02 <span style="color:#ff8600">7.78×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffc400"> 39/100</span>] │ 1.220e-02 <span style="color:#ff8b00">6.49×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffc900"> 40/100</span>] │ 5.976e-03 <span style="color:#ffa400">2.70×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffce00"> 41/100</span>] │ 5.976e-03 <span style="color:#ff9d00">3.46×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffd300"> 42/100</span>] │ 2.624e-03 <span style="color:#ffb400">1.52×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffd800"> 43/100</span>] │ 2.624e-03 <span style="color:#ffb700">1.34×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffde00"> 44/100</span>] │ 2.624e-03 <span style="color:#ffba00">1.23×10⁻³ </span>(10⁻⁸)
[<span style="color:#ffe300"> 45/100</span>] │ 3.583e-04 <span style="color:#ffc000">9.66×10⁻⁴ </span>(10⁻⁸)
[<span style="color:#ffe800"> 46/100</span>] │ 3.583e-04 <span style="color:#ffdc00">3.54×10⁻⁴ </span>(10⁻⁸)
[<span style="color:#ffed00"> 47/100</span>] │ 4.827e-05 <span style="color:#fff800">1.27×10⁻⁴ </span>(10⁻⁸)
[<span style="color:#fff200"> 48/100</span>] │ 4.827e-05 <span style="color:#efff00">5.66×10⁻⁵ </span>(10⁻⁸)
[<span style="color:#fff700"> 49/100</span>] │ 4.827e-05 <span style="color:#caff00">1.50×10⁻⁵ </span>(10⁻⁸)
[<span style="color:#fffc00"> 50/100</span>] │ 3.590e-05 <span style="color:#c9ff00">1.45×10⁻⁵ </span>(10⁻⁸)
[<span style="color:#fcff00"> 51/100</span>] │ 1.332e-05 <span style="color:#c9ff00">1.42×10⁻⁵ </span>(10⁻⁸)
[<span style="color:#f7ff00"> 52/100</span>] │ 1.565e-06 <span style="color:#acff00">4.92×10⁻⁶ </span>(10⁻⁸)
[<span style="color:#f2ff00"> 53/100</span>] │ 1.565e-06 <span style="color:#a2ff00">3.46×10⁻⁶ </span>(10⁻⁸)
[<span style="color:#edff00"> 54/100</span>] │ 1.565e-06 <span style="color:#7dff00">9.10×10⁻⁷ </span>(10⁻⁸)
[<span style="color:#e8ff00"> 55/100</span>] │ 1.565e-06 <span style="color:#75ff00">6.87×10⁻⁷ </span>(10⁻⁸)
[<span style="color:#e3ff00"> 56/100</span>] │ 4.966e-07 <span style="color:#70ff00">5.78×10⁻⁷ </span>(10⁻⁸)
[<span style="color:#deff00"> 57/100</span>] │ 2.273e-07 <span style="color:#47ff00">1.31×10⁻⁷ </span>(10⁻⁸)
[<span style="color:#d8ff00"> 58/100</span>] │ 2.120e-07 <span style="color:#36ff00">7.11×10⁻⁸ </span>(10⁻⁸)
[<span style="color:#d3ff00"> 59/100</span>] │ 6.942e-08 <span style="color:#3aff00">8.18×10⁻⁸ </span>(10⁻⁸)
[<span style="color:#ceff00"> 60/100</span>] │ 1.876e-08 <span style="color:#15ff00">2.13×10⁻⁸ </span>(10⁻⁸)
[<span style="color:#c9ff00"> 61/100</span>] │ 1.876e-08 <span style="color:#00ff00">9.27×10⁻⁹ </span>(10⁻⁸)
 * Status: success

 * Candidate solution
    Minimizer: [1.00e+00, 1.00e+00]
    Minimum:   3.525527e-09

 * Found with
    Algorithm:     Nelder-Mead
    Initial Point: [0.00e+00, 0.00e+00]

 * Convergence measures
    √(Σ(yᵢ-ȳ)²)/n ≤ 1.0e-08

 * Work counters
    Seconds run:   0  (vs limit Inf)
    Iterations:    60
    f(x) calls:    118
</div>
```


# Reference

```@docs
SolverTrace
SolverTrace(num_steps::Int,
            column::TraceColumn = CurrentStep(num_steps),
            columns::TraceColumn...;
            io::IO=stdout,
            num_printouts::Integer=min(num_steps,10),
            progress_meter::Bool=true,
            callbacks=(),
            print_interval = num_printouts > num_steps ? 1 : num_steps÷num_printouts,
            kwargs...)
print_header
SolverTraces.next!
```
