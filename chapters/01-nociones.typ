// LTeX: language=es

#import "../header/template.typ": *

= Nociones básicas de aritmética financiera

// Tipos de interés, capitalizaciones, préstamos, rentas.
// Rendimientos, tasa interna de rendimientos. Estructura temporal de tipos de interés, la curva cupón cero. Algunos
// cálculos actuariales.

== Tipos de interés

Un tipo de interés en una situación particular es la cantidad que el prestatario promete pagar al prestamista.
Esto incluye tipos hipotecarios, depositarios, y otros.
El tipo de interés aplicable depende del riesgo del crédito, es decir el riesgo de que el crédito no sea devuelto.

=== Algunos ejemplos

==== Tipos del Tesoro (_Treasury rates_)

Los del #link("https://home.treasury.gov")[_US Treasury_] o el Banco de España, en letras y bonos (_Treasury bills_ and _Treasury bonds_). Estos son los instrumentos usados por los Gobiernos para pedir dineros prestado en su propia moneda.
Se suele asumir que los gobiernos no llegará a impago (_default_), de manera que se asume que estos tipos de interés son libres de riesgo.

Volveremos sobre las letras y los bonos más abajo.
==== Tipos interbancarios

LIBOR es el acrónimo del _London Interbank Offered Rate_. Es un tipo de préstamo a corto plazo entre bancos, sin garantías. Se calculan a diario cada día laborable en 10 monedas y 15 periodos (desde 1 día hasta 1 año).

El euríbor (del inglés euribor), acrónimo de _Euro Interbank Offered Rate_ es un índice de referencia publicado diariamente que indica el tipo de interés promedio al que un gran número de bancos europeos dicen concederse préstamos a corto plazo entre ellos para prestárselo a terceros —particulares y empresas—.

=== Midiendo tipos de interés. Interés compuesto

Anunciar el tipo de interés como un 10% anual parece claro y nada ambiguo. Sin embargo, depende de cómo se mida. El habitual permitir dividir el tipo de composición.
Si el tipo de interés con $r = 10%$ se mide con composición anual (_annual compunding_) entonces $100€$ crecen como
$
  100€ times 1.1 = 110€.
$
Sin embargo, si hablamos de composición bi-anual (_semi-annual compounding_) entonces aplicamos $5%$ cada 6 meses. Tras $6$ meses tendremos $100€ times 1.05 = 110.25€$ y acabado el año
$
  100€ times 1.05 times 1.05€ = 110.25€
$
En general si lo hacemos en $n$ periodos tendremos
$
  100€ times (1 + 0.1/n)^n.
$
Vemos la siguiente tabla
// #table(
//   columns: (1fr, auto),
//   table.header([*Composición*], [*Valor de $100€$ a final de año*]),
//   Anual, hola,
// )

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: (left, right),
    table.header([*Frecuencia de composición*], [*Valor de $100€$ a final de año*]),
    [Anual $m=1$], [110.00€],
    [Semi-anual ($m=2$)], [110.25€],
    [Cuatrimestral ($m=4$)], [110.38€],
    [Mensual ($m=12$)], [110.47€],
    [Semanal ($m=52$)], [110.51€],
    [Diario ($m=365$)], [110.52€],
  ),
  caption: "Interés compuesto",
)
Jacob Bernouilli descubrió el número $e$, llamado número de Euler o de Napier, calculando límites en la fórmula de interés compuesto
$
  e := lim_(x -> oo) (1 + 1/x)^x.
$
Calculando el límite en la fórmula de interés compuesto obtenemos
$
  lim_(n -> oo) (1 + (r t)/n)^(n) & = lim_(n -> oo) [(1 + (r t)/n)^(n/(r t))]^(r t)
                                    = [lim_(x -> oo) (1 + 1/x)^(x)]^(r t) \
                                  & = e^(r t)
$
Esta representación nos será de gran utilidad.


=== Tipo de interés nominal: TIN

