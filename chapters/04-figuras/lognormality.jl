using YFinance, DataFrames, Plots, LaTeXStrings

prices = get_prices("^SPX", range="max", interval="5d")

t = prices["timestamp"]
St = prices["close"]
plot(t, St, label=L"S_t")
savefig("prices.pdf")

logSt = log.(St)
plot(t, St, label=L"\log S_t")
savefig("logprices.pdf")

ΔlogSt = logSt[2:end] - logSt[1:end-1]
histogram(ΔlogSt,
    normalize=true,
    label=L"\log(S_{t+\Delta t} - \log S_t)",
    legend=:topleft,
    title=L"\Delta t = 5 \, days"
)

N = length(St)
μ̂ = 1 / N * sum(ΔlogSt)
V̂ = 1 / (N - 1) * sum((ΔlogSt .- μ̂) .^ 2)
σ̂ = sqrt(V̂)

f(x) = exp(-((x - μ̂) / σ̂)^2 / 2) / (sqrt(2 * π) * σ̂)
plot!(f, label="Gaussiana ajustada", linewidth=3)
savefig("histogram.pdf")
