// LTeX: language=es

#import "../header/template.typ": *

= Instrumentos y mercados financieros

// Instrumentos y mercados financieros. Bonos, acciones, contratos a plazo, swaps. Opciones europeas y americanas, otros derivados.

== Activos subyacentes

=== Acciones

#quote(block: true, attribution: [https://en.wikipedia.org/wiki/Stock])[
  Stocks (also capital stock, or sometimes interchangeably, shares) consist of all the shares by which ownership of a corporation or company is divided. A single share of the stock means fractional ownership of the corporation in proportion to the total number of shares. This typically entitles the shareholder (stockholder) to that fraction of the company's earnings, proceeds from liquidation of assets (after discharge of all senior claims such as secured and unsecured debt), or voting power, often dividing these up in proportion to the number of like shares each stockholder owns. Not all stock is necessarily equal, as certain classes of stock may be issued, for example, without voting rights, with enhanced voting rights, or with a certain priority to receive profits or liquidation proceeds before or after other classes of shareholders.

  Stock can be bought and sold privately or on stock exchanges. Transactions of the former are closely overseen by governments and regulatory bodies to prevent fraud, protect investors, and benefit the larger economy. As new shares are issued by a company, the ownership and rights of existing shareholders are diluted in return for cash to sustain or grow the business. Companies can also buy back stock, which often lets investors recoup the initial investment plus capital gains from subsequent rises in stock price. Stock options issued by many companies as part of employee compensation do not represent ownership, but represent the right to buy ownership at a future time at a specified price. This would represent a windfall to the employees if the option were exercised when the market price is higher than the promised price, since if they immediately sold the stock they would keep the difference (minus taxes).
]

#figure(
  image("../figures/Compania_Guipuzcoana_Accion_2124_Madrid_1_junio_1752.jpg"),
  caption: [Acción n.º 2124 de la Real Compañía Guipuzcoana de Caracas a favor de Doña Juana de Ortega. Madrid, 1 de junio de 1752. #link("https://commons.wikimedia.org/wiki/File:Compania_Guipuzcoana_Accion_2124_Madrid_1_junio_1752.jpg")[Wikipedia]. Ver más certificados de acción en: #link("https://commons.wikimedia.org/wiki/Stock_certificates")[link]],
)

Cuando la acciones son públicas, se le asigna un _ticker_ (por ejemplo Apple, Inc. es `AAPL`).
Por ejemplo, en junio de 2026 Apple contaba con (ver #link("https://companiesmarketcap.com/apple/shares-outstanding/")[Fuente]) con 14,673,278,000 a un precio de 307.34\$ cada una. Esto hace que esté valorada en 450 mil millones de dólares americanos.
Modelizar la evolución del precio de los stocks es una de las tareas más difíciles de la Matemática Financiera.

=== Índices del mercado de acciones  (_stock market index_)

#quote(block: true, attribution: "https://en.wikipedia.org/wiki/Stock_market_index")[
  In finance, a stock market index or stock index is an index that measures the performance of a stock market, or of a subset of a stock market. It helps investors compare current stock price levels with past prices to calculate market performance.

  Two of the primary criteria of an index are that it is investable and transparent: The methods of its construction are specified. Investors may be able to invest in a stock market index by buying an index fund, which is structured as either a mutual fund or an exchange-traded fund, and "tracks" an index. The difference between an index fund's performance and the index, if any, is called tracking error.
]

Algunos ejemplos son el S&P500 (ticker `^SPX`) o el Euro Stoxx 50 (`^SX5E`).

=== Bonos de renta fija#footnote[En esta sección seguimos la notación de @bjorkArbitrageTheoryContinuous2019]


In finance, a bond is a type of security under which the issuer (debtor) owes the holder (creditor) a debt, and is obliged – depending on the terms – to provide cash flow to the creditor; which usually consists of repaying the principal (the amount borrowed) of the bond at the maturity date, as well as interest (called the coupon) over a specified amount of time.