#quote(block: true, attribution: "Wikipedia")[
  El tipo de interés nominal (o, por sus siglas, TIN), conocido también como interés nominal, es el porcentaje que se agregará al capital cedido como remuneración durante un periodo determinado (no necesariamente un año). El TIN no tiene en cuenta otros gastos de la operación como pueden ser las comisiones o las vinculaciones que conlleva el producto.

  El interés dado un TIN de $r_i$ y un capital $C$ se calcula:
  $
    i=C times r_i
  $
  A partir de una TIN puede calcularse el interés anual ($r_a$):
  $
    r_a=(1+r_i)^(1/n)-1
  $
  siendo $n$ el número de años o una fracción si el periodo es menor.
]
Como veremos más abajo, en hipotecas es habitual utilizar fracciones sencillas del $"TIN"_"anual"$.

=== Tasa anual equivalente: TAE

#quote(block: true, attribution: "Wikipedia")[
  En finanzas, la Tasa Anual Equivalente o de Equivalencia (TAE) es una referencia orientativa del coste o rendimiento efectivo anual de un producto financiero independientemente de su plazo. Su cálculo incluye la tasa de interés nominal, los gastos, comisiones, pagos e ingresos y permite comparar de una manera homogénea el rendimiento de productos financieros diferentes.

  El cálculo de la TAE es simplemente el cálculo del tipo de interés anual según el interés compuesto, donde los intereses obtenidos son remunerados al mismo tipo de interés (no son ignorados o trasladados en el tiempo). Además, el cálculo de la TAE debe incluir todos los pagos (incluidas comisiones u otros costes obligatorios como la contratación de seguros). Los pagos a incluir varían según el producto bancario de que se trate y vienen establecidos en España por la Circular 5/12 del Banco de España.

  Se calcula como el resultado de una fórmula matemática normalizada que tiene en cuenta el tipo de interés, las comisiones bancarias, la frecuencia de los pagos (mensuales, trimestrales, etc.) y otros gastos o ingresos.
]

La fórmula se recoge en el #link("https://www.boe.es/boe/dias/2012/07/06/pdfs/BOE-A-2012-9058.pdf")[anejo 7 de la Circular 5/2012 de 27 de junio del Banco de España]. Se origina en regulaciones europeas, y una buena descripción es la siguiente
#quote(block: true, attribution: "Wikipedia")[
  A single method of calculating the APR was introduced in 1998 (directive 98/7/EC) and is required to be published for the major part of loans. Using the improved notation of directive 2008/48/EC.

  $
    sum_(i=1)^M C_i (1+"TAE"/100)^(-t_i)=sum_(j=1)^N D_j (1+ "TAE" /100)^(-s_j)
  $

  where:

  - $M$ is the total number of drawdowns paid by the lender
  - $N$ is the total number of repayments paid by the borrower
  - $i$ is the sequence number of a drawdown paid by the lender
  - $j$ is the sequence number of a repayment paid by the borrower
  - $C_i$ is the cash flow amount for drawdown number i
  - $D_j$ is the cash flow amount for repayment number j
  - $t_i$ is the interval, expressed in years and fractions of a year, between the date of the first drawdown and the date of drawdown i
  - $s_j$ is the interval, expressed in years and fractions of a year, between the date of the first drawdown and the date of repayment j.

  In this equation the left side is the present value of the drawdowns made by the lender and the right side is the present value of the repayments made by the borrower. In both cases the present value is defined given the APR as the interest rate. So the present value of the drawdowns is equal to the present value of the repayments, given the APR as the interest rate.

  Note that neither the amounts nor the periods between transactions are necessarily equal. For the purposes of this calculation, a year is presumed to have 365 days (366 days for leap years), 52 weeks or 12 equal months. As per the standard: "An equal month is presumed to have 30.41666 days (i.e. 365/12) regardless of whether or not it is a leap year." The result is to be expressed to at least one decimal place. This algorithm for APR is required for some but not all forms of consumer debt in the EU. For example, this EU directive is limited to agreements of €50,000 and below and excludes all mortgages.

  [...]

  If the length of the periods are equal (monthly payments) then the summations can be simplified using the formula for a geometric series. Either way, the APR can be solved iteratively only from the formulas above, apart from trivial cases such as N=1.
]

Si no hay gastos, para calcular la TAE en tanto por uno a partir del TIN expresado también en tanto por uno se utiliza esta fórmula:
$
  "TAE"=(1+r/f)^f-1
