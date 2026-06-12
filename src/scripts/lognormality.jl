using YFinance, DataFrames, Plots, LaTeXStrings

prices = get_prices("^SPX", range="max", interval="1wk")

t = prices["timestamp"]
St = prices["close"]
p1 = plot(t, St,
    label="",
    title="Price",
    ylabel=L"S_t",
    xtickfont=font(6),
)

logSt = log.(St)
p2 = plot(t, logSt, label="", ylabel=L"\log S_t", title="Log-price", xtickfont=font(6),
)
# savefig("logprices.pdf")

ΔlogSt = logSt[2:end] - logSt[1:end-1]
p3 = plot(t[1:end-1], ΔlogSt,
    label="",
    ylabel=L"\log S_{t+Δt} - \log S_t",
    title="Log-price increments",
    xtickfont=font(6),
    xlabel="Dates",
)

p4 = histogram(ΔlogSt,
    normalize=:pdf,
    xlabel=L"\log(S_{t+\Delta t} - \log S_t)",
    label="Data",
    title="Normalized histogram",
    legend=:topleft,
)

N = length(St)
μ̂ = 1 / N * sum(ΔlogSt)
V̂ = 1 / (N - 1) * sum((ΔlogSt .- μ̂) .^ 2)
σ̂ = sqrt(V̂)

f(x) = exp(-((x - μ̂) / σ̂)^2 / 2) / (sqrt(2 * π) * σ̂)
plot!(p4, f, label="Normal fit", linewidth=3)

plot(p1, p2, p3, p4, plot_title=latexstring("SPX, \$\\Delta t = 1\$ week"))

savefig("../figures/lognormality.pdf")
