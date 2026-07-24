using CSV
using DataFrames
using Dates
using Downloads
using Plots, Plots.PlotMeasures


# Data sources
euribor_url = "https://data-api.ecb.europa.eu/service/data/FM/M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA?format=csvdata"
spain10y_url = "https://fred.stlouisfed.org/graph/fredgraph.csv?id=IRLTLT01ESM156N"

# Robust parsers for mixed input types (Date/String and Number/String)
to_month_date(x) = x isa Date ? x : Date(string(x), dateformat"yyyy-mm")
to_float_or_missing(x) = x isa Number ? Float64(x) : something(tryparse(Float64, string(x)), missing)

# Load Euribor 12M
eur = CSV.read(Downloads.download(euribor_url), DataFrame)
eur = select(eur, :TIME_PERIOD, :OBS_VALUE)
rename!(eur, :TIME_PERIOD => :DATE, :OBS_VALUE => :EURIBOR_12M)
eur.DATE = to_month_date.(eur.DATE)
eur.EURIBOR_12M = to_float_or_missing.(eur.EURIBOR_12M)

# Load Spain 10Y yield
es = CSV.read(Downloads.download(spain10y_url), DataFrame)
rename!(es, :observation_date => :DATE, Symbol("IRLTLT01ESM156N") => :SPAIN_10Y)
es.DATE = Date.(string.(es.DATE))
es.SPAIN_10Y = to_float_or_missing.(es.SPAIN_10Y)

# Merge and clean
df = innerjoin(eur, es, on=:DATE)
dropmissing!(df, [:EURIBOR_12M, :SPAIN_10Y])
sort!(df, :DATE)

# Build figure
p = plot(xlabel="Fecha",
    ylabel="%",
    legend=:topright,
    size=(800, 300),
    left_margin=5mm,
    bottom_margin=5mm,
    right_margin=3mm,
    top_margin=3mm,)

plot!(p, df.DATE, df.EURIBOR_12M,
    label="Euribor 12M",
    linewidth=2)

plot!(p, df.DATE, df.SPAIN_10Y, label="Spain 10Y Yield", linewidth=2)

# Save to PDF in current working directory
output_file = "src/figures/euribor-vs-bono.pdf"
savefig(p, output_file)