$
Donde:
- $r$ es el tipo de interés nominal TIN (mensual, semestral...) expresado en tanto por uno.
- $f$ es la frecuencia de pagos/cobros de intereses: 1 (tipo Anual), 2 (semestral), 3 (cuatrimestral), 4 (trimestral), 6 (bimestral), 12 (mensual).
Cuando hay gastos, este valor es el llamado _tipo efectivo en la definición restringida_ (TEDR) en la #link("https://clientebancario.bde.es/pcb/es/menu-horizontal/productosservici/relacionados/tiposinteres/guia-textual/latae/tipo-efectivo-definicion-restringida.html")[web del banco de España].

=== Ejemplo
Por ejemplo, queremos comprar un teléfono que vale 500 euros y nos ofrecen la posibilidad de financiar en cuatro meses. En muy grande, vemos que es una financiación sin intereses, es decir, el TIN es del 0%. Los gastos de gestión, leemos en la letra pequeña, son 20 euros.

Así, la cuota mensual será de 125 euros, pero al sumar esos 20 euros de gastos de gestión (que pagaremos al principio, por ejemplo), la TAE será del 21,74%. En total, se pagarán los 500 euros del teléfono, más los 20 de gestión, por lo que la operación saldrá en 520 euros.

Si otra entidad ofrece esa misma opción de financiación, sin gastos de gestión ni comisiones, pero con un TIN del 5%, se podría pensar al comparar un TIN con el otro que la primera opción (0% TIN) es mejor, pero al hacer los cálculos, la TAE sale aquí del 5,1%. La cuota mensual será de 126,30 euros. En total pagaremos 505,2 euros.
¿Qué es el TIN y en qué se diferencia de la TAE?

#link("https://www.bbva.com/es/salud-financiera/tin-que-es-diferencias-tae/")[Figura]

== Préstamos

*Ejemplo (Hipoteca)*.
En una hipoteca el tipo de interés se suele expresar en TIN anual.

=== Amortización francesa

La premisa de esta amortización es que la cuota mensual, $c$, permanece fija si el interés nominal no cambia.
De manera que hemos de deducir $c$.
El interés en el mes $n$-ésimo, $i_n$, es siempre la proporcionales al principal pendiente, $p_n$, es decir $i_n = r p_n$, donde $r$ es el tipo de interés mensual.
En la práctica se aplica la convención de que el tipo mensual es
$
  r = "TIN"_"anual" / 12.
$
El $"TIN"_"anual"$ es el tipo de interés que negociaremos con el banco.
La amortización $a_n$ varía con el tiempo de manera que $c = a_n + i_n$ sea constante. Calculamos la actualización del principal
$
  p_(n+1) = p_n - a_n = p_n - (c - i_n) = (1 + r) p_n - c .
$
Esta es una ecuación de recurrencia de primer orden, lineal, y no homogénea.
Tomamos el punto fijo
$p^* = (1 + r)p^* + c$
(es decir $p^* = -c/r$) y para $x_n = p_n - p^*$ deducimos la ecuación
$x_(n+1) = (1 + r)x_n$
de modo que, por inducción, $x_n = (1 + r)^n x_0$.
// Así $p_n = p^* + (1 + r)^n (p_0 - p^*).$
Dado que buscamos que $p_N = 0$, si queremos que amortizar la hipoteca en $N$ años, es decir $p_N = 0$, podemos despejar
$
  c = (p_0 r)/(1-(1+r)^(-N)).
$

*Comentario: Hipotecas variables*. Un tipo habitual de hipotecas tiene tipo variable o es mixta (unos primeros años con tipo fijo, y luego tipo variable).
Es habitual que el tipo variable se exprese en función como
$
  "Euribor" + "Diferencial".
$
El diferencial se pacta con el banco en la hipoteca, y el euribor es anunciado
En este caso, $r$ va cambiando. Es habitual que se revise cada 6 meses utiliza como $"TIN"_"anual"$ el correspondiente #link("https://www.euribor-rates.eu/es/tipos-euribor-actualmente/4/euribor-valor-12-meses/")["Euribor a 12 meses"].

=== Amortización alemana

=== Amortización americana

