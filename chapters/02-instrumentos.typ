// LTeX: language=es

#import "../header/template.typ": *

= Instrumentos y mercados financieros

== Activos subyacentes

=== Acciones

=== Activos de renta fija: Bonos


In finance, a bond is a type of security under which the issuer (debtor) owes the holder (creditor) a debt, and is obliged – depending on the terms – to provide cash flow to the creditor; which usually consists of repaying the principal (the amount borrowed) of the bond at the maturity date, as well as interest (called the coupon) over a specified amount of time.

An investor who has a regular bond receives income from coupon payments, which are made semi-annually or annually. The investor also receives the principal or face value of the investment when the bond matures.

A zero-coupon bond (also discount bond or deep discount bond) is a bond in which the face value is repaid at the time of maturity.[1] Unlike regular bonds, it does not make periodic interest payments or have so-called coupons, hence the term zero-coupon bond. When the bond reaches maturity, its investor receives its par (or face) value. Examples of zero-coupon bonds include US Treasury bills, US savings bonds, long-term zero-coupon bonds,[1] and any type of coupon bond that has been stripped of its coupons.

En España: Letras y bonos del Tesoro.
#figure(
  // placement: bottom,
  image("02-figuras/bono-tesoro.jpg", width: 70%),
  caption: [Bono del Tesoro Español. Fuente: #link("https://bidkit.ams3.digitaloceanspaces.com/34/imgBig/50/2623.jpg")[link]],
)

==== Valoración de un bono #footnote[Los ejemplos de esta sección están tomados de @Hull2015]



Supongamos que sabemos las tasas cero para composición continua como en @table-interes-tiposzerotesoro (que más adelante veremos cómo calcular)
#figure(
  table(
    columns: (auto, auto),
    table.header([*Maduración \ (años)*], [*Índice cero %\ con composición continua*]),
    [0.5], [5.0],
    [1.0], [5.8],
    [1.5], [6.4],
    [2.0], [6.8],
  ),
  caption: "Tipos cero del Tesoro",
)<table-interes-tiposzerotesoro>
Supongamos un bono cuyo principal es de $100$\$ con un cupón del 6% semi-anual. Es decir, cada 6 meses recibimos 3\$.
El precio actual del bono es
$
  underbrace(3, "primer cupón") underbrace(e^(-underbrace(0.5, "tipo") times underbrace(0.5, "6 meses")), "descontando") + 3 e^(-0.058 times 1.0) + 3 e^(-0.064 times 1.5)
  + (underbrace(100, "principal") + 3) e^(-0.068 times 2.0) = 98.39
$

==== Rendimiento del bono

El rendimiento de un bono es tipo de descontinuo que da el mismo valor. Es decir, $y$ tal que
$
  3 e^(-y times 0.5)+ 3 e^(-y times 1.0) + 3 e^(-y times 1.5)
  + (100 + 3) e^(-y times 2.0) = 98.39
$
Esta ecuación no admite una solución sencilla, pero claramente el lado derecho es monónoto con $y$. Puede resolver con algún método numérico por ejemplo bisección. En este caso $y = 6.76%$.

// === _Yield curve_

==== Índice cupón-cero del Tesoro#footnote[El ejemplo de esta sección están tomados de @Hull2015]


Para construir los valores de la tabla @table-interes-tiposzerotesoro se utilizan los pagos que hacen distintos tipos de bonos.
Hay diferentes formas de hacer este cálculo, pero vamos a  hablar del método _bootstrap_. La idea es ir utilizando bonos de menor duración para ir fijando una "curva" de $r$ a cada periodo.
Por ejemplo, pensemos que tenemos los bonos de @table-interes-bootstrap.

Para el bono de 3 meses (0.25 años), calculamos
$
  100 = 97.5 e^(r_(0.25) times 0.25).
$
De donde $r_(0.25) = 10.127%$. Los de 6 meses y un año nos dan $r_(0.5) = 10.469%$ y $r_(1.0) = 10.536%$.

El cuarto bono dura 1.5 años. Y paga lo que sigue:
- 6 meses: 4\$
- 1 año: 4\$
- 1.5 años: 104\$
Para los dos primeros plazos podemos usar las fórmulas de descuento anteriores, y sólo nos queda la última por despejar
$
  4e^(-0.10469 times 0.5) + 4 e^(-0.10536 times 1.0) + 104 e^(-r_(1.5) times 1.5) = 96.
$
Despejando obtenemos $r_(1.5)=10.681%$.

