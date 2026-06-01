using YFinance, DataFrames, Dates, Plots, LaTeXStrings
op = get_Options("^SPX", expiration_date=today() + Day(10))
calls = op["calls"]
DataFrame(calls)

duration = calls["expiration"] - calls["lastTradeDate"]

prices = get_prices("^SPX", range="15d", interval="5m")
N = length(calls["strike"])
price_at_lastTradeDate = zeros(N)
for i in eachindex(initial_prices)
    d = calls["lastTradeDate"][i]
    j = 1
    while d > prices["timestamp"][j] && j < N
        j += 1
    end
    price_at_lastTradeDate[i] = prices["close"][j]
end

scatter(calls["strike"] ./ price_at_lastTradeDate, duration, calls["impliedVolatility"], markersize=5, xlabel=L"K/S_0", ylabel=L"T", zlabel=L"\sigma_{BS}")