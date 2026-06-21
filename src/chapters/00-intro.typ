// LTeX: language=es

#import "../header/template.typ": *

= Introducción

// #set heading(numbering: none)

El objetivo de estas notas es introducir al alumno al "universo" de la Matemática en Mercados Financieros. Veremos quiénes brevemente quienes son los actores, cuáles son los productos, y cuáles son las ideas básica que soportan la valoración.

Al ser un curso introductorio, cubriremos solamente conceptos básicos sin entrar en algunas de las principales sutilezas, y los métodos de valoración que presentaremos están ya algo desfasados respecto al "estado del arte". Sin embargo, son el fundamento que sustenta estos métodos más nuevos.


== Productos financieros

A continuación vamos a introducir informalmente algunos de los conceptos con los que trabajaremos en la asignatura.

=== Activos
Un *activo* (_asset_) es un "objeto" con valor.
En esta asignatura trataremos sobre todo con activos financieros, que son no físicos y cuyo valor se deriva de un contrato:
- divisas: unidades monetarias imprimidas normalmente por bancos centrales. Por ejemplo el euro € de código EUR.
- acciones bursátiles: fracciones de una compañía que esta ha puesto a la venta. Por ejemplo, Apple `AAPL`
- bonos: compromisos de una entidad (por ejemplo el Tesoro de un estado) a pagar cantidades en fechas fijas.
  Estos contratos tienen una fecha de vencimiento, donde se devuelve el principal, y pagos intermedios de intereses llamados cupones.
- bonos de renta fija: si los cupones están prefijados.
  Estos activos se consideran "seguros".
- bonos de renta variable: si los cupones dependen un _benchmark_ que se determinará en el futuro. Por ejemplo el LIBOR o el euribor.
- fondo índices: es una colección de dinero cuyo objetivo es seguir unas normas prefijadas para intentar reproducir el rendimiento de alguna parte del mercado. Por ejemplo, el S&P500, IBEX35.

También hay activos no-financieros: tanto tangibles (también llamados reales) como tierra o cereales, e intangibles como patentes y propiedad intelectual.

=== Derivados
Sobre estos activos se construyen a veces otros contratos, llamados *derivados*, que tiene 4 elementos:
- un elemento (llamado subyacente) que se puede o debe comprar o vender
- un acto futuro
- un precio al que ocurrirá la transacción futura
- una fecha futura en que ocurrirá el acto

Veremos ejemplos al final del capítulo.
Estos compromisos futuros habitualmente pueden ser comprados o vendidos en cualquier momento, a cualquier persona o entidad. Establecer el precio actual y otras posibles cantidades involucradas (como el precio de compra-venta un contrato a plazo) de estos contratos es precisamente el objetivo de esta asignatura.

=== Beneficio o retorno de una inversión.

Una de las conceptos básicas de esta teoría el beneficio.
El caso más sencillo, es cuando hablamos de una inversión garantizada a 1 año (por ejemplo un bono) en la que el tipo de interés es tal que
$
  "dinero recibido \n el 1 de enero de 2026" = (1 + r) times "dinero invertido \n el 1 de enero de 2025."
$
En muchos conceptos llamamos a $r$ tipo de  interés o simplemente interés, y lo medimos en $%$ (donde $1% = 0.01$).

En la teoría de interés con composición continua, que veremos más adelante, se reemplaza $1 + r$ por $e^(r T)$ donde $T$ es la duración del contrato.

=== Arbitraje

Imaginemos que dos bancos ofrecen productos de inversión a un año, y por cada 1€ de inversión el primer banco devuelve $(1 + r_1) €$ y el segundo ofrecen $(1 + r_2)€$, donde $r_1 < r_2$.

Entonces un inversor inteligente podría:
- Buscar a los clientes del banco 1, y ofrecerles un producto de interés de un valor $r in (r_1, r_2)$. Supongamos que somos capaces de vender $X$€ de este producto.
- Coger todo el dinero de estos inversores e invertirlo en el banco 2.
- No hemos invertido nada de dinero.
Pasado un año:
- El banco 2 nos dará $(1 + r_2)X$€.
- Usamos este dinero para pagar los $(1 + r)X$€ a los inversores que nos dieron el dinero.
- Nos quedamos con $(r_2 - r)X$€ de beneficio.

Esta situación es la como
#definition[Arbitraje][
  Una oportunidad de arbitraje es la posibilidad de invertir en el mercado, sin coste inicial, de manera que tengamos beneficio de forma segura.
]

Si existen bancos con productos de inversión del mismo plazo y distintos intereses, entonces existe una oportunidad de arbitraje.

