// LTeX: language=es

#import "../header/template.typ": *

= Introducción

// #set heading(numbering: none)

El objetivo de estas notas es introducir al alumno al "universo" de la Matemática en Mercados Financieros. Veremos quiénes brevemente quienes son los actores, cuáles son los productos, y cuáles son las ideas básica que soportan la valoración.

Al ser un curso introductorio, cubriremos solamente conceptos básicos sin entrar en algunas de las principales sutilezas, y los métodos de valoración que presentaremos están ya algo desfasados respecto al "estado del arte". Sin embargo, son el fundamento que sustenta estos métodos más nuevos.


== Activos y derivados

=== Definición
Un *activo* (_asset_) es un "objeto" con valor.
En esta asignatura trataremos sobre todo con activos financieros, que son no físicos y cuyo valor se deriva de un contrato:
- divisas: unidades monetarias imprimidas normalmente por bancos centrales. Por ejemplo el euro € de código EUR.
- acciones bursátiles: fracciones de una compañía que esta ha puesto a la venta. Por ejemplo, Apple `AAPL`
- bonos (por ejemplo estatales): compromisos de una entidad (por ejemplo el Tesoro de un estado) a pagar cantidades fijas en fechas fijas. Estos activos se consideran "seguros".
- fondo índices: es una colección de dinero cuyo objetivo es seguir unas normas prefijadas para intentar reproducir el rendimiento de alguna parte del mercado. Por ejemplo, el S&P500, IBEX35.

También hay activos no-financieros: tanto tangibles (también llamados reales) como tierra o cereales, e intangibles como patentes y propiedad intelectual.

Sobre estos activos se construyen a veces otros contratos, llamados *derivados*, que tiene 4 elementos:
- un elemento (llamado subyacente) que se puede o debe comprar o vender
- un acto futuro
- un precio al que ocurrirá la transacción futura
- una fecha futura en que ocurrirá el acto
Estos compromisos futuros habitualmente pueden ser comprados o vendidos en cualquier momento, a cualquier persona o entidad. Establecer el precio actual de estos contratos es precisamente el objetivo de esta asignatura.

Una de las ideas básicas de esta teoría el tipo de interés $r$ (expresado en %).
El caso más sencillo, es cuando hablamos de una inversión garantizada a 1 año (por ejemplo un bono) en la que el tipo de interés es tal que
$
  "dinero recibido \n el 1 de enero de 2026" = (1 + r) times "dinero invertido \n el 1 de enero de 2025."
$
En la teoría de interés con composición continua, que veremos más adelante, se reemplaza $1 + r$ por $e^(r T)$ donde $T$ es la duración del contrato.

=== Mercados #footnote[Adaptado de @Hull2015]

==== Bolsa de valores (_Exchange_)

#quote(block: true, attribution: [https://es.wikipedia.org/wiki/Bolsa_de_valores])[
  La bolsa de valores es una institución, organizada generalmente como sociedad mercantil o asociación civil, que facilita la negociación de valores mobiliarios entre inversores. Su función principal es ofrecer un espacio regulado y transparente en el que los intermediarios financieros introducen órdenes de compra y venta en nombre propio o de sus clientes, contribuyendo a la formación de precios y a la canalización del ahorro hacia la inversión productiva.

  Entre los instrumentos que se negocian en las bolsas se encuentran las acciones de sociedades anónimas, los bonos públicos y privados, los certificados, los títulos de participación y una amplia variedad de instrumentos financieros derivados.[2][3]

  Las bolsas están supervisadas por organismos reguladores de los mercados financieros, como la Comisión Nacional del Mercado de Valores (CNMV) en España, la Comisión Nacional Bancaria y de Valores (CNBV) en México o la Securities and Exchange Commission (SEC) en Estados Unidos, con el fin de garantizar la transparencia, la seguridad y la protección de los inversores.[4]
]

==== Mercado extra-bursátil (_over-the-counter_ market)

#quote(block: true, attribution: [https://es.wikipedia.org/wiki/Mercado_extrabursátil])[
  Un mercado extrabursátil, mercado over-the-counter (OTC), mercado paralelo no organizado o mercado de contratos a medida es uno donde se negocian instrumentos financieros (acciones, bonos, materias primas, swaps o derivados de crédito) directamente entre dos partes. Este tipo de negociación se realiza fuera del ámbito de los mercados organizados.
]

Tradicionalmente, los participantes en los mercados de derivados extrabursátiles se comunicaban directamente por teléfono y correo electrónico, o buscaban contrapartes para sus operaciones a través de intermediarios entre dealers. Los bancos suelen actuar como creadores de mercado (_market makers_) para los instrumentos de mayor negociación, lo que significa que están siempre dispuestos a cotizar un precio de compra —al que están dispuestos a asumir un lado de una operación con derivados— y un precio de venta —al que están dispuestos a asumir el lado contrario.

