// LTeX: language=es

#import "../header/template.typ": *

= Instrumentos y mercados financieros

// Instrumentos y mercados financieros. Bonos, acciones, contratos a plazo, swaps. Opciones europeas y americanas, otros derivados.

== Activos subyacentes

=== Acciones

#quote(block: true, attribution: [Traducido de https://en.wikipedia.org/wiki/Stock])[
  Las acciones (_stocks_ o _shares_) son las partes en las que se divide la propiedad de una sociedad o compañía. Una acción representa la propiedad de una fracción de la compañía, en proporción al número total de acciones. Esto suele dar derecho al accionista a esa fracción de los beneficios de la compañía, de lo obtenido en la liquidación de sus activos (una vez satisfechas las deudas, garantizadas o no) o del poder de voto, repartidos habitualmente en proporción al número de acciones del mismo tipo que posea. No todas las acciones son necesariamente iguales: pueden emitirse distintas clases de acciones, por ejemplo sin derecho a voto, con derecho a voto reforzado o con prioridad para recibir beneficios o el producto de la liquidación antes o después que otras clases de accionistas.

  Las acciones pueden comprarse y venderse de manera privada o en bolsas de valores. Las transacciones de este último tipo están estrechamente supervisadas por los gobiernos y los organismos reguladores para prevenir el fraude, proteger a los inversores y beneficiar al conjunto de la economía. Cuando una compañía emite nuevas acciones, la propiedad y los derechos de los accionistas existentes se diluyen a cambio de efectivo para sostener o hacer crecer el negocio. Las compañías también pueden recomprar acciones, lo que a menudo permite a los inversores recuperar la inversión inicial más las plusvalías derivadas de las subidas posteriores del precio. Las opciones sobre acciones que muchas compañías entregan a sus empleados como parte de su remuneración no representan propiedad, sino el derecho a comprar acciones en un momento futuro a un precio fijado. Esto supondría una ganancia para los empleados si la opción se ejerciera cuando el precio de mercado fuera superior al precio prometido, ya que, vendiendo inmediatamente las acciones, se quedarían con la diferencia (descontados los impuestos).
]

#figure(
  image("../figures/Compania_Guipuzcoana_Accion_2124_Madrid_1_junio_1752.jpg"),
  caption: [Acción n.º 2124 de la Real Compañía Guipuzcoana de Caracas a favor de Doña Juana de Ortega. Madrid, 1 de junio de 1752. #link("https://commons.wikimedia.org/wiki/File:Compania_Guipuzcoana_Accion_2124_Madrid_1_junio_1752.jpg")[Wikipedia]. Ver más certificados de acción en: #link("https://commons.wikimedia.org/wiki/Stock_certificates")[link]],
)

Cuando las acciones son públicas, se les asigna un _ticker_ (por ejemplo Apple, Inc. es `AAPL`).
Por ejemplo, en junio de 2026 Apple contaba con $14 thin 673 thin 278 thin 000$ acciones (ver #link("https://companiesmarketcap.com/apple/shares-outstanding/")[fuente]) a un precio de 307.34\$ cada una. Esto hace que estuviera valorada en unos 4.5 billones de dólares americanos (es decir, $4.5 times 10^12$ dólares, lo que en inglés se denomina _4.5 trillion_).
Modelizar la evolución del precio de las acciones es una de las tareas más difíciles de la Matemática Financiera.

=== Índices del mercado de acciones  (_stock market index_)

#quote(block: true, attribution: [Traducido de https://en.wikipedia.org/wiki/Stock_market_index])[
  En finanzas, un índice bursátil es un índice que mide el rendimiento de un mercado de acciones, o de una parte de él. Ayuda a los inversores a comparar los niveles de precios actuales con los pasados para calcular el rendimiento del mercado.

  Dos de los criterios principales de un índice son que sea invertible y transparente: los métodos de su construcción están especificados. Los inversores pueden invertir en un índice bursátil comprando un fondo indexado, que se estructura como un fondo de inversión o como un fondo cotizado (_exchange-traded fund_) y que «sigue» al índice. La diferencia entre el rendimiento de un fondo indexado y el del índice, si existe, se llama error de seguimiento (_tracking error_).
]

Algunos ejemplos son el S&P500 (ticker `^SPX`) o el Euro Stoxx 50 (`^SX5E`).