La curva $(t,r_t)$ es la llamada *curva de rendimiento* o _yield curve_.
En este caso la hemos utilizado para calcular la curva de bonos del tesoro, pero puede combinarse el precio de diferentes activos.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    table.header([Principal\ (\$)], [Duración \ (años)], [Cupón anual \ (\$)], [Precio del bono\ (\$)]),
    [100], [0,25], [0], [97.5],
    [100], [0.5], [0], [94.9],
    [100], [1.0], [0], [90.0],
    [100], [1.5], [8], [96.0],
    [100], [2.0], [12], [101.6],
  ),
  caption: [Precio de bonos para el método de _bootstrap_],
)<table-interes-bootstrap>


// #link("https://en.wikipedia.org/wiki/Yield_curve")

// === Curva cupón cero

// En su formato más sencillo #link("https://es.wikipedia.org/wiki/Curva_cup%C3%B3n_cero")

// #link("https://www.bluegamma.io/post/what-is-a-zero-coupon-curve-and-where-to-download")

// #link("https://es.wikipedia.org/wiki/Curva_cup%C3%B3n_cero"):
// A partir de diferentes curvas observables en el mercado (mercado monetario, swaps de tipos de interés, etc.) se construye la curva cupón cero. Se utilizan diferentes metodologías para su cálculo y, en especial, estimación para puntos no observables de la curva de tipos, como por ejemplo, el "bootstrapping"#footnote[#link("https://www.bis.org/publ/bppdf/bispap25.pdf")]
//



== _Value-at-risk_ VaR

