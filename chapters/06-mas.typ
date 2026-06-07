#import "../header/template.typ": *

#counter(heading).update(0)
#set heading(numbering: "A.1", supplement: [Apéndice])
= Apéndice


== Tasa anual equivalente: TAE <sec-TAE>

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

#exercise[TAE sin gastos][
  Comprobar que,
  si no hay gastos, para calcular la TAE en tanto por uno a partir del TIN expresado también en tanto por uno se utiliza esta fórmula:
  $
    "TAE"=(1+r/f)^f-1
  $
  Donde:
  - $r$ es el tipo de interés nominal TIN (mensual, semestral...) expresado en tanto por uno.
  - $f$ es la frecuencia de pagos/cobros de intereses: 1 (tipo Anual), 2 (semestral), 3 (cuatrimestral), 4 (trimestral), 6 (bimestral), 12 (mensual).
  Cuando hay gastos, este valor es el llamado _tipo efectivo en la definición restringida_ (TEDR) en la #link("https://clientebancario.bde.es/pcb/es/menu-horizontal/productosservici/relacionados/tiposinteres/guia-textual/latae/tipo-efectivo-definicion-restringida.html")[web del banco de España].

]