An investor who has a regular bond receives income from coupon payments, which are made semi-annually or annually. The investor also receives the principal or face value of the investment when the bond matures.

Los del #link("https://home.treasury.gov")[_US Treasury_] o el Banco de España, en letras y bonos (_Treasury bills_ and _Treasury bonds_). Estos son los instrumentos usados por los Gobiernos para pedir dineros prestado en su propia moneda.
Se suele asumir que los gobiernos no llegará a impago (_default_), de manera que se asume que estos tipos de interés son libres de riesgo.

A zero-coupon bond (also discount bond or deep discount bond) is a bond in which the face value is repaid at the time of maturity.[1] Unlike regular bonds, it does not make periodic interest payments or have so-called coupons, hence the term zero-coupon bond. When the bond reaches maturity, its investor receives its par (or face) value. Examples of zero-coupon bonds include US Treasury bills, US savings bonds, long-term zero-coupon bonds, and any type of coupon bond that has been stripped of its coupons.

En España: Letras y bonos del Tesoro.
#figure(
  // placement: bottom,
  image("../figures/bono-tesoro.jpg", width: 70%),
  caption: [Bono del Tesoro Español. Fuente: #link("https://bidkit.ams3.digitaloceanspaces.com/34/imgBig/50/2623.jpg")[link]],
)

==== Bono de cupón fijo

#definition[Bono de cupón fijo][
  Bono con cupones $c_i$ a tiempo $T_i$ y muduración $T_n$ y principal $K$ es un bono que
  - En cada fecha $T_i$ emite un cupón (pago) de $c_i$
  - A tiempo $T_n$ se reciben el cupón correspondiente y el principal.
  Ocasionalmente, el cupón se expresa en términos del los retornos
  $
    c_i = r_i (T_i - T_(i-1)) K.
  $
  En los cupones más estándar el tiempo $T_i = i delta$ y los tipos del cupón son iguales $r_i = r$.
]

==== Valoración de un bono de cupón fijo #footnote[Los ejemplos de esta sección están tomados de @Hull2015]

Al igual que pasa con los contratos a plazo, el precio de un bono con cupón fijo debe ser, si $t < T_1$
$
  p_"fijo" (t) = sum_(i=1)^(n) c_i p(t, T_i) + K p(t, T_n).
$<eq-bonocuponfijo>

#exercise[
  Supongamos que encontramos en el mercado un bono con $T_1 = 0.5$ y vencimiento $T_2 = 1$ cupón fijo $c_1 > 0$ y que no satisface la fórmula @eq-bonocuponfijo. Utilizar bonos cupón cero (ver @def-bonocuponcero) para crear una estrategia de arbitraje.
]

#example[Valoración de bono de cupón fijo][
  Supongamos que sabemos las tasas cero para composición continua como en @table-interes-tiposzerotesoro (que más adelante veremos cómo calcular)
  #figure(
    table(
      columns: (auto, auto),
      table.header([*Maduración \ (años)*], [*Rendimiento cupón-cero \ con composición continua* $R(0, T)$\ (%)]),
      [0.5], [5.0],
      [1.0], [5.8],
      [1.5], [6.4],
      [2.0], [6.8],
    ),
    caption: "Tipos cero del Tesoro",
  )<table-interes-tiposzerotesoro>
  Supongamos un bono cuyo principal es de $100$\$ con un cupón del 6% semi-anual (es decir $r_i = 6%$ y $T_i - T_(i-1) = 0.5$). Es decir, cada 6 meses recibimos un cupón de 3\$.
  El precio actual del bono es
  $
    p(t) & = underbrace(3, "primer cupón") underbrace(e^(-underbrace(0.5, "tipo") times underbrace(0.5, "6 meses")), "descontando") + 3 e^(-0.058 times 1.0) + 3 e^(-0.064 times 1.5)
           + (underbrace(100, "principal") + 3) e^(-0.068 times 2.0) \
         & = 98.39
  $]