Antes de la crisis crediticia, que comenzó en 2007 y se analiza con detalle en el Capítulo 8, los mercados de derivados extrabursátiles operaban en gran medida sin regulación. Tras dicha crisis y la quiebra de Lehman Brothers, se produjo el desarrollo de numerosas regulaciones nuevas que afectan al funcionamiento de los mercados extrabursátiles. El objetivo de estas regulaciones es aumentar la transparencia de dichos mercados, mejorar la eficiencia operativa y reducir el riesgo sistémico.

=== Derivados

==== Contratos a plazo (_forward contracts_)

Un derivado relativamente simple es el contrato a plazo. Es un acuerdo para comprar o vender un activo en un momento futuro determinado a un precio determinado. Puede contrastarse con un contrato al contado, que es un acuerdo para comprar o vender un activo de forma casi inmediata. Un contrato a plazo se negocia en el mercado extrabursátil —generalmente entre dos instituciones financieras o entre una institución financiera y uno de sus clientes. Una de las partes del contrato a plazo asume una posición larga y acuerda comprar el activo subyacente en una fecha futura específica a un precio específico. La otra parte asume una posición corta y acuerda vender el activo en la misma fecha al mismo precio. Los contratos a plazo sobre divisas son muy populares. La mayoría de los grandes bancos emplean operadores tanto al contado como a plazo en el mercado de divisas. Un ejemplo de este tipo de contrato en la Tabla @table-forward-bidask

#figure(
  caption: [
    Cotizaciones al contado y a plazo del tipo de cambio USD/GBP,
    6 de mayo de 2013 (GBP = libra esterlina; USD = dólar estadounidense;
    la cotización es el número de USD por GBP).
  ],
  table(
    columns: (2fr, 1fr, 1fr),
    align: (left, center, center),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header([], [*Compra (_bid_)*], [*Venta (_sell_)*]),
    table.hline(stroke: 0.5pt),
    [Contado], [1,5541], [1,5545],
    [Plazo a 1 mes], [1,5538], [1,5543],
    [Plazo a 3 meses], [1,5533], [1,5538],
    [Plazo a 6 meses], [1,5526], [1,5532],
    table.hline(stroke: 1pt),
  ),
)<table-forward-bidask>


=== Contratos a futuro (_futures_)

Al igual que un contrato a plazo, un contrato de futuros es un acuerdo entre dos partes para comprar o vender un activo en un momento futuro determinado a un precio determinado. A diferencia de los contratos a plazo, los contratos de futuros se negocian habitualmente en un mercado organizado. Para facilitar la negociación, la bolsa establece ciertas características estandarizadas del contrato. Dado que las dos partes contratantes no se conocen necesariamente entre sí, la bolsa también proporciona un mecanismo que ofrece a ambas partes la garantía de que el contrato será cumplido.

Su valoración es similar a la de un futuro, y por tanto no los trataremos en estas notas.

=== Opciones

Una opción es el derecho, pero no la obligación, de comprar (o vender) un activo a un precio y en un momento (que puede ser una fecha o cuando se satisfagan unas condiciones).


== Tipos de _traders_

==== _Hedgers_

==== Especuladores

==== _Arbitrageurs_

