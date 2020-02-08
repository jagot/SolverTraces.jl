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
<div class="repl">
<u>           Performance   Tolerance       </u><br/>[<span style="color:#ff0000"> 1/20</span>] │  970.904 kHz │ <span style="color:#ff0000">1.00×10⁰  </span>(10⁻³)<br/>[<span style="color:#ff1b00"> 2/20</span>] │  436.679 kHz │ <span style="color:#ff1b00">6.95×10⁻¹ </span>(10⁻³)<br/>[<span style="color:#ff5100"> 4/20</span>] │  672.164 kHz │ <span style="color:#ff5100">3.36×10⁻¹ </span>(10⁻³)<br/>[<span style="color:#ff8600"> 6/20</span>] │  892.722 kHz │ <span style="color:#ff8600">1.62×10⁻¹ </span>(10⁻³)<br/>[<span style="color:#ffbc00"> 8/20</span>] │    1.074 MHz │ <span style="color:#ffbc00">7.85×10⁻² </span>(10⁻³)<br/>[<span style="color:#fff200">10/20</span>] │    1.168 MHz │ <span style="color:#fff200">3.79×10⁻² </span>(10⁻³)<br/>[<span style="color:#d7ff00">12/20</span>] │    1.207 MHz │ <span style="color:#d7ff00">1.83×10⁻² </span>(10⁻³)<br/>[<span style="color:#a1ff00">14/20</span>] │    1.303 MHz │ <span style="color:#a1ff00">8.86×10⁻³ </span>(10⁻³)<br/>[<span style="color:#6bff00">16/20</span>] │    1.431 MHz │ <span style="color:#6bff00">4.28×10⁻³ </span>(10⁻³)<br/>[<span style="color:#36ff00">18/20</span>] │    1.561 MHz │ <span style="color:#36ff00">2.07×10⁻³ </span>(10⁻³)<br/>[<span style="color:#00ff00">20/20</span>] │    1.685 MHz │ <span style="color:#00ff00">1.00×10⁻³ </span>(10⁻³)<br/>
</div>
```

## Reference

```@docs
SolverTrace
print_header
SolverTraces.next!
```
