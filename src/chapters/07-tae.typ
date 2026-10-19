#import "../header/template.typ": *

= Tasa anual equivalente: TAE <sec-TAE>

#quote(block: true, attribution: "Wikipedia")[
  En finanzas, la Tasa Anual Equivalente o de Equivalencia (TAE) es una referencia orientativa del coste o rendimiento efectivo anual de un producto financiero independientemente de su plazo. Su cálculo incluye la tasa de interés nominal, los gastos, comisiones, pagos e ingresos y permite comparar de una manera homogénea el rendimiento de productos financieros diferentes.

  El cálculo de la TAE es simplemente el cálculo del tipo de interés anual según el interés compuesto, donde los intereses obtenidos son remunerados al mismo tipo de interés (no son ignorados o trasladados en el tiempo). Además, el cálculo de la TAE debe incluir todos los pagos (incluidas comisiones u otros costes obligatorios como la contratación de seguros). Los pagos a incluir varían según el producto bancario de que se trate y vienen establecidos en España por la Circular 5/2012 del Banco de España.

  Se calcula como el resultado de una fórmula matemática normalizada que tiene en cuenta el tipo de interés, las comisiones bancarias, la frecuencia de los pagos (mensuales, trimestrales, etc.) y otros gastos o ingresos.
]

La fórmula se recoge en el #link("https://www.boe.es/boe/dias/2012/07/06/pdfs/BOE-A-2012-9058.pdf")[anejo 7 de la Circular 5/2012 de 27 de junio del Banco de España]. Se origina en regulaciones europeas, y una buena descripción es la siguiente:
#quote(block: true, attribution: [Traducido de https://en.wikipedia.org/wiki/Annual_percentage_rate])[
  En 1998 se introdujo un método único de cálculo de la TAE (directiva 98/7/CE), cuya publicación es obligatoria para la mayor parte de los préstamos. Con la notación mejorada de la directiva 2008/48/CE:

  $
    sum_(i=1)^M C_i (1+"TAE"/100)^(-t_i)=sum_(j=1)^N D_j (1+ "TAE" /100)^(-s_j)
  $

  donde:

  - $M$ es el número total de disposiciones pagadas por el prestamista;
  - $N$ es el número total de reembolsos pagados por el prestatario;
  - $i$ es el número de orden de una disposición pagada por el prestamista;
  - $j$ es el número de orden de un reembolso pagado por el prestatario;
  - $C_i$ es el importe de la disposición número $i$;
  - $D_j$ es el importe del reembolso número $j$;
  - $t_i$ es el intervalo, expresado en años y fracciones de año, entre la fecha de la primera disposición y la fecha de la disposición $i$;
  - $s_j$ es el intervalo, expresado en años y fracciones de año, entre la fecha de la primera disposición y la fecha del reembolso $j$.

  En esta ecuación el lado izquierdo es el valor actual de las disposiciones hechas por el prestamista y el lado derecho es el valor actual de los reembolsos hechos por el prestatario. En ambos casos el valor actual se define tomando la TAE como tipo de interés. Así, el valor actual de las disposiciones es igual al valor actual de los reembolsos, tomando la TAE como tipo de interés.

  Nótese que ni los importes ni los periodos entre transacciones son necesariamente iguales. A efectos de este cálculo, se supone que un año tiene 365 días (366 en los bisiestos), 52 semanas o 12 meses iguales. Según la norma: «Se supone que un mes igual tiene 30.41666 días (es decir, 365/12), sea o no bisiesto el año». El resultado debe expresarse con al menos un decimal. Este algoritmo para la TAE es obligatorio para algunas formas de crédito al consumo en la UE, pero no para todas. Por ejemplo, esta directiva europea se limita a contratos de 50 000 € o menos y excluye todas las hipotecas.

  [...]

  Si los periodos tienen la misma longitud (pagos mensuales), las sumas pueden simplificarse usando la fórmula de la serie geométrica. En cualquier caso, la TAE solo puede despejarse de las fórmulas anteriores de manera iterativa, salvo en casos triviales como $N=1$.
]

#exercise[TAE sin gastos][
  Comprobar que,
  si no hay gastos, para calcular la TAE en tanto por uno a partir del TIN expresado también en tanto por uno se utiliza esta fórmula:
  $
    "TAE"=(1+r/f)^f-1
  $
  donde:
  - $r$ es el tipo de interés nominal TIN (mensual, semestral...) expresado en tanto por uno.
  - $f$ es la frecuencia de pagos/cobros de intereses: 1 (tipo anual), 2 (semestral), 3 (cuatrimestral), 4 (trimestral), 6 (bimestral), 12 (mensual).
  Cuando hay gastos, este valor es el llamado _tipo efectivo en la definición restringida_ (TEDR) en la #link("https://clientebancario.bde.es/pcb/es/menu-horizontal/productosservici/relacionados/tiposinteres/guia-textual/latae/tipo-efectivo-definicion-restringida.html")[web del Banco de España].

]