Además, para poder un precio único a los productos asumiremos
#definition[Hipótesis de no arbitraje][
  En el mercado no existen posibilidades de arbitraje.
]

Hay algunas otras simplificaciones naturales, que utilizaremos más adelante

#definition(breakable: true)[Hipótesis del mercado financier][
  - Se permite posiciones en corto (vender un producto que está en el mercado o pedir prestadas acciones), así como posiciones fraccionarias (es decir se pueden tener cualquiera cantidades reales de los productos).
  - No existe _bid-ask_ spread, es decir que el precio de compra de un activo es el mismo que su precio de venta.
  - Para cada producto en venta a un cierto precio, hay alguien dispuesto a comprar al mismo precio
  - La compra o venta de productos se realiza sin coste
  - El mercado es completamente líquido, es decir podemos comprar o vender cantidades ilimitadas de los productos. También podemos pedir cantidades ilimitadas de dinero prestadas.
]


=== Mercados#footnote[Adaptado de @Hull2015]

Vamos a hablar ahora de dónde se compran y se venden estos activos y derivados. Principalmente podemos agruparlos en dos categorías.

==== Bolsa de valores (_Exchange_)

#quote(block: true, attribution: [https://es.wikipedia.org/wiki/Bolsa_de_valores])[
  La bolsa de valores es una institución, organizada generalmente como sociedad mercantil o asociación civil, que facilita la negociación de valores mobiliarios entre inversores. Su función principal es ofrecer un espacio regulado y transparente en el que los intermediarios financieros introducen órdenes de compra y venta en nombre propio o de sus clientes, contribuyendo a la formación de precios y a la canalización del ahorro hacia la inversión productiva.

  Entre los instrumentos que se negocian en las bolsas se encuentran las acciones de sociedades anónimas, los bonos públicos y privados, los certificados, los títulos de participación y una amplia variedad de instrumentos financieros derivados.[2][3]

  Las bolsas están supervisadas por organismos reguladores de los mercados financieros, como la Comisión Nacional del Mercado de Valores (CNMV) en España, la Comisión Nacional Bancaria y de Valores (CNBV) en México o la Securities and Exchange Commission (SEC) en Estados Unidos, con el fin de garantizar la transparencia, la seguridad y la protección de los inversores.[4]
]

==== Mercado extra-bursátil (_over-the-counter_ market)

#quote(block: true, attribution: ["https://es.wikipedia.org/wiki/Mercado_extrabursátil"])[
  Un mercado extrabursátil, mercado over-the-counter (OTC), mercado paralelo no organizado o mercado de contratos a medida es uno donde se negocian instrumentos financieros (acciones, bonos, materias primas, swaps o derivados de crédito) directamente entre dos partes. Este tipo de negociación se realiza fuera del ámbito de los mercados organizados.
]

Tradicionalmente, los participantes en los mercados de derivados extrabursátiles se comunicaban directamente por teléfono y correo electrónico, o buscaban contrapartes para sus operaciones a través de intermediarios entre dealers. Los bancos suelen actuar como creadores de mercado (_market makers_) para los instrumentos de mayor negociación, lo que significa que están siempre dispuestos a cotizar un precio de compra —al que están dispuestos a asumir un lado de una operación con derivados— y un precio de venta —al que están dispuestos a asumir el lado contrario.

Antes de la crisis crediticia, que comenzó en 2007 y se analiza con detalle en el Capítulo 8, los mercados de derivados extrabursátiles operaban en gran medida sin regulación. Tras dicha crisis y la quiebra de Lehman Brothers, se produjo el desarrollo de numerosas regulaciones nuevas que afectan al funcionamiento de los mercados extrabursátiles. El objetivo de estas regulaciones es aumentar la transparencia de dichos mercados, mejorar la eficiencia operativa y reducir el riesgo sistémico.

=== Derivados

==== Contratos a plazo (_forward contracts_)#footnote[Resumido de @Hull2015]

Un contrato a plazo es un acuerdo para comprar o vender un activo en un momento futuro determinado, llamado fecha de vencimiento, a un precio determinado, llamado _strike_.
Un contrato a plazo se negocia en el mercado extrabursátil —generalmente entre dos instituciones financieras o entre una institución financiera y uno de sus clientes. Una de las partes del contrato a plazo asume una posición larga y acuerda comprar el activo subyacente en una fecha futura específica a un precio específico. La otra parte asume una posición corta y acuerda vender el activo en la misma fecha al mismo precio. Un ejemplo de este tipo de contrato en la Tabla @table-forward-bidask