==== Rendimiento del bono hasta la maduración

El rendimiento de un bono es el tipo de descuento que da el mismo valor. Es decir, $y$ tal que
$
  p_"fijo" (t) = sum_(i=1)^n c_i e^(-y (T_i - t)).
$
En el ejemplo
$
  3 e^(-y times 0.5)+ 3 e^(-y times 1.0) + 3 e^(-y times 1.5)
  + (100 + 3) e^(-y times 2.0) = 98.39
$
Esta ecuación no admite una solución sencilla, pero claramente el lado derecho es monónoto con $y$. Puede resolver con algún método numérico por ejemplo bisección. En este caso $y = 6.76%$.

=== Cálculo de la curva cupón-cero o _yield curve_

Lo habitual es "deducir" la fórmula de cupón-cero a partir de los valores de distintos productos. Hay diferentes métodos para hacer este cálculo. A continuación presentamos un ejemplo sencillo.

#example(
  breakable: true,
)[Cálculo del rendimiento de cupón-cero a partir de bonos de cupón fijo#footnote[El ejemplo de esta sección están tomados de @Hull2015]][
  Para construir los valores de la tabla @table-interes-tiposzerotesoro se utilizan los pagos que hacen distintos tipos de bonos.
  Hay diferentes formas de hacer este cálculo, pero vamos a  hablar del método _bootstrap_. La idea es ir utilizando bonos de menor duración para ir fijando $R(T) := R(0, T)$ a cada periodo $T$.
  Por ejemplo, pensemos que tenemos los bonos de @table-interes-bootstrap. En cada caso, igualamos el valor actual del bono al valor actual (o valor descontado) de todos los pagos recibidos.

  Para el bono de 3 meses (0.25 años), calculamos
  $
    100 times e^(- R(0.25) times 0.25) = 97.5.
  $
  De donde $R(0.25) = 10.127%$. Los de 6 meses y un año nos dan $R(0.5) = 10.469%$ y $R(1.0) = 10.536%$.

  El cuarto bono dura 1.5 años. Y paga lo que sigue:
  - 6 meses: 4\$
  - 1 año: 4\$
  - 1.5 años: 104\$
  Para los dos primeros plazos podemos usar las fórmulas de descuento anteriores, y sólo nos queda la última por despejar
  $
    4e^(-0.10469 times 0.5) + 4 e^(-0.10536 times 1.0) + 104 e^(-R(1.5) times 1.5) = 96.
  $
  Despejando obtenemos $R(1.5)=10.681%$.

  #figure(
    placement: auto,
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
]
<ex-calculo-zerocouponyield>

// #link("https://en.wikipedia.org/wiki/Yield_curve")

// === Curva cupón cero

// En su formato más sencillo #link("https://es.wikipedia.org/wiki/Curva_cup%C3%B3n_cero")

// #link("https://www.bluegamma.io/post/what-is-a-zero-coupon-curve-and-where-to-download")

// #link("https://es.wikipedia.org/wiki/Curva_cup%C3%B3n_cero"):
// A partir de diferentes curvas observables en el mercado (mercado monetario, swaps de tipos de interés, etc.) se construye la curva cupón cero. Se utilizan diferentes metodologías para su cálculo y, en especial, estimación para puntos no observables de la curva de tipos, como por ejemplo, el "bootstrapping"#footnote[#link("https://www.bis.org/publ/bppdf/bispap25.pdf")]
//

=== Bonos de interés variables

Hay diferentes tipos de bonos en los que el tipo de interés no se fija cuando se emite el bono, si no que se fija en cada periodo de cupón. Habitualmente esto se hace a través de algún _benchmark_ financiero, como el LIBOR o el EURIBOR.


