// LTeX: language=es

#import "../header/template.typ": *

= Nociones básicas de aritmética financiera

// Tipos de interés, capitalizaciones, préstamos, rentas.
// Rendimientos, tasa interna de rendimientos. Estructura temporal de tipos de interés, la curva cupón cero. Algunos
// cálculos actuariales.

== Tipos de interés

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

La fórmula se recoge en el #link("https://www.boe.es/boe/dias/2012/07/06/pdfs/BOE-A-2012-9058.pdf")[anejo 7 de la Circular 5/2012 de 27 de junio del Banco de España]

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

=== Hipoteca
En una hipoteca el tipo de interés se suele expresar en TIN anual.

==== Amortización francesa

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
  "Euribor" + "Diferencial"
$
donde:
#quote(block: true, attribution: link("https://es.wikipedia.org/wiki/Eur%C3%ADbor")[Wikipedia])[
  El euríbor (del inglés euribor) (acrónimo de Euro Interbank Offered Rate, es decir, tipo europeo de oferta interbancaria) es un índice de referencia publicado diariamente que indica el tipo de interés promedio al que un gran número de bancos europeos dicen concederse préstamos a corto plazo entre ellos para prestárselo a terceros —particulares y empresas—.]
El diferencial se pacta con el banco en la hipoteca, y el euribor es anunciado
En este caso, $r$ va cambiando. Es habitual que se revise cada 6 meses utiliza como $"TIN"_"anual"$ el correspondiente #link("https://www.euribor-rates.eu/es/tipos-euribor-actualmente/4/euribor-valor-12-meses/")["Euribor a 12 meses"].

==== Amortización alemana

==== Amortización americana