=== Bonos de renta fija#footnote[En esta sección seguimos la notación de #cite(<bjorkArbitrageTheoryContinuous2019>, form: "prose")]


#quote(block: true, attribution: [Traducido de https://en.wikipedia.org/wiki/Bond_(finance)])[
  En finanzas, un bono es un tipo de valor por el cual el emisor (deudor) contrae una deuda con el tenedor (acreedor) y está obligado, según los términos del contrato, a proporcionarle un flujo de caja, que normalmente consiste en devolver el principal (la cantidad prestada) en la fecha de vencimiento, así como unos intereses (llamados cupones) durante un periodo de tiempo determinado.

  Un inversor que posee un bono ordinario recibe ingresos por el pago de los cupones, que se realizan semestral o anualmente. El inversor también recibe el principal o valor nominal de la inversión cuando el bono vence.
]

Ejemplos son los emitidos por el #link("https://home.treasury.gov")[_US Treasury_] o por el Tesoro Público español, en letras y bonos (_Treasury bills_ y _Treasury bonds_). Estos son los instrumentos usados por los Gobiernos para pedir dinero prestado en su propia moneda.
Se suele asumir que los gobiernos no llegarán a impago (_default_), de manera que se asume que estos tipos de interés son libres de riesgo.

#quote(block: true, attribution: [Traducido de https://en.wikipedia.org/wiki/Zero-coupon_bond])[
  Un bono cupón cero (también llamado bono al descuento) es un bono en el que el valor nominal se devuelve en el momento del vencimiento. A diferencia de los bonos ordinarios, no realiza pagos periódicos de intereses, es decir, no tiene cupones; de ahí el nombre de bono cupón cero. Cuando el bono llega a su vencimiento, el inversor recibe su valor nominal. Ejemplos de bonos cupón cero son las letras del Tesoro de EE. UU., los bonos de ahorro de EE. UU., los bonos cupón cero a largo plazo y cualquier bono con cupón al que se le hayan separado los cupones.
]

En España: Letras y bonos del Tesoro.
#figure(
  // placement: bottom,
  image("../figures/bono-tesoro.jpg", width: 70%),
  caption: [Bono del Tesoro Español. Fuente: #link("https://bidkit.ams3.digitaloceanspaces.com/34/imgBig/50/2623.jpg")[link]],
)

==== Bono de cupón fijo

#definition[Bono de cupón fijo][
  Bono con cupones $c_i$ a tiempo $T_i$, vencimiento $T_n$ y principal $K$ es un bono que
  - En cada fecha $T_i$ emite un cupón (pago) de $c_i$.
  - A tiempo $T_n$ se recibe el cupón correspondiente y el principal.
  Ocasionalmente, el cupón se expresa en términos de los retornos
  $
    c_i = r_i (T_i - T_(i-1)) K.
  $
  En los cupones más estándar el tiempo $T_i = i delta$ y los tipos del cupón son iguales $r_i = r$.
]

==== Valoración de un bono de cupón fijo #footnote[Los ejemplos de esta sección están tomados de #cite(<Hull2015>, form: "prose")]

Al igual que pasa con los contratos a plazo, el precio de un bono con cupón fijo debe ser, si $t < T_1$
$
  p_"fijo" (t) = sum_(i=1)^(n) c_i p(t, T_i) + K p(t, T_n).
$<eq-bonocuponfijo>

#exercise[
  Supongamos que encontramos en el mercado un bono con $T_1 = 0.5$, vencimiento $T_2 = 1$ y cupón fijo $c_1 > 0$ y que no satisface la fórmula @eq-bonocuponfijo. Utilizar bonos cupón cero (ver @def-bonocuponcero) para crear una estrategia de arbitraje.
]

#example[Valoración de bono de cupón fijo][
  Supongamos que conocemos los tipos cero para composición continua como en la @table-interes-tiposzerotesoro (que más adelante veremos cómo calcular)
  #figure(
    table(
      columns: (auto, auto),
      table.header([*Vencimiento \ (años)*], [*Rendimiento cupón cero \ con composición continua* $R(0, T)$\ (%)]),
      [0.5], [5.0],
      [1.0], [5.8],
      [1.5], [6.4],
      [2.0], [6.8],
    ),
    caption: "Tipos cero del Tesoro",
  )<table-interes-tiposzerotesoro>
  Supongamos un bono cuyo principal es de $100$\$ con un cupón del 6% semestral (es decir $r_i = 6%$ y $T_i - T_(i-1) = 0.5$). Es decir, cada 6 meses recibimos un cupón de 3\$.
  El precio actual del bono es
  $
    p(t) & = underbrace(3, "primer cupón") underbrace(e^(-underbrace(0.050, "tipo") times underbrace(0.5, "6 meses")), "descontando") + 3 e^(-0.058 times 1.0) + 3 e^(-0.064 times 1.5)
           + (underbrace(100, "principal") + 3) e^(-0.068 times 2.0) \
         & = 98.39
  $]