#proposition(breakable: true)[Valor de un cupón LIBOR][
  El cupón $i$-ésimo se fija a tiempo $T_i$ como
  $
    c_i = (T_i - T_(i-1)) L(T_(i-1), T_i) K
  $
  donde $L(T_(i-1), T_i)$ es el spot del LIBOR, fijado a fecha $T_(i-1)$, pero el cupón no se cobra hasta tiempo $T_i$.

  El valor a tiempo $t$ del cupón $c_i$ cobrado a tiempo $T_i$ es
  $
    p(t, T_(i-1)) - p(t, T_(i)).
  $
]<lem-cupon-LIBOR>
#proof[
  Pongamos por ejemplo caso del LIBOR. Entonces el cupón $i$-ésimo se fija a tiempo $T_i$ como
  $
    c_i = (T_i - T_(i-1)) L(T_(i-1), T_i) K
  $
  donde $L(T_(i-1), T_i)$ es el spot del LIBOR, fijado a fecha $T_(i-1)$, pero el cupón no se cobra hasta tiempo $T_i$.
  Usando la definición
  $
    c_i = delta (1 - p(T_(i-1), T_i))/(delta p(T_(i-1), T_i)) = 1 / p(T_(i-1), T_i) - 1.
  $
  La siguiente estrategia permite calcular $1/p(T_(i-1), T_i)$:
  - A tiempo $t$ compra un bono de maduración $T_(i-1)$, que cuesta $p(t, T_(i-1))$\$.
  - A tiempo $T_(i-1)$ esto da 1\$.
  - Dedica este dólar a comprar bonos de maduración a tiempo $T_i$, es decir obtén $1/p(T_(i-1), T_i)$.
  - A tiempo $T_i$ recibes 1\$ por cada bono, es decir $1/p(T_(i-1), T_i)$\$.
  Así, invirtiendo $p(t, T_i)$\$ a tiempo $t$ se obtienen $1/p(T_(i-1), T_i)$ \$ a tiempo $T_i$. Luego este es valor de no arbitraje de la inversión.
]
Así deducimos que el valor a tiempo $t$ del bono con tipo variable LIBOR es
$
  p_"var" (t) = p(t, T_n) + sum_(i=1)^n [p(t, T_(i-1)) - p(t, T_i)] = p(t, T_0).
$<eq-bonolibor>
Es decir $p_"var" (0) = 1$.

#exercise[][
  Deducir @eq-bonolibor directamente
  construyendo una cartera autofinanciada que reproduzca el precio de bono de tipo variable.
]

== Derivados

=== Contrato a plazo (_forward contract_) <example-arbitrage-forward>

#definition[_Contrato a plazo_][
  Compromiso (derecho y obligración) de intercambiar un activo a un pricio $F_0$, llamado _strike_, en una fecha de vencimiento dada $T$.
  Este contrato se realiza sin intercambio de dinero o activos el día de la firma.
]

Si denotamos por $S_0$ el precio actual del activo, y $r$ es interés de cupón cero para ese periodo (es decir $e^(-r T) = p(0,T)$), veamos que la condición de no-arbitraje es equivalente a que
$
  F_0 = S_0 e^(r T).
$
<eq-forward>

Supongamos que podemos pedir prestado dinero $S_0$ es el valor actual de un activo, es decir, por cada € que pida prestado hoy he devolver $e^(r T)$€ al vencimiento del contrato. Supongamos que el contrato tiene un strike $F_0$, al que se produce la venta del activo.

A vencimiento, si soy el vendedor del contrato, debo honrarlo. Para ello, debo vender a quien tiene el contrato, el activo al precio pacto.
Por ejemplo, si no tengo el activo debo comprarlo en el mercado (pagando $S_T$) y venderlo a mi contrapartido del _forward_ al precio $F_0$. De modo que en mi balance contable resulta en $F_0 - S_T$. Si este valor es positivo gano dinero, si es negativo lo pierdo. Pero lo importante es saber si consigo salir de la operación completa ganando dinero. Para ello, hay que pensar cuál es el valor justo $F_0$ y qué puedo hacer en cada caso.

