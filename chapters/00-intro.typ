// LTeX: language=es

#import "../header/template.typ": *

= Introducción

#set heading(numbering: none)

== Mercados

=== Over-the-counter markets

=== Contratos a plazo

=== Contratos a futuro

=== Opciones

== Tipos de interés

Los bancos están dispuestos a prestar dinero a cambio de un interés. La idea es sencilla, pero es una de las claves de nuestra capacidad de operar en el mercado.

=== Intución

Esto funciona bien si pensamos por ejemplo, en una inversión hecha el 1 de enero 2025, y que devuelve el dinero el 1 de 2026.

En su presentación más sencilla, el tipo de interés $r$ (expresado en %), es el número tal que
$
  "dinero recibido \n el 1 de enero de 2026" = (1 + r) times "dinero invertido \n el 1 de enero de 2025".
$
Se habla del retorno
$
  "retorno" & := "dinero recibido" - "dinero invertido" \
            & = r times "dinero invertido"
$
Esto funciona bien si pensamos por ejemplo, en una inversión hecha el 1 de enero 2025, y que devuelve el dinero el 1 de 2026.

Si tomamos todo el dinero que sale de una inversión, y lo volvemos a invertir por el mismo plazo, al mismo tiempo entonces obtendremos
$
  "dinero recibido \n el 1 de enero de 2027" = (1 + r)^2 times "dinero invertido \n el 1 de enero de 2025".
$

=== Fórmulas de conversión

Si tenemos una inversión que promete un retorno de $r$ a $T$ años (típicamente $1/T$ es natural), podemos utilizar la fórmula del interés compuesto para deducir cual es el tipo anual
$
  1 + r_("anual") = (1 + r)^(1/T).
$
Esta es la idea detrás del TAE, que es un asunto más profundo del que hablaremos más adelante.

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
Vemos más ejemplos en @table-interes-compuesto.
// #table(
//   columns: (1fr, auto),
//   table.header([*Composición*], [*Valor de $100€$ a final de año*]),
//   Anual, hola,
// )

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: (left, right),
    table.header([*Frecuencia \ de composición*], [*Valor de $100€$ \ a final de año*]),
    [Anual ($n=1$)], [110.00€],
    [Semi-anual ($n=2$)], [110.25€],
    [Cuatrimestral ($n=4$)], [110.38€],
    [Mensual ($n=12$)], [110.47€],
    [Semanal ($n=52$)], [110.51€],
    [Diario ($n=365$)], [110.52€],
  ),
  caption: "Interés compuesto",
)<table-interes-compuesto>

=== Tipo de interés continuo
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
Esta representación nos será de gran utilidad. Si intentamos calcular el tipo anual equivalente, entonces
$
  1 + r_"anual" = e^r.
$

== Tipos de _traders_

==== _Hedgers_

==== Especuladores

==== _Arbitrageurs_

#example(breakable: true)[Arbitraje para un contrato _forward_][
  Nuestra primera introducción al concepto de arbitraje tiene que ver con el precio justo de un contrato _forward_.
  Supongamos que podemos pedir prestado dinero con un tipo de interés en composición continua $r$ y que $S_0$ es el valor actual de un activo.
  Si alguien está dispuesto a entrar con nosotros en un contrato a futuro donde $F_0 > S_0 e^(r T)$, entonces hoy podemos pedir prestado el dinero, y comprar el activo. El resultado contable es la @table-forward-arbitrage1. El resultado es que _independientemente del valor $S_T$_ gano dinero seguro. Además, he hecho la operación sin "poner" dinero. Este efecto es el conocido como arbitraje.
  #figure(
    table(
      columns: (auto, auto, auto),
      table.header([*Transacción*], [*Pago ahora (€) \ $t = 0$*], [*Pago bencimiento (€) \ $t = T$*]),
      [Comprar el contrato], [#text(fill: red)[0]], [$F_0 - S_T$],
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

== El tiempo
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

=== Carteras de inversión

Una cartera es una combinación de diferentes activos en diferentes cantidades.
Puede estar compuesta de activos subyacentes y derivados.
Por ejemplo: 5 acciones de IBM, 1 bono del Tesoro, y una opción europeas de compra de 5 acciones de Microsoft.
Lo normal es que estas cantidades cambien con el tiempo.
Se suele expresar $x^((i))_t$ denota la cantidad del activo $i$-ésimo a tiempo $t$.
Si llamamos $S_t^((i))$ al valor del activo $i$-ésimo en tiempo $t$, el valor de la cartera se escribe como
$
  V_t := sum_(i=1)^N x_t^((i)) dot S_t^((i)).
$
Según el momento trabajaremos con tiempo $t$ discreto o continuo.

== Ejercicios
+ ¿Cuantos años hay entre el 30/11/06 y el 01/03/08?

+ El 1 de enero de 2007, A invirtió 1000€ en su libreta. El 1 de enero de 2008 el banco le informa que ha recibido 40€ de intereses a lo largo del año.
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
