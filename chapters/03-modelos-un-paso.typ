// LTeX: language=es

#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

= Modelos de un paso temporal

// Modelo matricial (un periodo de tiempo)
// Valoración por replicación, carteras de cobertura, oportunidades de arbitraje.
// Numerarios y probabilidad de
// valoración, teorema fundamental de valoración, mercados completos e incompletos.
// Modelos en árboles binomiales.
// Construcción del modelo binomial de Jarrow-Rudd.
// Valoración de opciones europeas.
// Paso al límite, fórmulas de Black-Scholes.
// Valoración de opciones americanas, ejercicio óptimo.

Supondremos un modelo de un paso temporal, que pasa de $t=0$ a $t = T$.
Consideramos un bono, $B$, cuyo valor $B_0$ es conocido y $B_T = e^(r T) B_0$.
Se conoce a $r$ como ...........

== Modelo binomial: un sólo activo con dos posible estados

Modelicemos un activo financiero por el proceso estocástico más sencillo.
Denotemos por el precio en € de una unidad de este activo a tiempo por $S_t$.
El valor a $t = 0$, $S_0 > 0$, es conocido.
Supongamos que el valor del activo a tiempo $T$ sólo puede subir por un factor $u$ con cierta probabilidad $p$ o bajar por un factor $d$, es decir
$
  bb(P)(S_T = u S_0) = p " y " bb(P)(S_T = d S_0) = 1-p
$
Se representa en @fig:binomial
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
Para este modelo no sea determinista, supongamos que $0 < d < u$.

=== Cartera

Dado que suponemos que hay un bono, una _cartera_ consiste en tener $x_1$ unidades de la acción, y $x_2$ unidades del bono. El valor de esta cartera es
$
  V_t = x_1 S_t + x_2 B_t " donde " t in {0, T}.
$

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="x_1 S_0 + x_2 B_0"]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="x_1 u S_0 + x_2 e^(r T) B_0"]
  s2[label="x_1 d S_0 + x_2 e^(r T) B_0"]
  }
  ```),
  caption: "Evolución de una cartera",
)<fig:binomial_cartera>

=== Valor de un contrato a plazo fijo

=== Opción europea. Valoración por replicación

Una opción de compra (_call option_) es el derecho, pero no la obligación, de comprar mañana el activo a un precio $K$. Llamaremos al valor de la call $C$. Hoy su valor, que es lo que queremos fijar, es $C_0$, y el valor mañana es $C_1$.

Como el lógico, si el valor mañana $S_T > K$ entonces puedo me interesará ejercer la opción, y ganaré $S_T - K$.
Si el valor es menor o igual $S_T <= K$, entonces no la ejerzo, y no ganaré nada. Esto puede escribir como que el beneficio es el valor de la call mañana $C_T = (S_T - K)_+$.
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="C_0"]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="(u S_0-K)_+"]
  s2[label="(d S_T-K)_+"]
  }
  ```),
  caption: "Modelo discreto con un periodo de tiempo",
)<fig:binomial_opcion>

#block(fill: red.transparentize(50%))[
  // #set text(fill: red)
  Representar las regiones donde compensa comprar la opción
]

Creemos una *cartera de cobertura* haciendo que tanto si ocurre $u S_0$ como si ocurre $d S_0$ obtengamos el mismo resultado
$
  x_1 u S_0 + x_2 e^(r T) B_0 = (u S_0 - K)_+ \
  x_1 d S_0 + x_2 e^(r T) B_0 = (d S_0 - K)_+
$
Matricialmente
$
  mat(
    u S_0, e^(r T) B_0;
    d S_0, e^(r T) B_0
  )
  mat(x_1; x_2)
  =
  mat((u S_0-K)_+; (d S_0 - K)_+)
$<eq:cobertura>
Como $u S_0 eq.not d S_0$ entonces encontramos una única solución del sistema.

Supongamos que yo valoro la opción con un valor $C_0 > V_0$ (y estoy dispuesto a comprarla o venderla a ese precio). En este caso, un inversor inteligente hace lo siguiente:
- Hoy: venderme la opción a precio $C_0$, y comprar en el mercado la cartera de cobertura lo que le cuesta $V_0$.
  Por ahora tiene un beneficio neto de $C_0 - V_0 > 0$.
  Esto requiere pedir "prestada" una de las acciones (lo que habitualmente se conoce como quedarse "corto").