#figure(
  caption: [
    Cotizaciones al contado y a plazo del tipo de cambio USD/GBP,
    6 de mayo de 2013 (GBP = libra esterlina; USD = dólar estadounidense;
    la cotización es el número de USD por GBP. #cite(<Hull2015>, supplement: "Tabla 1.1").
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


=== Contratos a futuro (_futures_)#footnote[Resumido de @Hull2015]

Al igual que un contrato a plazo, un contrato de futuros es un acuerdo entre dos partes para comprar o vender un activo en un momento futuro determinado a un precio determinado. A diferencia de los contratos a plazo, los contratos de futuros se negocian habitualmente en un mercado organizado. Para facilitar la negociación, la bolsa establece ciertas características estandarizadas del contrato. Dado que las dos partes contratantes no se conocen necesariamente entre sí, la bolsa también proporciona un mecanismo que ofrece a ambas partes la garantía de que el contrato será cumplido.

Su valoración es similar a la de un futuro, y por tanto no los trataremos en estas notas.

=== Opciones

Una opción es el derecho, pero no la obligación, de comprar (o vender) un activo a un precio y en un momento (que puede ser una fecha o cuando se satisfagan unas condiciones).
Existen diferentes variantes que comentaremos que veremos en diferentes niveles de detalle: europeas, americanas, asiáticas, bermúdeas, ...


== Tipos de _traders_

Existen esencilamente tres tipos de _traders_: hedgers, especuladores y arbitrageurs.
Ver #cite(<Hull2015>, supplement: "Secciones 1.6-1.10"), donde se describen estos actores, se explica qué es un _hedge fund_ y se dan ejemplos de los peligros involucrados en este tipo de actividades con ejemplos concretos.


== Modelizando el precio de activos: procesos estocásticos

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
Este es el modelo más sencillo que se remonta a Bachelier.

#figure(
  image("../figures/lognormality.pdf", width: 75%),
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

=== El tiempo en finanzas
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

#exercise[
  ¿Cuantos años hay entre el 30/11/06 y el 01/03/08?
]<ex-años>

==== Almacenar tiempo en ordenadores

El tiempo en el ordenador se almacena habitualmente en el llamado `UNIX time`, que consiste en el número de segundo pasados desde el *1 de enero de 1970 00:00:00 UT* (llamado _epoch_), a excepción de los segundos intercalares (_lead seconds_).
De esta manera el tiempo se puede almacenar como un número entero.
Un problema curioso es que habitualmente se utilizan `signed 32-bit integers`. Esto generará un problema el 19 de enero de 2038 a las 03:14:07UTC, cuando se alcanza el máximo de estos números. Es el llamado problema del año 2038, Y2038, o _epochalyse_.

=== Simulación de procesos estocásticos

*Lanzamiento de moneda*. Los ordenadores permiten generar un bit de manera pseudo-aleatoria, que es "suficientemente aleatorios" para los propósitos de nuestras simulaciones.
Esto quiere decir que podemos obtener muestras independientes e idénticamente distribuidas de un lanzamiento de moneda balanceado, o una binomial $"B"(n=1,p=1/2)$.

*Simulación de una distribución uniforme*. A partir de estas binomiales podemos construir binomiales de manera sencilla. Y colocándolas como decimales podemos construir uniformes $"U"(0,1)$.

*Variables aleatorias continuas*. Sea $F : RR -> [0,1]$ estrictamente creciente.
Entonces $X ~ "U"(0,1)$ entonces $Y = F^(-1) (X)$ tiene por función de distribución $F$. Esto ocurre porque
$
  PP(Y in [a,b]) & = PP(F^(-1)(X) in [a,b]) = PP(X in [F(a), F(b)]) \
                 & = F(b) - F(a).
$
Esto nos permite de manera "aceptable" simular variables aleatorias continuas.

*Uso de librerías* La mayor parte de lenguajes modernos tienen estas funcionalidades ya programadas. Un ejemplo en julia viene dado por @code-rand y @code-sampledistrib.

#code-block(caption: "Muestreo de una uniform en julia. No requiere ninguna librería.")[
  ```julia
  rand() # Muestra de una uniforme (0,1).
  ```
]<code-rand>

#code-block(caption: [Muestreo de algunas variables aleatorias en julia usando el paquete `Distributions.jl`])[
  ```julia
  using Distributions

  X = Binomial(5,0.5) # Binomial{Float64}(n=5, p=0.5)
  rand(X) # Muestra de un binomial

  X = Normal(0.0, 1.0) # Normal{Float64}(μ=0.0, σ=1.0)
  rand(X) # Muestra de la normal
  ```
]<code-sampledistrib>