#example(breakable: true)[Arbitraje para un contrato _forward_][
  Nuestra primera introducción al concepto de arbitraje tiene que ver con el precio justo de un contrato _forward_.
  Supongamos que podemos pedir prestado dinero $S_0$ es el valor actual de un activo, es decir, por cada € que pida prestado hoy he devolver $e^(r T)$€ al vencimiento del contrato. Supongamos que el contrato tiene un strike $F_0$, al que se produce la venta del activo. Normalmente los contratos forward se hacen sin pagar nada el día que se firman.

  A vencimiento, si soy el vendedor del contrato, debo honrarlo. Para ello, debo vender a quien tiene el contrato, el activo al precio pacto.
  Por ejemplo, si no tengo el activo debo comprarlo en el mercado (pagando $S_T$) y venderlo a mi contrapartido del _forward_ al precio $F_0$. De modo que en mi balance contable resulta en $F_0 - S_T$. Si este valor es positivo gano dinero, si es negativo lo pierdo. Pero lo importante es saber si consigo salir de la operación completa ganando dinero. Para ello, hay que pensar cuál es el valor justo $F_0$ y qué puedo hacer en cada caso.

  Argumentamos que si $F_0 != S_0 e^(r T)$ entonces se puede ganar dinero sin riesgo, esto es lo que se conoce como arbitraje.

  Si alguien está dispuesto a entrar con nosotros en un contrato a futuro donde $F_0 > S_0 e^(r T)$, entonces hoy podemos pedir prestado el dinero, y comprar el activo.
  Mantenemos el activo en nuestra posesión hasta el vencimiento del contrato, y liquidamos la operación ¡con beneficio!
  El resultado contable es la @table-forward-arbitrage1. El resultado es que _independientemente del valor $S_T$_ gano dinero seguro. Además, he hecho la operación sin "poner" dinero. Este efecto es el conocido como arbitraje.
  #figure(
    table(
      columns: (auto, auto, auto),
      table.header([*Transacción*], [*Pago ahora (€) \ $t = 0$*], [*Pago bencimiento (€) \ $t = T$*]),
      [Comprar el contrato], [#text(fill: red)[0]], [$F_0 - S_T$ \ (positivo o negativo)],
      [Comprarel activo], [-#text(fill: red)[$S_0$]], [$S_T$],
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
  De modo que el precio libre de arbitraje es
  $F_0 = S_0 e^(r T).$
  Por supuesto, esto asume que el precio del contrato _forward_ es el mismo al comprarlo que al venderlo (esto es falso), y que podemos pedir prestado o prestar dinero al mismo precio (también falso). Sin embargo, es una aproximación suficientemente buena para gran parte del análisis.
]<example-arbitrage-forward>




== Modelización el precio de activos: procesos estocásticos

El mercado contiene una serie de activos de diferentes tipos que ya hemos presentado: acciones, bonos, opciones, ...
Habitualmente denotamos por $S_t$ al valor de un activo a tiempo $t$.
Modelizar la evolución valor de los activos de riesgo, $S_t$, es el problema más difícil en Matemática Financiera. Dado que en este valor influyen muchos factores que no somos capaces de modelizar, pensaremos que el valor tiene una componente estocástica. Así, usaremos nociones de procesos estocásticos.

=== Precio del activo subjacente
Consideremos un activo muy sencillo descrito mediante
Supongamos que el valor del activo a tiempo $T$ sólo puede subir por un factor $u$ con cierta probabilidad $p$ o bajar por un factor $d$, es decir
$
  bb(P)(S_T = u S_0) = p " y " bb(P)(S_T = d S_0) = 1-p
$

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="S_0"]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="u S_0"]
  s2[label="d S_0"]
  }
  ```),
  caption: "Modelo discreto con un periodo de tiempo",
)<fig:binomial>

Esto nos permitirá hacer algunas interesantes y pasar al límite hacia un modelo más realista, donde $S_(t+Delta t)/S_t$ viene dada por una log-normal.

#figure(
  image("05-figuras/lognormality.pdf", width: 75%),
  caption: "Los log-incrementos del S&P500 ajustados a una normal",
)<fig-BlackScholes-lognormality-of-returns>

=== Carteras de inversión (_portfolios_)

Una cartera es una combinación de diferentes activos en diferentes cantidades.
Puede estar compuesta de activos subyacentes y derivados.
Por ejemplo: 5 acciones de IBM, 1 bono del Tesoro, y una opción europeas de compra de 5 acciones de Microsoft.
Lo normal es que estas cantidades cambien con el tiempo.
Se suele expresar $theta^((i))_t$ denota la cantidad del activo $i$-ésimo a tiempo $t$.
Si llamamos $S_t^((i))$ al valor del activo $i$-ésimo en tiempo $t$, el valor de la cartera se escribe como
$
  V_t := sum_(i=1)^N theta_t^((i)) dot S_t^((i)).
$
Según el momento trabajaremos con tiempo $t$ discreto o continuo.

=== El tiempo
En finanzas, la unidad de tiempo es el año.
Sin embargo si no se precisa más, esto resulta ambiguo:
- ¿Cuántos días tiene un año?
- ¿Qué pasa con los bisiestos?
- ¿Cuánto son 6 meses?

Para evitar esta y otras ambigüedades, los mercados financieros usan reglas como la 30/360 (bonos municipales y corporativos en USA). Ver
#quote(block: true)[#link("https://en.wikipedia.org/wiki/Day_count_convention").]

Por ejemplo, uno de los componentes de esta cuenta $D_1/M_1/Y_1$ y $D_2/M_2/Y_2$ se calcula
$
  "DayCountFactor" = (360 times (Y_2-Y_1) + 30 times (M_2 - M_1) + (D_2-D_1))/360
$
El resultado, natural, queda expresado en años.

== Ejercicios

#exercise_list[
  + ¿Cuantos años hay entre el 30/11/06 y el 01/03/08? <ex-primero>

  + El 1 de enero de 2007, invirtió 1000€ en su libreta. El 1 de enero de 2008 el banco le informa que ha recibido 40€ de intereses a lo largo del año.
    - ¿Cuales son los intereses brutos asociados?
    - ¿Qué intereses recibirá a lo largo de 2008?
    - ¿Cuánto habría recibido de haber cerrado su cuenta el 1 de julio.

  + Ordenar de menor a mayor los siguientes tipos de interés:
    - 6% anual;
    - 0,5% mensual;
    - 30% por 5 años;
    - 10% el primer año y 4% los dos siguientes.

  + Responder a las siguientes preguntas:
    - Dado un tipo del 10% compuesto semianualmente, ¿Cuál es el tipo continuo equivalente?
    - Un prestamista pretende conseguir el 8% continuo y cobra trimestralmente. ¿Cuál es el tipo anual para composición trimestral equivalente?
]
#exercise_ref(<ex-primero>)