- Mañana: como el inversor a pedido prestadas acciones, debe liquidar la cartera.
  + Si el valor de la acción es $S_T <= K$, yo no ejercerá la opción. La cartera ahora vale $x_2 S_T + x_2 e^(r T) B_0 = (S_T - K)_+ = 0$, con lo que puede liquidarla sin perder o ganar dinero y ya no está corto ni largo acciones.
  + Si el valor de la acción es $S_T > K$. Yo querré ejercer la opción, y comprar la acción por $K$€. Al liquidar la cartera el inversor obtiene (o pierde) $x_1 S_T + x_2 e^(r T) B_0 = (S_T - K)_+ = S_T - K$. Junto esto con los $K$€ que yo le doy, puede comprar la acción, y dármela. En esta operación no pierde o gana dinero.

Al final de la jugada, el inversor inteligente se va a casa con $C_0 - V_0 > 0$ ¡con probabilidad 1! Este es el efecto es el conocido como *arbitraje*.
En caso de que $C_0 < V_0$ entonces el inversor me compra la opción, y vende en el mercado la cartera.
De tal manera que el único precio que no genera opciones de arbitraje es
$
  C_0 = x_1 s_0 + x_2 e^(r T) B_0,
$
donde $(x_1,x_2)$ es la solución de @eq:cobertura, es el llamado *precio libre de arbitraje*.

Hemos hecho algunas suposiciones:
- Ausencia de comisiones: todas las operaciones de compra y venta se han hecho "gratis"
- Liquidez: el mercado está dispuesto a comprar y vender de todas las acciones que quiera, y en cantidades fraccionarias

=== La medida riesgo neutro

Podemos hacer el cálculo anterior de valor esperado. Para ello introducimos el precio descontado
$
  tilde(S)_t = e^(-r t) S_t
$
#definition[Medida libre de riesgo para el modelo de un paso temporal][
  Medida de probabilidad $QQ$ tal que
  $
    EE^QQ [tilde(S_T)] = S_0
  $
]
Dado que sólo hay posibilidades, si llamemos
$
  q := QQ(tilde(S)_T = u e^(-r T) S_0)
$
Entonces $tilde(S)$ satisface un segundo modelo binomial representado en @fig:binomial_riesgo_neutro
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="S_0"]
  s -> s1[label="q"]
  s -> s2[label="1-q"]
  s1[label="e^(-r T) u S_0"]
  s2[label="e^(-r T) d S_0"]
  }
  ```),
  caption: [Modelo binomial para el precio descontado $tilde(S)_t$ con medida de riesgo neutro],
)<fig:binomial_riesgo_neutro>
Nos falta conocer $q$. Aplicando la definición buscamos que
$
  S_0 = EE^QQ [tilde(S)_T] = e^(-r T) u S_0 q + e^(-r T) d S_0 (1-q)
$
podemos despejar
$
  q:= (e^(r T) - d )/(u - d)
$
que está en $[0,1]$ si $d <= e^(r T) <= u$. De modo que
#proposition[Existencia de la medida libre de riesgo][
  Si
  $
    d <= e^(r T) <= u
  $<eq-binomial-condicion-no-arbitraje>
  entonces existe $QQ$.
]
Ahora calculamos el valor de la cartera descontada
$
  EE^QQ [tilde(V)_t] = x_1 EE^QQ [tilde(S)_t] + x_2 EE^QQ [tilde(B)_t] = x_1 S_0 + x_2 B_0 = V_0.
$
De modo que $tilde(V)$ tiene esperanza constante. Pero dado que $C_t = V_t$ entonces $tilde(C)_t = tilde(V)_t$ y, por tanto, también tiene esperanza constante. Entonces
$
  C_0 = tilde(C)_0 = EE^QQ [ tilde(C)_T ] = EE^QQ [ e^(-r T) (S_T - K)_+]
$
Enunciemos el siguiente resultado como teorema, porque nos será de gran utilidad más adelante:
#theorem[Valoración por riesgo neutro][
  Supuesto @eq-binomial-condicion-no-arbitraje entonces
  $
    C_0 = e^(-r T) EE^QQ [(S_T - K)_+].
  $
]
De manera similar, para un _put_ europea, se tiene
$
  P_0 = e^(-r T) EE^QQ [(K - S_T)_+].
$
Restando obtenemos
$
  C_0 - P_0 & = e^(-r T) EE^QQ [S_T - K] = EE^QQ [tilde(S)_t ] - e^(-r T) K
$
donde concluímos que
$
  C_0 - P_0 & = S_0 - e^(-r T) K.
$<eq-unpaso-putcall>
Se llama a esta relación _paridad put-call_.


*Martingalas*

== Modelo trinomial: un sólo activo con 3 estados

== Modelo matricial: $N$ activos y $n$ estados