Argumentamos que si $F_0 != S_0 e^(r T)$ entonces se puede ganar dinero sin riesgo.

Si alguien está dispuesto a entrar con nosotros en un contrato a futuro donde $F_0 > S_0 e^(r T)$, entonces hoy podemos pedir prestado el dinero, y comprar el activo.
Mantenemos el activo en nuestra posesión hasta el vencimiento del contrato, y liquidamos la operación ¡con beneficio!
El resultado contable es la @table-forward-arbitrage1. El resultado es que _independientemente del valor $S_T$_ gano dinero seguro. Además, he hecho la operación sin "poner" dinero. Este efecto es el conocido como arbitraje.
#figure(
  table(
    columns: (auto, auto, auto),
    table.header([*Transacción*], [*Pago ahora (€) \ $t = 0$*], [*Pago bencimiento (€) \ $t = T$*]),
    [Comprar el contrato], [#text(fill: red)[0]], [$F_0 - S_T$ \ (positivo o negativo)],
    [Comprar el activo], [-#text(fill: red)[$S_0$]], [$S_T$],
    [Pedir prestado], [+$S_0$], [-#text(fill: red)[$S_0 e^(r T)$]],
    table.hline(stroke: 3pt),
    [Total], [0], [$F_0 - S_0 e^(r T)$],
  ),
  caption: [Arbitraje en un contrato forward si $F_0 > S_0 e^(r T)$. Cada casilla representa el apunte contable correspondiente (donde negro significa ingreso, y rojo significa gasto).],
)<table-forward-arbitrage1>
Por contra, si hubiese alguien dispuesto a hacer el contrato con $F_0 < S_0 e^(r T)$ podría hacer la operación inversa, como detalla @table-forward-arbitrage2.
#figure(
  table(
    columns: (auto, auto, auto),
    table.header([*Transacción*], [*Pago ahora (€) \ $t = 0$*], [*Pago bencimiento (€) \ $t = T$*]),
    [Vender el contrato], [#text(fill: black)[0]], [-#text(fill: red)[$(S_T - F_0)$]],
    [Comprar el activo], [#text(fill: black)[$S_0$]], [-#text(fill: red)[$S_T$]],
    [Pretar \
      a un tercero],
    [-#text(fill: red)[$S_0$]],
    [#text(fill: black)[$S_0 e^(r T)$]],
    table.hline(stroke: 3pt),
    [Total], [0], [$S_0 e^(r T) - F_0$],
  ),
  caption: [Arbitraje en un contrato forward si $F_0 < S_0 e^(r T)$. Cada casilla representa el apunte contable correspondiente (donde negro significa ingreso, y rojo significa gasto).],
)<table-forward-arbitrage2>
De modo que el precio libre de arbitraje es @eq-forward.

Por supuesto, esto asume que el precio del contrato _forward_ es el mismo al comprarlo que al venderlo (esto es una simplificación excesiva), y que podemos pedir prestado o prestar dinero al mismo precio (también falso). Sin embargo, es una aproximación suficientemente buena para gran parte del análisis.

Cuando hay dividendo a ritmo $q$ entonces la fórmula resulta
$
  F_0 = S_0 e^((r-q) T).
$
Si $r$ es constante entonces el precio de un _future_ es el mismo que el de un _forward_. Aunque la justificación es complicada (ver @Hull2015).

#exercise(breakable: true)[Forward rate agreement][
  En este contrato, en el que por convención se entra en $t = 0$, dos partes (prestamista o _lender_ y prestatario o _borrower_) acceden al préstamos de un principal $K$ con un tipo de interés $R^*$ en un periodo futuro $[T_1, T_2]$. Asumiendo el tipo de composición es continuo, el _cash flow_ del prestamista es el siguiente:
  - A tiempo $T_1$: $-K$
  - A tiempo $T_2$: $K e^(R^* (T -S))$.
  El _cash flow_ del prestatario es, por supuesto, el opuesto. Se pide:
  + Calcular el precio de este contrato, $Pi(t)$ para un tiempo $t < T_1$ dado en función del precio de cupón cero.
  + Demostrar que si $Pi(0) = 0$ entonces el tipo $R^* = R(0; T_1, T_2)$.
]

=== _Swaps_

Una permuta financiera o swap es un contrato por el cual dos partes se comprometen a intercambiar una serie de cantidades de dinero en fechas futuras, y cómo se calcularán.

El producto más popular es el _swap_ de tipos de interés es uno donde el LIBOR se intercambia por un tipo fijo.
Vamos a considerar el caso en el que el interés se paga con atraso.

#proposition[
  El valor de un swap de principal $K$ firmado donde a tiempo $T_0$ con cupones en tiempos $T_i = T_0 + i delta$ donde entregas tipo fijo $R$ y recibes tipo variable LIBOR tiene el valor a tiempo $t < T_0$
  $
    Pi(t) = K p(t, T_0) - K sum_(i=1)^n d_i p (t, T_i) " donde "
    d_i = cases(
      R delta & "si" i=1 comma dots.c comma n-1,
      1 + R delta & "si" i = n.
    )
  $
]

#proof[
  El cálculo consiste en equilibrar el valor futuro el valor a tiempo $t$ el _cash flow_ total.
  A tiempo $T_i$ se recibe un cupón variable de
  $
    K delta L(T_(i-1), T_i) = K c_i.
  $
  donde $c_i$ es el cupón del bono de tipo variable. A tiempo $T_i$ se pagará el interés de tipo fijo
  $
    K delta R.
  $
  El _cash flow_ resultante es a tiempo $T_i$ es
  $
    K delta [L (T_(i-1), T_i) - R]
  $
  Usando la @lem-cupon-LIBOR, para $t < T_0$ este cash flow tiene el valor
  $
    underbrace(K (p (t, T_(i-1)) - p(t, T_i)), "valor de " K delta L (T_(i-1), T_i)) - underbrace(K delta R p(t, T_i), "valor de" K delta R) = K p (t, T_(i-1)) - K (1 + delta R) p(t, T_i).
  $
  El valor total del swap sumando y reordenando la suma
  $
    Pi_"swap" (t) & = K sum_(i=1)^n [p(t, T_(i-1)) - (1 + delta R) p(t, T_i)].
  $
  Reordenando la suma se obtiene el resultado.
]

Por convención se supone que el contrato está escrito escrito a tiempo $t = 0$ y entonces tipo del swap viene dado por
$
  R = (p(0,T_0) - p(0,T_n)) / (delta sum_(i=1)^n p(0,T_i)).
$
Y si $T_0 = 0$ entonces $p(0,T_0) = 1$.

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
  caption: [_Swap_ de tipos de interés],
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

#quote(block: true, attribution: "https://en.wikipedia.org/wiki/Credit_default_swap")[
  A credit default swap (CDS) is a financial swap agreement that the seller of the CDS will compensate the buyer in the event of a debt default (by the debtor) or other credit event.
  That is, the seller of the CDS insures the buyer against some reference asset defaulting. The buyer of the CDS makes a series of payments (the CDS "fee" or "spread") to the seller and, in exchange, may expect to receive a payoff if the asset defaults.

  In the event of default, the buyer of the credit default swap receives compensation (usually the face value of the loan), and the seller of the CDS takes possession of the defaulted loan or its market value in cash. However, anyone can purchase a CDS, even buyers who do not hold the loan instrument and who have no direct insurable interest in the loan (these are called "naked" CDSs). If there are more CDS contracts outstanding than bonds in existence, a protocol exists to hold a credit event auction. The payment received is often substantially less than the face value of the loan.[2]
]

En la crisis de 2008 algunos inversores inteligentes (entre ellos Michael Burry) consiguieron retornos astronómicos.
La clave es que estos inversores fueron mucho más conscientes de la probabilidad de _default_ de estos productos de lo que el _spread_ ofrecido por los bancos les haría pagar.

Para una dramatización se recomienda la película _The Big Short_ (donde algunos nombres fueron sustituidos), basada en el libro _"The Big Short: Inside the Doomsday Machine."_.
Otras buena película sobre esta crisis es #link("https://en.wikipedia.org/wiki/Margin_Call")[_Margin Call_].

=== Opciones

Una contrato de opción, o simplemente opción es "una promesa que alcanza los requisitos de formación de contrato y limita el poder del quién promete de revocar el contrato".

Una opción de compra (_call option_) es el derecho, pero no la obligación, de comprar el activo subyacente bajo unas ciertas condiciones.
Lo contrario es una opción de venta (_put option_) que es derecho, pero no la obligación, de vender el subyacente.

Si esta operación se realiza en un instante concreto $T$ y a un precio fijado $K$ (llamado _strike_) se habla de *opciones europeas*.
Si la opción puede ejercerse en cualquier momento anterior a $T$ a un precio $K$, se habla de *opciones americanas*.
Existen muchos más tipos de opciones: asiáticas, bermúdeas, ...

En este tipo de derivados, lo que conocemos con certeza es el valor a vencimiento en función del valor del activo subyacente. Pero el valor del activo subyacente es deconocido, y tan sólo podemos modelizarlo, típicamente como una distribución de probabilidad.

El valor de no arbitraje a tiempo $t = 0$ depende fuertemente de nuestra modelización del activo subyacente, y las presentaremos más adelante.

==== Opciones call europeas

Denotaremos precio de una _call_ europea de este derecho a tiempo $t$ lo denotaremos $C_t$.
Como el lógico, si el valor del subyacente a vencimiento $S_T > K$ entonces puedo me interesará ejercer la opción, y ganaré $S_T - K$.
Si el valor es menor o igual $S_T <= K$, entonces no la ejerzo, y no ganaré nada. Esto puede escribir como que el beneficio es el valor de la call a vencimiento $C_T = (S_T - K)_+$.
Su valor hoy, que es lo que queremos fijar, es $C_0$.

Concluimos la sección con dos ejercicios sobre la TAE.
#exercise[La tasa anual equivalente#footnote[Tomado de "https://www.bbva.com/es/salud-financiera/tin-que-es-diferencias-tae/"]][
  En @sec-TAE se detalla el cálculo de la tasa anual equivalente, que incluye los gastos equiparando los _cash flows_.

  Si queremos comprar un teléfono que vale 500 euros y nos ofrecen la posibilidad de financiar en cuatro meses. En muy grande, vemos que es una financiación sin intereses, es decir, el TIN es del 0%. Los gastos de gestión, leemos en la letra pequeña, son 20 euros.

  Comprobar que la cuota mensual será de 125 euros, pero al sumar esos 20 euros de gastos de gestión (que pagaremos al principio, por ejemplo), la TAE será del 21,74%. En total, se pagarán los 500 euros del teléfono, más los 20 de gestión, por lo que la operación saldrá en 520 euros.

  Si otra entidad ofrece esa misma opción de financiación, sin gastos de gestión ni comisiones, pero con un TIN del 5%, se podría pensar al comparar un TIN con el otro que la primera opción (0% TIN) es mejor.
  Comprobar que la TAE sale aquí del 5,1%. La cuota mensual será de 126,30 euros. En total pagaremos 505,2 euros.
]

#exercise[Calculadora de la TAE][
  En @sec-TAE se detalla el cálculo de la tasa anual equivalente, que incluye los gastos equiparando los _cash flows_.
  Escribir un programa que resuelva numéricamente el problema.
]