==== Rendimiento del bono hasta el vencimiento

El rendimiento de un bono es el tipo de descuento que da el mismo valor. Es decir, $y$ tal que
$
  p_"fijo" (t) = sum_(i=1)^n c_i e^(-y (T_i - t)).
$
En el ejemplo
$
  3 e^(-y times 0.5)+ 3 e^(-y times 1.0) + 3 e^(-y times 1.5)
  + (100 + 3) e^(-y times 2.0) = 98.39
$
Esta ecuación no admite una solución sencilla, pero claramente el lado izquierdo es monótono en $y$. Se puede resolver con algún método numérico, por ejemplo, bisección. En este caso $y = 6.76%$.

=== Cálculo de la curva cupón cero o _yield curve_

Lo habitual es "deducir" la curva cupón cero a partir de los valores de distintos productos. Hay diferentes métodos para hacer este cálculo. A continuación presentamos un ejemplo sencillo.

#example(
  breakable: true,
)[Cálculo del rendimiento de cupón cero a partir de bonos de cupón fijo#footnote[El ejemplo de esta sección está tomado de #cite(<Hull2015>, form: "prose")]][
  Para construir los valores de la @table-interes-tiposzerotesoro se utilizan los pagos que hacen distintos tipos de bonos.
  Hay diferentes formas de hacer este cálculo, pero vamos a  hablar del método _bootstrap_. La idea es ir utilizando bonos de menor duración para ir fijando $R(T) := R(0, T)$ a cada periodo $T$.
  Por ejemplo, pensemos que tenemos los bonos de la @table-interes-bootstrap. En cada caso, igualamos el valor actual del bono al valor actual (o valor descontado) de todos los pagos recibidos.

  Para el bono de 3 meses (0.25 años), calculamos
  $
    100 times e^(- R(0.25) times 0.25) = 97.5.
  $
  De donde $R(0.25) = 10.127%$. Los de 6 meses y un año nos dan $R(0.5) = 10.469%$ y $R(1.0) = 10.536%$.

  El cuarto bono dura 1.5 años. Y paga lo que sigue:
  - 6 meses: 4\$
  - 1 año: 4\$
  - 1.5 años: 104\$
  Para los dos primeros plazos podemos usar las fórmulas de descuento anteriores, y solo nos queda la última por despejar
  $
    4e^(-0.10469 times 0.5) + 4 e^(-0.10536 times 1.0) + 104 e^(-R(1.5) times 1.5) = 96.
  $
  Despejando obtenemos $R(1.5)=10.681%$.

  #figure(
    placement: auto,
    table(
      columns: (auto, auto, auto, auto),
      table.header([Principal\ (\$)], [Duración \ (años)], [Cupón anual \ (\$)], [Precio del bono\ (\$)]),
      [100], [0.25], [0], [97.5],
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

=== Bonos de interés variable

Hay diferentes tipos de bonos en los que el tipo de interés no se fija cuando se emite el bono, sino que se fija en cada periodo de cupón. Habitualmente esto se hace a través de algún _benchmark_ financiero, como el LIBOR o el euríbor.


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
  Pongamos por ejemplo el caso del LIBOR. Entonces el cupón $i$-ésimo se fija a tiempo $T_i$ como
  $
    c_i = (T_i - T_(i-1)) L(T_(i-1), T_i) K
  $
  donde $L(T_(i-1), T_i)$ es el spot del LIBOR, fijado a fecha $T_(i-1)$, pero el cupón no se cobra hasta tiempo $T_i$.
  Usando la definición
  $
    c_i = delta (1 - p(T_(i-1), T_i))/(delta p(T_(i-1), T_i)) = 1 / p(T_(i-1), T_i) - 1.
  $
  La siguiente estrategia permite calcular $1/p(T_(i-1), T_i)$:
  - A tiempo $t$ compramos un bono con vencimiento $T_(i-1)$, que cuesta $p(t, T_(i-1))$\$.
  - A tiempo $T_(i-1)$ esto da 1\$.
  - Dedicamos este dólar a comprar bonos con vencimiento $T_i$, es decir obtenemos $1/p(T_(i-1), T_i)$.
  - A tiempo $T_i$ recibimos 1\$ por cada bono, es decir $1/p(T_(i-1), T_i)$\$.
  Así, invirtiendo $p(t, T_i)$\$ a tiempo $t$ se obtienen $1/p(T_(i-1), T_i)$ \$ a tiempo $T_i$. Luego este es el valor de no arbitraje de la inversión.
]
Así deducimos que el valor a tiempo $t$ del bono con tipo variable LIBOR es
$
  p_"var" (t) = p(t, T_n) + sum_(i=1)^n [p(t, T_(i-1)) - p(t, T_i)] = p(t, T_0).
$<eq-bonolibor>
Es decir $p_"var" (0) = 1$.

#exercise[][
  Deducir @eq-bonolibor directamente
  construyendo una cartera autofinanciada que reproduzca el precio del bono de tipo variable.
]

