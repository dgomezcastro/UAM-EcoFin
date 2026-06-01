using YFinance, DataFrames
op = get_Options("^SPX")
DataFrame(op["calls"])