Cuando se usa un valor en riesgo se expresa:
#quote(block: true)[
  Estoy $X$% seguro de que no habrá una pérdida de más de $v$\$ en los próximos $N$ días.
]
Si supiésemos la distribución de los retornos y esta fuese continua, $R$
$
  op("VaR") N"-días al" X% := v "tal que" PP lr(("ganancia en" N "días" <= v), size: #200%) = 1 - X/100.
$
Por motivos que veremos abajo, la ganancia/pérdida escala se suele modelizar con distribuciones normales independientes como veremos más adelante
y por tanto se suele aproximar
$
  op("VaR") N"-días al" X approx sqrt(N) dot lr((op("VaR") 1"-día al" X), size: #200%)
$

El modelo más habitual es el modelo histórico, que se leer en #cite(<Hull2015>, supplement: "Chapter 22").

==== Ejemplo para un sólo activo

Estudiemos el VaR de una cartera de 10M\$ en acciones de Microsoft, al 99% de confianza a lo largo de $N=10$ días.

Normalmente se asume que el cambio esperado de valor de una variable de mercado en un periodo corto es cero. Esto no es estrictamente cierto, pero es una hipótesis razonable porque es un cambio pequeño comparado con la volatilidad.
Si pensamos que
$
  "Ganancia/pérdida" N "días" approx dot Normal (N mu, N sigma^2).
$
entonces estamos diciendo que $mu << sigma$ y que podemos suponer $mu = 0$.
Por ejemplo, podríamos pensar que Microsoft tiene una volatilidad diaria del $sigma = 2%$ (que es una volatilidad anual del 32%).
Supongamos además que tiene un retornos del 20% anual.
En el periodo de 1 día estamos diciendo que tiene un retorno del $0.2/252 = 0.08%$ mientas que la volatilidad es del 2%.

En el periodo de 10 días, la volatilidad es de $sqrt(10) dot 2% approx 6.3%$.

Sobre esta cartera esto significa que $sigma = 200.000$\$.
Busquemos el VaR de 1 día al 99% de confianza
$
  0.01 = PP(10 dot Normal(0, sigma^2) < v) = PP(Normal(0, 1) < v / sigma).
$
con lo que, utilizan las tablas de la Normal (o algún método más novedoso) $v/(sigma) = 2.326$ y deducimos que el VaR de un día resulta $v = 465,300$\$.
El VaR de diez días corresponde el VaR de 10 días es $sqrt(10) dot 465,300 = 1,471,300$\$.

En resumen, supuesto un compartimento normal de media nula
$
  "VaR" N"-días al" X% = sqrt(N) dot sigma_(1 "día") dot "erf"(1-X/100)
$


==== Ejemplo para varios activos

Para reproducir el argumento anterior en un cartera con dos activos debemos tener en cuenta que
$
  sigma_(X+Y) = sqrt(sigma_X^2 + sigma_Y^2 + 2 rho sigma_X sigma_Y).
$
donde $rho$ es la correlación entre ambos productos.

Y de hecho,
$
  var(sum_i a_i X_i) =
  underbrace((a_1, dots, a_N), a^trans)
  underbrace(
    mat(
      V(X_1), cov(X_1, X_2), dots, cov(X_1, X_N); cov(X_2, X_1), var(X_2);
      , , dots.down;
      , , , V(X_N)
    ),
    cov(X, X)
  )
  underbrace(vec(a_1, dots.v, a_N), a),
$

== Valoración de derivados

=== Contrato a plazo (_forward contract_)

Ya hemos visto el ejemplo @example-arbitrage-forward que el precio de no arbitraje, en ausencia de dividendos.

$
  F_0 = S_0 e^(r T)
$
Cuando hay dividendo a ritmo $q$ entonces la fórmula resulta
$
  F_0 = S_0 e^((r-q) T).
$
Si $r$ es constante entonces el precio de un _future_ es el mismo que el de un _forward_. Aunque la justificación es complicada. @Hull2015
<
=== Opciones

Una opción de compra (_call option_) es el derecho, pero no la obligación, de comprar el activo a un precio $K$.
Lo contrario es una opción de venta (_put option_) que es derecho, pero no la obligración, de comprar
Si esta operación se realiza en un instante concreto $T$ se habla de *opciones europeas*.
Si la opción puede ejercerse en cualquier momento anterior a $T$, se habla de *opciones americanas*.

==== Opciones call europeas

Denotaremos precio de una _call europea_ de este derecho a tiempo $t$ lo denotaremos $C_t$.
Como el lógico, si el valor mañana $S_T > K$ entonces puedo me interesará ejercer la opción, y ganaré $S_T - K$.
Si el valor es menor o igual $S_T <= K$, entonces no la ejerzo, y no ganaré nada. Esto puede escribir como que el beneficio es el valor de la call mañana $C_T = (S_T - K)_+$.
Su valor hoy, que es lo que queremos fijar, es $C_0$.


=== _Swaps_

==== Ejemplo: permuta de tipos de interés #footnote[Tomado de @Hull2015]


Consider a hypothetical 3-year swap initiated on March 5, 2014, between Microsoft and Intel. We suppose Microsoft agrees to pay Intel an interest rate of 5% per annum on a principal of \$100 million, and in return Intel agrees to pay Microsoft the 6-month LIBOR rate on the same principal. Microsoft is the fixed-rate payer; Intel is the floatingrate payer. We assume the agreement specifies that payments are to be exchanged every 6 months and that the 5% interest rate is quoted with semiannual compounding. This swap is represented diagrammatically in @fig-intelmicrosoftswap.
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  // node[math=true, xmath=true]
  // edge[lmath=true]
  i[label="Intel"]
  m[label="Microsoft"]
  m -> i[label="0.5%"]
  i -> m[label="LIBOR"]
  }
  ```),
  caption: "_Swap_ de tipos de interés",
)<fig-intelmicrosoftswap>

En @fig-intelmicrosoftswap-flows se detallan los intercambios monetarios.
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (left, center, center, center, center),
    stroke: 0.5pt,

    // Header
    table.header(
      [*Date*],
      [*Six-month LIBOR\ rate (%)*],
      [*Floating cash flow\ received*],
      [*Fixed cash flow\ paid*],
      [*Net cash flow*],
    ),

    // Data rows
    [Mar. 5, 2014], [4.20], [], [], [],
    [Sept. 5, 2014], [4.80], [+2.10], [$-$2.50], [$-$0.40],
    [Mar. 5, 2015], [5.30], [+2.40], [$-$2.50], [$-$0.10],
    [Sept. 5, 2015], [5.50], [+2.65], [$-$2.50], [+0.15],
    [Mar. 5, 2016], [5.60], [+2.75], [$-$2.50], [+0.25],
    [Sept. 5, 2016], [5.90], [+2.80], [$-$2.50], [+0.30],
    [Mar. 5, 2017], [], [+2.95], [$-$2.50], [+0.45],
  ),
  caption: "Cash flows (millions of dollars) to Microsoft in a $100 million 3-year  interest rate swap when a fixed rate of 5% is paid and LIBOR is received.",
)<fig-intelmicrosoftswap-flows>

===== ¿Por qué este swap?

Hay diferentes motivos para hacer esto. Uno de ellos sería conventir un tipo variable en un tipo fijo.

==== La crisis de 2008: _credit default swaps_