== Derivados

=== Contrato a plazo (_forward contract_) <example-arbitrage-forward>

#definition[_Contrato a plazo_][
  Compromiso (derecho y obligación) de intercambiar un activo a un precio $F_0$, llamado _strike_, en una fecha de vencimiento dada $T$.
  Este contrato se realiza sin intercambio de dinero o activos el día de la firma.
]

Si denotamos por $S_0$ el precio actual del activo, y $r$ es el interés de cupón cero para ese periodo (es decir $e^(-r T) = p(0,T)$), veamos que la condición de no arbitraje es equivalente a que
$
  F_0 = S_0 e^(r T).
$
<eq-forward>

Supongamos que $S_0$ es el valor actual de un activo y que podemos pedir dinero prestado, es decir, por cada € que pida prestado hoy he de devolver $e^(r T)$€ al vencimiento del contrato. Supongamos que el contrato tiene un strike $F_0$, al que se produce la venta del activo.

A vencimiento, si soy el vendedor del contrato, debo honrarlo. Para ello, debo vender a quien tiene el contrato, el activo al precio pactado.
Por ejemplo, si no tengo el activo debo comprarlo en el mercado (pagando $S_T$) y venderlo a mi contraparte del _forward_ al precio $F_0$. De modo que en mi balance contable resulta en $F_0 - S_T$. Si este valor es positivo gano dinero, si es negativo lo pierdo. Pero lo importante es saber si consigo salir de la operación completa ganando dinero. Para ello, hay que pensar cuál es el valor justo $F_0$ y qué puedo hacer en cada caso.

Argumentamos que si $F_0 != S_0 e^(r T)$ entonces se puede ganar dinero sin riesgo.

