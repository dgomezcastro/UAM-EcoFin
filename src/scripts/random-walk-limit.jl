using Random, Plots, LaTeXStrings, ColorSchemes
Random.seed!(1234) # Para mejorar la reproducibilidad
function randomwalk(N)
    x = zeros(N + 1)
    for n = 2:N+1
        p = rand()
        if p > 0.5
            x[n] = x[n-1] + 1
        elseif p < 0.5
            x[n] = x[n-1] - 1
        else
            x[n] = x[n-1]
        end
    end
    return x
end;
p3 = plot(
    legend=:outerright,
    # title="Paseos aleatorios rescalados", 
    xlabel=L"t", ylabel=L"x")
log2hs = -2:-1:-9
M = length(log2hs)
colors = cgrad(:viridis)
for (i, log2h) = enumerate(log2hs)
    h = 2.0^log2h
    t = [0.0:h^2:1.0;]
    N = length(t)
    color = get(colors, i / M)
    p3 = plot!(t, h * randomwalk(N - 1), label=latexstring("h=2^{$log2h}"), color=color)
end
plot(p3)

savefig("src/figures/random-walk-limit.pdf")