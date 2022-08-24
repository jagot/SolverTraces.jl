var documenterSearchIndex = {"docs":
[{"location":"columns/#Solver-Trace-Columns","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"","category":"section"},{"location":"columns/","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"TraceColumn","category":"page"},{"location":"columns/#SolverTraces.TraceColumn","page":"Solver Trace Columns","title":"SolverTraces.TraceColumn","text":"TraceColumn\n\nBase type for all columns that can appear in a SolverTrace. Each subtype is expected to have a property named fmt containing a formatting string, and to be callable with the current step number as argument, returning the necessary values to render the formatting string, alternatively overload Formatting.format(c::C, i::Integer) where {C<:TraceColumn}.\n\n\n\n\n\n","category":"type"},{"location":"columns/#CurrentStep","page":"Solver Trace Columns","title":"CurrentStep","text":"","category":"section"},{"location":"columns/","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"CurrentStep\nCurrentStep(num_steps::Integer;\n            lc::LinearColorant=LinearColorant(1, num_steps, red_green_scale()),\n            header::String=repeat(\" \", 2length(digits(num_steps))+3))","category":"page"},{"location":"columns/#SolverTraces.CurrentStep","page":"Solver Trace Columns","title":"SolverTraces.CurrentStep","text":"CurrentStep(num_steps, fmt, lc, header)\n\nTrace column display the current step and total number of iteration, e.g. [ 4/10], with the figures colored according to progress made.\n\n\n\n\n\n","category":"type"},{"location":"columns/#SolverTraces.CurrentStep-Tuple{Integer}","page":"Solver Trace Columns","title":"SolverTraces.CurrentStep","text":"CurrentStep(num_step[; lc, header])\n\nCreate a current step trace column for num_step iterations. The default color scale goes from red to green, and the default header is blank.\n\n\n\n\n\n","category":"method"},{"location":"columns/#Performance","page":"Solver Trace Columns","title":"Performance","text":"","category":"section"},{"location":"columns/","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"Performance\nPerformance(load::Number, load_name::String=\"Performance\")\nSolverTraces.shift_prefix\nSolverTraces.SI_prefix_convert","category":"page"},{"location":"columns/#SolverTraces.Performance","page":"Solver Trace Columns","title":"SolverTraces.Performance","text":"Performance(load, header, t₀, fmt)\n\nThis trace column can be used to indicate the performance of a calculation, i.e. how many units (grid points, particles, &c) can the algorithm handle per second. The number is shifted to the appropriate order of magnitude, changing the SI prefix to e.g. kHz, MHz, &c.\n\n\n\n\n\n","category":"type"},{"location":"columns/#SolverTraces.Performance-2","page":"Solver Trace Columns","title":"SolverTraces.Performance","text":"Performance(load[, load_name=\"Performance\"])\n\nConstructe a Performance trace column, for load number of units per iteration.\n\n\n\n\n\n","category":"type"},{"location":"columns/#SolverTraces.shift_prefix","page":"Solver Trace Columns","title":"SolverTraces.shift_prefix","text":"shift_prefix(u, e)\n\nShift the SI prefix of the unit u by e orders of magnitude (which needs to be a multiple of 3).\n\n\n\n\n\n","category":"function"},{"location":"columns/#SolverTraces.SI_prefix_convert","page":"Solver Trace Columns","title":"SolverTraces.SI_prefix_convert","text":"SI_prefix_convert(q)\n\nShift the SI prefix of the quantity q such that no zeros appear before the decimal point, and at most three figures do. Note that this conversion is not necessarily numerically accurate, it is mostly intended for display purposes.\n\nExamples\n\njulia> SolverTraces.SI_prefix_convert(1.0u\"nm\")\n1.0 nm\n\njulia> SolverTraces.SI_prefix_convert(0.10u\"nm\")\n100.0 pm\n\njulia> SolverTraces.SI_prefix_convert(100.0u\"nm\")\n100.0 nm\n\njulia> SolverTraces.SI_prefix_convert(999.0u\"nm\")\n999.0 nm\n\n\n\n\n\n","category":"function"},{"location":"columns/#ScalarColumn","page":"Solver Trace Columns","title":"ScalarColumn","text":"","category":"section"},{"location":"columns/","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"ScalarColumn\nScalarColumn(n::Function, header::String, ::Type{R}, signed=false) where {R<:Real}\nScalarColumn(n::R, header::String, signed=false) where {R<:Real}","category":"page"},{"location":"columns/#SolverTraces.ScalarColumn","page":"Solver Trace Columns","title":"SolverTraces.ScalarColumn","text":"ScalarColumn(fmt, header, n)\n\nTrace column for any kind of scalar, returned by the callback function n. Alternatively, n can be a scalar set manually by the user.\n\n\n\n\n\n","category":"type"},{"location":"columns/#SolverTraces.ScalarColumn-Union{Tuple{R}, Tuple{Function, String, Type{R}}, Tuple{Function, String, Type{R}, Any}} where R<:Real","page":"Solver Trace Columns","title":"SolverTraces.ScalarColumn","text":"ScalarColumn(n, header, ::Type{R}[, signed=false]) where {R<:Real}\n\nConstruct a ScalarColumn for the callback function n, with a format automatically generated depending on R is an integer or not, and whether it can be signed.\n\n\n\n\n\n","category":"method"},{"location":"columns/#SolverTraces.ScalarColumn-Union{Tuple{R}, Tuple{R, String}, Tuple{R, String, Any}} where R<:Real","page":"Solver Trace Columns","title":"SolverTraces.ScalarColumn","text":"ScalarColumn(n::R, header[, signed=false]) where {R<:Real}\n\nConstruct a ScalarColumn for the scalar value n, with a format automatically generated depending on R is an integer or not, and whether it can be signed.\n\n\n\n\n\n","category":"method"},{"location":"columns/#Tolerance","page":"Solver Trace Columns","title":"Tolerance","text":"","category":"section"},{"location":"columns/","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"Tolerance\nTolerance(target::T,header=\"Tolerance\";print_target::Bool=true) where T\nSolverTraces.base_exp","category":"page"},{"location":"columns/#SolverTraces.Tolerance","page":"Solver Trace Columns","title":"SolverTraces.Tolerance","text":"Tolerance(target, current, fmt, tol_fmt, lc, header)\n\nColumn displaying the progress of the algorithm towards a set target. At each iteration, the current value has to be updated.\n\n\n\n\n\n","category":"type"},{"location":"columns/#SolverTraces.Tolerance-Union{Tuple{T}, Tuple{T, Any}} where T","page":"Solver Trace Columns","title":"SolverTraces.Tolerance","text":" Tolerance(target[, header; print_target])\n\nConstruct a new Tolerance column with a set target.\n\n\n\n\n\n","category":"method"},{"location":"columns/#SolverTraces.base_exp","page":"Solver Trace Columns","title":"SolverTraces.base_exp","text":"base_exp(v)\n\nConvert the float v into a tuple of base and exponent in base-10.\n\nExamples\n\njulia> SolverTraces.base_exp(-3.5e2)\n(-3.5000000000000004, 2)\n\n\n\n\n\n","category":"function"},{"location":"columns/#ColumnSeparator","page":"Solver Trace Columns","title":"ColumnSeparator","text":"","category":"section"},{"location":"columns/","page":"Solver Trace Columns","title":"Solver Trace Columns","text":"ColumnSeparator","category":"page"},{"location":"columns/#SolverTraces.ColumnSeparator","page":"Solver Trace Columns","title":"SolverTraces.ColumnSeparator","text":"ColumnSeparator(fmt, header)\n\nSimple separator between columns, that by default simply prints a pipe.\n\n\n\n\n\n","category":"type"},{"location":"colors/#Colors","page":"Colors","title":"Colors","text":"","category":"section"},{"location":"colors/#Linear-interpolation","page":"Colors","title":"Linear interpolation","text":"","category":"section"},{"location":"colors/","page":"Colors","title":"Colors","text":"SolverTraces.safe_lerp\nSolverTraces.ilerp\nSolverTraces.sat_ilerp","category":"page"},{"location":"colors/#SolverTraces.safe_lerp","page":"Colors","title":"SolverTraces.safe_lerp","text":"safe_lerp(a, b, t)\n\nSafe implementation of linear interpolation (lerp) between a and b, where t is the linear parameter. If isnan(t), a is returned, and if t is infinite, a or b is returned, depending on the sign.\n\n\n\n\n\n","category":"function"},{"location":"colors/#SolverTraces.ilerp","page":"Colors","title":"SolverTraces.ilerp","text":"ilerp(a, b, t)\n\nLinear interpolation in integer steps.\n\n\n\n\n\n","category":"function"},{"location":"colors/#SolverTraces.sat_ilerp","page":"Colors","title":"SolverTraces.sat_ilerp","text":"sat_ilerp(a, b, t)\n\nSaturated linear interpolation in integer steps, clamped to the range 0:255 (the available colour space).\n\n\n\n\n\n","category":"function"},{"location":"colors/#Color-scales","page":"Colors","title":"Color scales","text":"","category":"section"},{"location":"colors/","page":"Colors","title":"Colors","text":"LinearColorant\nSolverTraces.red_green_scale","category":"page"},{"location":"colors/#SolverTraces.LinearColorant","page":"Colors","title":"SolverTraces.LinearColorant","text":"LinearColorant(a, b, colors)\n\nHelper structure to linearly interpolate between the possible values in colors, where the scalar value a corresponds to the first value and b to the last. If colors is a tuple of two triples, a continuous interpolation between the endpoints will be the result, whereas if it is a vector of Crayons, nearest neighbour interpolation will be performed instead.\n\n\n\n\n\n","category":"type"},{"location":"colors/#SolverTraces.red_green_scale","page":"Colors","title":"SolverTraces.red_green_scale","text":"red_green_scale()\n\nReturn a red–green colour scale; on Windows (with only 16 colours available), this is simply red, yellow, green, on other systems, the end-points are returned instead, for use with sat_ilerp.\n\n\n\n\n\n","category":"function"},{"location":"#SolverTraces.jl","page":"Home","title":"SolverTraces.jl","text":"","category":"section"},{"location":"#Usage-example","page":"Home","title":"Usage example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Using SolverTraces.jl is very easy:","category":"page"},{"location":"","page":"Home","title":"Home","text":"N = 20 # Number of iterations\n\ntol = Tolerance(1e-3)\ntols = 10 .^ range(0, stop=-3, length=N)\n\ntrace = SolverTrace(N, CurrentStep(N),\n                    ColumnSeparator(),\n                    Performance(100), # Could be number of points processed each iteration\n                    ColumnSeparator(),\n                    tol)\nprint_header(trace)\nfor i = 1:N\n    # Do work\n    # ...\n    # Set which tolerance was achieved in this iteration:\n    tol.current = tols[i]\n\n    SolverTraces.next!(trace)\nend","category":"page"},{"location":"","page":"Home","title":"Home","text":"which will give output similar to this:","category":"page"},{"location":"","page":"Home","title":"Home","text":"<div class=\"repl\"><u>           Performance   Tolerance       </u>\n[<span style=\"color:#ff0000\"> 1/20</span>] │  970.904 kHz │ <span style=\"color:#ff0000\">1.00×10⁰  </span>(10⁻³)\n[<span style=\"color:#ff1b00\"> 2/20</span>] │  436.679 kHz │ <span style=\"color:#ff1b00\">6.95×10⁻¹ </span>(10⁻³)\n[<span style=\"color:#ff5100\"> 4/20</span>] │  672.164 kHz │ <span style=\"color:#ff5100\">3.36×10⁻¹ </span>(10⁻³)\n[<span style=\"color:#ff8600\"> 6/20</span>] │  892.722 kHz │ <span style=\"color:#ff8600\">1.62×10⁻¹ </span>(10⁻³)\n[<span style=\"color:#ffbc00\"> 8/20</span>] │    1.074 MHz │ <span style=\"color:#ffbc00\">7.85×10⁻² </span>(10⁻³)\n[<span style=\"color:#fff200\">10/20</span>] │    1.168 MHz │ <span style=\"color:#fff200\">3.79×10⁻² </span>(10⁻³)\n[<span style=\"color:#d7ff00\">12/20</span>] │    1.207 MHz │ <span style=\"color:#d7ff00\">1.83×10⁻² </span>(10⁻³)\n[<span style=\"color:#a1ff00\">14/20</span>] │    1.303 MHz │ <span style=\"color:#a1ff00\">8.86×10⁻³ </span>(10⁻³)\n[<span style=\"color:#6bff00\">16/20</span>] │    1.431 MHz │ <span style=\"color:#6bff00\">4.28×10⁻³ </span>(10⁻³)\n[<span style=\"color:#36ff00\">18/20</span>] │    1.561 MHz │ <span style=\"color:#36ff00\">2.07×10⁻³ </span>(10⁻³)\n[<span style=\"color:#00ff00\">20/20</span>] │    1.685 MHz │ <span style=\"color:#00ff00\">1.00×10⁻³ </span>(10⁻³)\n</div>","category":"page"},{"location":"#Optim.jl","page":"Home","title":"Optim.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"It is similarly very easy to add colour to your Optim.jl runs:","category":"page"},{"location":"","page":"Home","title":"Home","text":"f(x) = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2\nx0 = [0.0, 0.0]\n\nmax_iter = 100\ntol = 1e-8\n\nvalue = ScalarColumn(Inf, \"Value\")\ntolerance = Tolerance(tol, \"|∇|\")\n\ntrace = SolverTrace(max_iter,\n                    CurrentStep(max_iter), ColumnSeparator(), value, tolerance,\n                    print_interval=1)\ntrace_callback = opt_state -> begin\n    tolerance.current = opt_state.g_norm\n    value.n = opt_state.value\n    SolverTraces.next!(trace)\n    false\nend\noptions = Optim.Options(iterations=max_iter, g_tol=tol,\n                        callback=trace_callback)\nprint_header(trace)\noptimize(f, x0, options)","category":"page"},{"location":"","page":"Home","title":"Home","text":"which will result in something similar to","category":"page"},{"location":"","page":"Home","title":"Home","text":"<div class=\"repl\"><u>                Value |∇|             </u>\n[<span style=\"color:#ff0000\">  1/100</span>] │ 9.507e-01 <span style=\"color:#ff5500\">4.58×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff0500\">  2/100</span>] │ 9.507e-01 <span style=\"color:#ff6c00\">2.02×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff0a00\">  3/100</span>] │ 9.507e-01 <span style=\"color:#ff6a00\">2.17×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff0f00\">  4/100</span>] │ 9.262e-01 <span style=\"color:#ff5200\">5.24×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff1500\">  5/100</span>] │ 8.292e-01 <span style=\"color:#ff5700\">4.26×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff1a00\">  6/100</span>] │ 8.292e-01 <span style=\"color:#ff5700\">4.27×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff1f00\">  7/100</span>] │ 8.139e-01 <span style=\"color:#ff6000\">3.11×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff2400\">  8/100</span>] │ 7.570e-01 <span style=\"color:#ff5f00\">3.22×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff2900\">  9/100</span>] │ 7.383e-01 <span style=\"color:#ff6700\">2.42×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff2e00\"> 10/100</span>] │ 6.989e-01 <span style=\"color:#ff6700\">2.43×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff3400\"> 11/100</span>] │ 6.800e-01 <span style=\"color:#ff6b00\">2.12×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff3900\"> 12/100</span>] │ 6.475e-01 <span style=\"color:#ff6f00\">1.81×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff3e00\"> 13/100</span>] │ 6.377e-01 <span style=\"color:#ff6a00\">2.15×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff4300\"> 14/100</span>] │ 5.978e-01 <span style=\"color:#ff7200\">1.65×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff4800\"> 15/100</span>] │ 5.978e-01 <span style=\"color:#ff6300\">2.78×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff4d00\"> 16/100</span>] │ 5.476e-01 <span style=\"color:#ff6700\">2.43×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff5200\"> 17/100</span>] │ 5.449e-01 <span style=\"color:#ff7000\">1.75×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff5800\"> 18/100</span>] │ 5.091e-01 <span style=\"color:#ff7500\">1.47×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff5d00\"> 19/100</span>] │ 5.091e-01 <span style=\"color:#ff6200\">2.93×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff6200\"> 20/100</span>] │ 4.564e-01 <span style=\"color:#ff6700\">2.39×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff6700\"> 21/100</span>] │ 4.564e-01 <span style=\"color:#ff5700\">4.39×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff6c00\"> 22/100</span>] │ 3.654e-01 <span style=\"color:#ff5a00\">3.91×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff7100\"> 23/100</span>] │ 3.654e-01 <span style=\"color:#ff5c00\">3.66×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff7600\"> 24/100</span>] │ 2.994e-01 <span style=\"color:#ff6300\">2.79×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff7c00\"> 25/100</span>] │ 2.994e-01 <span style=\"color:#ff5c00\">3.62×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff8100\"> 26/100</span>] │ 2.598e-01 <span style=\"color:#ff6100\">2.98×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff8600\"> 27/100</span>] │ 2.266e-01 <span style=\"color:#ff5400\">4.85×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff8b00\"> 28/100</span>] │ 1.445e-01 <span style=\"color:#ff5c00\">3.58×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff9000\"> 29/100</span>] │ 1.445e-01 <span style=\"color:#ff6100\">2.98×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff9500\"> 30/100</span>] │ 1.445e-01 <span style=\"color:#ff6700\">2.45×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ff9b00\"> 31/100</span>] │ 9.866e-02 <span style=\"color:#ff6e00\">1.91×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ffa000\"> 32/100</span>] │ 9.866e-02 <span style=\"color:#ff6500\">2.64×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ffa500\"> 33/100</span>] │ 6.483e-02 <span style=\"color:#ff7300\">1.58×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ffaa00\"> 34/100</span>] │ 6.483e-02 <span style=\"color:#ff6f00\">1.84×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ffaf00\"> 35/100</span>] │ 5.485e-02 <span style=\"color:#ff8b00\">6.61×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffb400\"> 36/100</span>] │ 4.880e-02 <span style=\"color:#ff6e00\">1.88×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ffb900\"> 37/100</span>] │ 1.220e-02 <span style=\"color:#ff7400\">1.49×10⁻² </span>(10⁻⁸)\n[<span style=\"color:#ffbf00\"> 38/100</span>] │ 1.220e-02 <span style=\"color:#ff8600\">7.78×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffc400\"> 39/100</span>] │ 1.220e-02 <span style=\"color:#ff8b00\">6.49×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffc900\"> 40/100</span>] │ 5.976e-03 <span style=\"color:#ffa400\">2.70×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffce00\"> 41/100</span>] │ 5.976e-03 <span style=\"color:#ff9d00\">3.46×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffd300\"> 42/100</span>] │ 2.624e-03 <span style=\"color:#ffb400\">1.52×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffd800\"> 43/100</span>] │ 2.624e-03 <span style=\"color:#ffb700\">1.34×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffde00\"> 44/100</span>] │ 2.624e-03 <span style=\"color:#ffba00\">1.23×10⁻³ </span>(10⁻⁸)\n[<span style=\"color:#ffe300\"> 45/100</span>] │ 3.583e-04 <span style=\"color:#ffc000\">9.66×10⁻⁴ </span>(10⁻⁸)\n[<span style=\"color:#ffe800\"> 46/100</span>] │ 3.583e-04 <span style=\"color:#ffdc00\">3.54×10⁻⁴ </span>(10⁻⁸)\n[<span style=\"color:#ffed00\"> 47/100</span>] │ 4.827e-05 <span style=\"color:#fff800\">1.27×10⁻⁴ </span>(10⁻⁸)\n[<span style=\"color:#fff200\"> 48/100</span>] │ 4.827e-05 <span style=\"color:#efff00\">5.66×10⁻⁵ </span>(10⁻⁸)\n[<span style=\"color:#fff700\"> 49/100</span>] │ 4.827e-05 <span style=\"color:#caff00\">1.50×10⁻⁵ </span>(10⁻⁸)\n[<span style=\"color:#fffc00\"> 50/100</span>] │ 3.590e-05 <span style=\"color:#c9ff00\">1.45×10⁻⁵ </span>(10⁻⁸)\n[<span style=\"color:#fcff00\"> 51/100</span>] │ 1.332e-05 <span style=\"color:#c9ff00\">1.42×10⁻⁵ </span>(10⁻⁸)\n[<span style=\"color:#f7ff00\"> 52/100</span>] │ 1.565e-06 <span style=\"color:#acff00\">4.92×10⁻⁶ </span>(10⁻⁸)\n[<span style=\"color:#f2ff00\"> 53/100</span>] │ 1.565e-06 <span style=\"color:#a2ff00\">3.46×10⁻⁶ </span>(10⁻⁸)\n[<span style=\"color:#edff00\"> 54/100</span>] │ 1.565e-06 <span style=\"color:#7dff00\">9.10×10⁻⁷ </span>(10⁻⁸)\n[<span style=\"color:#e8ff00\"> 55/100</span>] │ 1.565e-06 <span style=\"color:#75ff00\">6.87×10⁻⁷ </span>(10⁻⁸)\n[<span style=\"color:#e3ff00\"> 56/100</span>] │ 4.966e-07 <span style=\"color:#70ff00\">5.78×10⁻⁷ </span>(10⁻⁸)\n[<span style=\"color:#deff00\"> 57/100</span>] │ 2.273e-07 <span style=\"color:#47ff00\">1.31×10⁻⁷ </span>(10⁻⁸)\n[<span style=\"color:#d8ff00\"> 58/100</span>] │ 2.120e-07 <span style=\"color:#36ff00\">7.11×10⁻⁸ </span>(10⁻⁸)\n[<span style=\"color:#d3ff00\"> 59/100</span>] │ 6.942e-08 <span style=\"color:#3aff00\">8.18×10⁻⁸ </span>(10⁻⁸)\n[<span style=\"color:#ceff00\"> 60/100</span>] │ 1.876e-08 <span style=\"color:#15ff00\">2.13×10⁻⁸ </span>(10⁻⁸)\n[<span style=\"color:#c9ff00\"> 61/100</span>] │ 1.876e-08 <span style=\"color:#00ff00\">9.27×10⁻⁹ </span>(10⁻⁸)\n * Status: success\n\n * Candidate solution\n    Minimizer: [1.00e+00, 1.00e+00]\n    Minimum:   3.525527e-09\n\n * Found with\n    Algorithm:     Nelder-Mead\n    Initial Point: [0.00e+00, 0.00e+00]\n\n * Convergence measures\n    √(Σ(yᵢ-ȳ)²)/n ≤ 1.0e-08\n\n * Work counters\n    Seconds run:   0  (vs limit Inf)\n    Iterations:    60\n    f(x) calls:    118\n</div>","category":"page"},{"location":"#Reference","page":"Home","title":"Reference","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"SolverTrace\nSolverTrace(num_steps::Int,\n            column::TraceColumn = CurrentStep(num_steps),\n            columns::TraceColumn...;\n            io::IO=stdout,\n            num_printouts::Integer=min(num_steps,10),\n            progress_meter::Bool=true,\n            callbacks=(),\n            print_interval = num_printouts > num_steps ? 1 : num_steps÷num_printouts,\n            kwargs...)\nprint_header\nSolverTraces.next!","category":"page"},{"location":"#SolverTraces.SolverTrace","page":"Home","title":"SolverTraces.SolverTrace","text":"SolverTrace(num_steps, i, print_interval, io, progress, columns, callbacks)\n\nRepresents a solver trace for num_steps iterations, i being the current one. Each time next! is called, i is incremented by one, and if a multiple of print_interval is reached, a line is printed in the trace. Optionally (default), a ProgressMeter.Progress is shown as well, providing progress information between solver trace printouts.\n\n\n\n\n\n","category":"type"},{"location":"#SolverTraces.SolverTrace-2","page":"Home","title":"SolverTraces.SolverTrace","text":"SolverTrace(num_steps[, column=CurrentStep(num_steps), columns...;\n                        io=stdout, num_printouts=10, progress_meter=true,\n                        print_interval, kwargs...])\n\nConstruct a SolverTrace for num_steps iterations, with the columns that are to appear in the solver trace. The solver trace is printed to io, num_printouts lines will appear; alternatively, the print_interval can be specified directly. Below the solver trace, a progressbar is displayed, unless !progress_meter. kwargs... are passed on to ProgressMeter.Progress.\n\n\n\n\n\n","category":"type"},{"location":"#SolverTraces.print_header","page":"Home","title":"SolverTraces.print_header","text":"print_header(s)\n\nPrint the associated header of the SolverTrace s.\n\n\n\n\n\n","category":"function"},{"location":"#SolverTraces.next!","page":"Home","title":"SolverTraces.next!","text":"next!(fun, s::SolverTrace; kwargs...)\n\nSignal to the SolverTrace s that the next iteration has been performed, increasing the internal counter s.i. If a multiple of s.print_interval is reached, a line in the solver trace is printed, formatting each and every trace column, the callback function fun is called, as well as all the registered callbacks.\n\nkwargs are passed on to ProgressMeter.next! to allow e.g. showvalues functionality.\n\n\n\n\n\n","category":"function"}]
}