Si alguien está dispuesto a entrar con nosotros en un contrato a plazo con $F_0 > S_0 e^(r T)$, entonces hoy podemos pedir prestado el dinero, y comprar el activo.
Mantenemos el activo en nuestra posesión hasta el vencimiento del contrato, y liquidamos la operación ¡con beneficio!
El resultado contable se muestra en la @table-forward-arbitrage1. El resultado es que _independientemente del valor $S_T$_ gano dinero seguro. Además, he hecho la operación sin "poner" dinero. Este efecto es el conocido como arbitraje.
#figure(
  table(
    columns: (auto, auto, auto),
    table.header([*Transacción*], [*Pago ahora (€) \ $t = 0$*], [*Pago a vencimiento (€) \ $t = T$*]),
    [Comprar el contrato], [#text(fill: red)[0]], [$F_0 - S_T$ \ (positivo o negativo)],
    [Comprar el activo], [$-$#text(fill: red)[$S_0$]], [$S_T$],
    [Pedir prestado], [+$S_0$], [$-$#text(fill: red)[$S_0 e^(r T)$]],
    table.hline(stroke: 3pt),
    [Total], [0], [$F_0 - S_0 e^(r T)$],
  ),
  caption: [Arbitraje en un contrato forward si $F_0 > S_0 e^(r T)$. Cada casilla representa el apunte contable correspondiente (donde negro significa ingreso, y rojo significa gasto).],
)<table-forward-arbitrage1>
Por contra, si hubiese alguien dispuesto a hacer el contrato con $F_0 < S_0 e^(r T)$ podría hacer la operación inversa, como detalla la @table-forward-arbitrage2.
#figure(
  table(
    columns: (auto, auto, auto),
    table.header([*Transacción*], [*Pago ahora (€) \ $t = 0$*], [*Pago a vencimiento (€) \ $t = T$*]),
    [Vender el contrato], [#text(fill: black)[0]], [$-$#text(fill: red)[$(S_T - F_0)$]],
    [Comprar el activo], [#text(fill: black)[$S_0$]], [$-$#text(fill: red)[$S_T$]],
    [Prestar \
      a un tercero],
    [$-$#text(fill: red)[$S_0$]],
    [#text(fill: black)[$S_0 e^(r T)$]],
    table.hline(stroke: 3pt),
    [Total], [0], [$S_0 e^(r T) - F_0$],
  ),
  caption: [Arbitraje en un contrato forward si $F_0 < S_0 e^(r T)$. Cada casilla representa el apunte contable correspondiente (donde negro significa ingreso, y rojo significa gasto).],
)<table-forward-arbitrage2>
De modo que el precio libre de arbitraje es @eq-forward.

Por supuesto, esto asume que el precio del contrato _forward_ es el mismo al comprarlo que al venderlo (esto es una simplificación excesiva), y que podemos pedir prestado o prestar dinero al mismo precio (también falso). Sin embargo, es una aproximación suficientemente buena para gran parte del análisis.

Cuando hay dividendo a tasa $q$ entonces la fórmula resulta
$
  F_0 = S_0 e^((r-q) T).
$
Si $r$ es constante entonces el precio de un futuro (_future_) es el mismo que el de un _forward_, aunque la justificación es complicada; ver #cite(<Hull2015>, form: "prose").

#exercise(breakable: true)[Forward rate agreement][
  En este contrato, en el que por convención se entra en $t = 0$, dos partes (prestamista o _lender_ y prestatario o _borrower_) acuerdan el préstamo de un principal $K$ con un tipo de interés $R^*$ en un periodo futuro $[T_1, T_2]$. Asumiendo que el tipo de composición es continuo, el _cash flow_ del prestamista es el siguiente:
  - A tiempo $T_1$: $-K$
  - A tiempo $T_2$: $K e^(R^* (T_2 - T_1))$.
  El _cash flow_ del prestatario es, por supuesto, el opuesto. Se pide:
  + Calcular el precio de este contrato, $Pi(t)$ para un tiempo $t < T_1$ dado en función del precio de cupón cero.
  + Demostrar que si $Pi(0) = 0$ entonces el tipo $R^*$ coincide con el tipo _forward_ con composición continua
    $
      R(0; T_1, T_2) := - (log p(0, T_2) - log p(0, T_1)) / (T_2 - T_1).
    $
]

=== _Swaps_

Una permuta financiera o swap es un contrato por el cual dos partes se comprometen a intercambiar una serie de cantidades de dinero en fechas futuras, fijando también la forma en que se calcularán dichas cantidades.

El derivado más popular es el _swap_ de tipos de interés, en el que el LIBOR se intercambia por un tipo fijo.
Vamos a considerar el caso en el que el interés se paga con atraso.

#proposition[
  El valor de un swap de principal $K$ firmado a tiempo $T_0$ con cupones en tiempos $T_i = T_0 + i delta$, en el que se entrega tipo fijo $R$ y se recibe tipo variable LIBOR, tiene el valor a tiempo $t < T_0$
  $
    Pi(t) = K p(t, T_0) - K sum_(i=1)^n d_i p (t, T_i) " donde "
    d_i = cases(
      R delta & "si" i=1 comma dots.c comma n-1,
      1 + R delta & "si" i = n.
    )
  $
]

#proof[
  El cálculo consiste en valorar a tiempo $t$ el _cash flow_ total.
  A tiempo $T_i$ se recibe un cupón variable de
  $
    K delta L(T_(i-1), T_i) = K c_i.
  $
  donde $c_i$ es el cupón del bono de tipo variable. A tiempo $T_i$ se pagará el interés de tipo fijo
  $
    K delta R.
  $
  El _cash flow_ resultante a tiempo $T_i$ es
  $
    K delta [L (T_(i-1), T_i) - R]
  $
  Usando la @lem-cupon-LIBOR, para $t < T_0$ este cash flow tiene el valor
  $
    underbrace(K (p (t, T_(i-1)) - p(t, T_i)), "valor de " K delta L (T_(i-1), T_i)) - underbrace(K delta R p(t, T_i), "valor de" K delta R) = K p (t, T_(i-1)) - K (1 + delta R) p(t, T_i).
  $
  El valor total del swap se obtiene sumando
  $
    Pi_"swap" (t) & = K sum_(i=1)^n [p(t, T_(i-1)) - (1 + delta R) p(t, T_i)].
  $
  Reordenando la suma se obtiene el resultado.
]

Por convención se supone que el contrato está escrito a tiempo $t = 0$ y entonces el tipo del swap viene dado por
$
  R = (p(0,T_0) - p(0,T_n)) / (delta sum_(i=1)^n p(0,T_i)).
$
Y si $T_0 = 0$ entonces $p(0,T_0) = 1$.

==== Ejemplo: permuta de tipos de interés #footnote[Tomado de #cite(<Hull2015>, form: "prose")]


Consideremos un hipotético _swap_ a 3 años iniciado el 5 de marzo de 2014 entre Microsoft e Intel. Supongamos que Microsoft acuerda pagar a Intel un tipo de interés del 5% anual sobre un principal de 100 millones de dólares y, a cambio, Intel acuerda pagar a Microsoft el tipo LIBOR a 6 meses sobre el mismo principal. Microsoft es el pagador de tipo fijo e Intel el pagador de tipo variable. Suponemos que el acuerdo especifica que los pagos se intercambian cada 6 meses y que el tipo del 5% se cotiza con composición semestral. Este _swap_ se representa en la @fig-intelmicrosoftswap.
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  // node[math=true, xmath=true]
  // edge[lmath=true]
  i[label="Intel"]
  m[label="Microsoft"]
  m -> i[label="5%"]
  i -> m[label="LIBOR"]
  }
  ```),
  caption: [_Swap_ de tipos de interés],
)<fig-intelmicrosoftswap>

En la @fig-intelmicrosoftswap-flows se detallan los intercambios monetarios.
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (left, center, center, center, center),
    stroke: 0.5pt,

    // Header
    table.header(
      [*Fecha*],
      [*LIBOR a 6 meses\ (%)*],
      [*Flujo variable\ recibido*],
      [*Flujo fijo\ pagado*],
      [*Flujo neto*],
    ),

    // Data rows
    [5 mar. 2014], [4.20], [], [], [],
    [5 sept. 2014], [4.80], [+2.10], [$-$2.50], [$-$0.40],
    [5 mar. 2015], [5.30], [+2.40], [$-$2.50], [$-$0.10],
    [5 sept. 2015], [5.50], [+2.65], [$-$2.50], [+0.15],
    [5 mar. 2016], [5.60], [+2.75], [$-$2.50], [+0.25],
    [5 sept. 2016], [5.90], [+2.80], [$-$2.50], [+0.30],
    [5 mar. 2017], [], [+2.95], [$-$2.50], [+0.45],
  ),
  caption: [Flujos de caja (en millones de dólares) para Microsoft en un _swap_ de tipos de interés a 3 años sobre un principal de 100 millones de dólares, en el que se paga un tipo fijo del 5% y se recibe LIBOR.],
)<fig-intelmicrosoftswap-flows>

===== ¿Por qué este swap?

Hay diferentes motivos para hacer esto. Uno de ellos sería convertir un tipo variable en un tipo fijo.

==== La crisis de 2008: _credit default swaps_

#quote(block: true, attribution: [Traducido de https://en.wikipedia.org/wiki/Credit_default_swap])[
  Una permuta de incumplimiento crediticio (_credit default swap_, CDS) es un acuerdo de permuta financiera por el que el vendedor del CDS compensará al comprador en caso de impago de una deuda (por parte del deudor) u otro evento de crédito.
  Es decir, el vendedor del CDS asegura al comprador frente al impago de cierto activo de referencia. El comprador del CDS realiza una serie de pagos (la «prima» o _spread_ del CDS) al vendedor y, a cambio, espera recibir un pago si el activo entra en impago.

  En caso de impago, el comprador del CDS recibe una compensación (habitualmente el valor nominal del préstamo) y el vendedor del CDS toma posesión del préstamo impagado o de su valor de mercado en efectivo. Sin embargo, cualquiera puede comprar un CDS, incluso compradores que no posean el préstamo y que no tengan ningún interés asegurable directo en él (los llamados CDS «desnudos»). Si hay más contratos CDS en circulación que bonos existentes, hay un protocolo para celebrar una subasta de evento de crédito. El pago recibido suele ser bastante menor que el valor nominal del préstamo.
]

En la crisis de 2008 algunos inversores inteligentes (entre ellos Michael Burry) consiguieron retornos astronómicos.
La clave es que estos inversores fueron mucho más conscientes de la probabilidad de _default_ de estos productos de lo que el _spread_ ofrecido por los bancos les haría pagar.

Para una dramatización se recomienda la película _The Big Short_ (donde algunos nombres fueron sustituidos), basada en el libro _The Big Short: Inside the Doomsday Machine_.
Otra buena película sobre esta crisis es #link("https://en.wikipedia.org/wiki/Margin_Call")[_Margin Call_].

=== Opciones

Un contrato de opción, o simplemente opción, es "una promesa que alcanza los requisitos de formación de contrato y limita el poder de quien promete de revocar el contrato".

Una opción de compra (_call option_) es el derecho, pero no la obligación, de comprar el activo subyacente bajo unas ciertas condiciones.
Lo contrario es una opción de venta (_put option_) que es el derecho, pero no la obligación, de vender el subyacente.

Si esta operación se realiza en un instante concreto $T$ y a un precio fijado $K$ (llamado _strike_) se habla de *opciones europeas*.
Si la opción puede ejercerse en cualquier momento anterior a $T$ a un precio $K$, se habla de *opciones americanas*.
Existen muchos más tipos de opciones: asiáticas, bermudas, ...

En este tipo de derivados, lo que conocemos con certeza es el valor a vencimiento en función del valor del activo subyacente. Pero el valor del activo subyacente es desconocido, y tan solo podemos modelizarlo, típicamente como una distribución de probabilidad.

El valor de no arbitraje a tiempo $t = 0$ depende fuertemente de nuestra modelización del activo subyacente, y la presentaremos más adelante.

==== Opciones call europeas

Denotaremos por $C_t$ el precio a tiempo $t$ de una _call_ europea.
Como es lógico, si el valor del subyacente a vencimiento $S_T > K$ entonces me interesará ejercer la opción, y ganaré $S_T - K$.
Si el valor es menor o igual $S_T <= K$, entonces no la ejerzo, y no ganaré nada. Esto se puede escribir como que el beneficio es el valor de la call a vencimiento $C_T = (S_T - K)_+$.
Su valor hoy, que es lo que queremos fijar, es $C_0$.

Concluimos la sección con dos ejercicios sobre la TAE.
#exercise[La tasa anual equivalente#footnote[Tomado de #link("https://www.bbva.com/es/salud-financiera/tin-que-es-diferencias-tae/")]][
  En el @sec-TAE se detalla el cálculo de la tasa anual equivalente, que incluye los gastos equiparando los _cash flows_.

  Si queremos comprar un teléfono que vale 500 euros y nos ofrecen la posibilidad de financiar en cuatro meses. En letra muy grande, vemos que es una financiación sin intereses, es decir, el TIN es del 0%. Los gastos de gestión, leemos en la letra pequeña, son 20 euros.

  Comprobar que la cuota mensual será de 125 euros, pero al sumar esos 20 euros de gastos de gestión (que pagaremos al principio, por ejemplo), la TAE será del 21.74%. En total, se pagarán los 500 euros del teléfono, más los 20 de gestión, por lo que la operación saldrá en 520 euros.

  Si otra entidad ofrece esa misma opción de financiación, sin gastos de gestión ni comisiones, pero con un TIN del 5%, se podría pensar al comparar un TIN con el otro que la primera opción (0% TIN) es mejor.
  Comprobar que la TAE sale aquí del 5.1%. La cuota mensual será de 126.30 euros. En total pagaremos 505.2 euros.
]

#exercise[Calculadora de la TAE][
  En el @sec-TAE se detalla el cálculo de la tasa anual equivalente, que incluye los gastos equiparando los _cash flows_.
  Escribir un programa que resuelva numéricamente el problema.
]
