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
Se representa en @fig:binomial.
Para este modelo no sea determinista, supongamos que $0 < d < u$.

=== Planteamiento estocástico

De esta manera, a lo largo supondremos que este un espacio de probabilidad $(Omega, cal(F), PP)$,
donde $Omega$ es el conjunto de sucesos, $cal(F)$ (cuyos elementos son sub-conjuntos de $Omega$) es una $sigma$-álgebra de sucesiones medibles y $PP:cal(F) -> [0,1]$ es una medida de probabilidad.
Así $S_t : Omega -> [0,oo)$ asumimos que para cualquier $A$ de la $sigma$-álgebra de Borel $S_t^(-1)(A) in cal(F)$ y, de esta manera damos sentido a
$
  PP(S_t in A) := PP(S_t^(-1)(A)).
$
Habitualmente hay más de un activo de riesgo, con lo que $S_t = (S_t^((1)), dots, S_t^((N)))$ donde cada $S_t^((i)) : Omega -> [0,oo)$.

Esto quiere decir que $Omega$ es un conjunto de dos elementos (cualesquiera), por ejemplo
$
  Omega = {"sube", "baja"}
$
Así $cal(F)$
// TODO FINISH

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
=== Arbitraje

Llamamos arbitraje a la posibilidad de ganar dinero de manera segura sin inversión inicial
#definition[Oportunidad de arbitraje en el modelo un paso][
  Decimos que $V$ es una oportunidad de arbitraje si existe
  $
    V_0 = 0,
    quad quad & V_T >= 0,
                quad quad & PP(V_T > 0) > 0.
  $
]
Si lo intentamos a través de una cartera tenemos que
$0 = V_0 = x_1 S_0 + x_2 B_0$
luego $x_2 = -x_1 S_0/B_0$. A tiempo final tenemos entonces
$
  V_T = x_1 (S_T - e^(r T)).
$

- Si $e^(r T) <= d < u$ entonces tomando $x_1 > 0$ tenemos que $V_T >= 0$ siempre, y $V_T > 0$ cuando $S_T = u S_0$.
- Si $d < u <= e^(r T)$ entonces tomando $x_1 < 0$ tenemos que $V_T >= 0$ siempre, y $V_T > 0$ cuando $S_T = u S_0$.
De tal manera que la condición de no arbitraje resulta
$
  d < e^(r T) < u.
$<eq-binomial-condicion-no-arbitraje>

=== Valor de un contrato a plazo fijo

=== Opción europea

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
  C_0 = x_1 S_0 + x_2 e^(r T) B_0,
$
donde $(x_1,x_2)$ es la solución de @eq:cobertura, es el llamado *precio libre de arbitraje*.

Hemos hecho algunas suposiciones:
- Ausencia de comisiones: todas las operaciones de compra y venta se han hecho "gratis"
- Liquidez: el mercado está dispuesto a comprar y vender de todas las acciones que quiera, y en cantidades fraccionarias

=== Valoración por replicación


Podemos pensar en la opción $C_t$, una vez se encuentra en el mercado, es otro activo con el que podemos hacer carteras.
Supongamos el caso no trivial en que $C_T != 0$ (es decir $u S_0 > K$).
Sea $V_t$ la cartera autofinanciada que reproduce la opción (es decir $C_T = V_T$), y
supongamos que $C_0 != V_0$, para comprobar que hay una oportunidad de arbitraje.

Si estamos dispuesto a tomar fracciones de la opción, entonces podemos construir
$
  hat(V)_t := op("signo")(V_0 - C_0 )( V_0 C_t - C_0 V_t )
$
Se tiene $hat(V)_0 = 0$ y $hat(V)_T = |V_0 - C_0| C_T.$

Si no queremos tomar fracciones de la opción, entonces distinguimos dos casos
- Si $V_0 = 0$ entonces
  $hat(V)_t = op("signo")(C_0) C_t$.

- Si $V_0 != 0$ entonces puedo construir la siguiente cartera
  $hat(V)_t := op("signo")(V_0 - C_0)( C_t - C_0 / V_0 V_t )$.


=== La medida riesgo neutro

Podemos hacer el cálculo anterior de valor esperado. Para ello introducimos el precio descontado
$
  tilde(S)_t = e^(-r t) S_t
$
#definition[Medida libre de riesgo para el modelo de un paso temporal][
  Medida de probabilidad $QQ$ tal que
  $
    EE^QQ [tilde(S)_T] = S_0
  $
]
Se dice que $tilde(S)_T$ es una martingala respecto de $QQ$. Volveremos sobre este concepto.
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
  $
  entonces existe $QQ$.
  Además, si se da @eq-binomial-condicion-no-arbitraje entonces $QQ$ es no determinista.
]
Ahora calculamos el valor de la cartera descontada
$
  EE^QQ [tilde(V)_t] = x_1 EE^QQ [tilde(S)_t] + x_2 EE^QQ [tilde(B)_t] = x_1 S_0 + x_2 B_0 = V_0.
$
De modo que $tilde(V)$ tiene esperanza constante. Pero dado que $C_t = V_t$ entonces $tilde(C)_t = tilde(V)_t$ y, por tanto, también tiene esperanza constante. Entonces
$
  C_0 = tilde(C)_0 = EE^QQ [ tilde(C)_T ]. //= EE^QQ [ e^(-r T) (S_T - K)_+]
$
Enunciemos el siguiente resultado como teorema, porque nos será de gran utilidad más adelante:
#theorem[Valoración por riesgo neutro][
  Supuesto @eq-binomial-condicion-no-arbitraje entonces
  $
    C_0 = e^(-r T) EE^QQ [C_T].
  $
]
De manera similar, para una _call_ y _put_ europeas, se tiene
$
  C_0 e^(-r T) EE^QQ [(S_T - K)_+]
  quad "y" quad
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

Observamos en @eq-arbol-call se tiene que
$
  C_0 = S_0 e^(-r T)EE^QQ [(S_T/S_0 - K/S_0)_+] = S_0 EE^QQ [(tilde(S)_T/S_0 - tilde(K)/S_0)_+]
$
de modo que siempre se puede asumir que $S_0 = 1$, y reescalar $K$. Trabajando con los precios descontados podemos suponer que $r = 1$, lo que puede simplificar operaciones.

== Modelo trinomial: un sólo activo con 3 estados

Consideremos como caso académico
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="S_0"]
  s -> s1[label="p_1"]
  s -> s2[label="p_2"]
  s -> s3[label="1-p_1-p_2"]
  s1[label="alpha_1 S_0"]
  s2[label="alpha_2 S_0"]
  s3[label="alpha_3 S_0"]
  }
  ```),
  caption: "Modelo discreto con un periodo de tiempo",
)<fig:trinomial>

Ahora ocurre que con un sólo activo de riesgo y el bono, las carteras no permite replicar todos los estados, porque el sistema tiene 2 incógnitas y 3 ecuaciones.
Se dice que el mercado es *incompleto*.

Construyamos, por el contrario, una cartera con arbitraje
$
  tilde(V)_t = x_1 S_t + x_2 B_t + x_3 C_t.
$
La primera condición es que no me cueste nada
$
  x_1 + x_2 + x_3 = 0
$
Pongamos que al final no pierda dinero
$
  x_1 alpha_i S_0 + x_2 e^(r T) B_0 + x_3 (alpha_i S_0 - K)_+ >= 0 "para todo" i=1,2,3.
$
Y que gana dinero con probabilidad positiva, basta con una de estas tres desigualdades sea estricta.
Tenemos el sistema de 3 desigualdades
$
  x_1 alpha_i S_0 + x_2 e^(r T) B_0 >= (x_1 + x_2) (alpha_i S_0 - K)_+ .
$
Esta es la región del plano delimitada por 3 rectas. Si el triángulo no es vacío, en su interior cualquier $(x_1, x_2)$ da un punto donde se gana dinero con probabilidad 1.


== Modelo matricial: $N$ activos y $M$ estados

Supongamos ahora que hay $N$ activos (incluyendo opciones y bonos). Denotaremos
$
  S_t = vec(S^1_t, dots.v, S_t^N) in RR^N
$
donde $S^i_t$ denota la cantidad del activo $i$-ésimo a tiempo $t$.
Asumimos que $S_0$ es conocido y $S_T$ puede estar en $M$ estados.
Una cartera consiste en un vector $theta in RR^N$ donde $theta_i$ indica el número de acciones del activo $i$-ésimo.
Denotamos $D_(i j)$ al valor del activo $i$-ésimo en el estado $j$-ésimo a tiempo $T$, de modo que
$
  S_T in { D_(bullet 1), dots, D_(bullet M) } "donde" D_(bullet j) = vec(D_(1j), dots.v, D_(N j))
$
y $PP(S_T = D_(bullet j)) > 0$ para todo $j$.
Así el valor de cartera a tiempo $t$
$
  V_0 = S_0 dot theta => V_T in { D_(bullet 1) dot theta, dots, D_(bullet M) dot theta } = op("elements") (D^trans theta).
$
donde $trans$ denota la transposición de matrices.

Introducimos la notación para $x in RR^N$ se dice que
- $x >= 0$ (o $x in RR^N_+$) si $x^i >= 0$ para todo $i$
- $x gt.neq 0$ o si $x>=0$ y $x != 0$ (es decir tiene alguna entrada positiva)
- $x > 0$ (o $x in RR^N_(++)$) si $x^i > 0$ para todo $i$.

Así, la condición de no-arbitraje se traduce en que existe $theta in RR^N$ tal que
$
  S_0 dot theta = 0 & " y " D^t theta gt.neq 0.
$
#definition[Vector de estado][
  Vector $psi in RR^M_(++)$ tal que
  $
    S_T = D psi.
  $
]
Llamamos vector de estado a
Supogamos que podemos encontrar carteras $theta^((i))$ tales que
$
  D^trans theta^((i)) = e_i in RR^M "para todo" i in {1,dots,N}.
$
se llaman valores de Arrow-Debreu. En tal caso tenemos
$
  S_0 dot theta^((i)) = (D psi) dot theta^((i)) = psi dot (D^trans theta^((i))) = psi dot e_i = psi_i.
$

#theorem[Teorema Fundamental de Valoración de Activos][
  En el modelo de un paso temporal, $N$ activos, $M$ estados no existe arbitraje si y sólo si existe un vector de estados.
]

La demostración de este teorema es una aplicación del teorema de separación de Hahn-Banach.
Ver #cite(<etheridgeCourseFinancialCalculus>, supplement: "Theorem 1.5.2").

Este vector de estados, también nos da una forma de construir la medida de riesgo nulo
$
  QQ(S_T = D_(bullet j)) := psi_j / psi_0
  quad "y" quad
  psi_0 := sum_(j=1)^M psi_j.
$
Entonces observamos que
$
  EE^QQ [S_T] = S_0 / psi_0
$
Así, $psi_0$ resulta nuestro factor de descuento, y el precio descontado $tilde(S_t) = psi_0 S_t$ es una martingala respecto de $QQ$.

#proposition[][
  Si existe vector de estados, y $C$ de un _contigent claim_ que puede reproducirse con una cartera, entonces su valor actual libre de arbitraje es
  $
    C_0 = psi_0 EE^QQ [C_T].
  $<eq-Nestados-valoracion-riesgoneutro>
]

Concluímos la parte de valoración con este resultado
#theorem[][
  Este modelo es completo (es decir todo _contingent claim_ se reproducirse con cartera) si y sólo $N >= M$ y $op("rango")(D) = M.$
]
Como $psi_0$ es único, si el mercado es completo y libre de riesgo, entonces $QQ$ es única. En resumen:
#remark[Completitud, arbitraje, y medida libre riesgo][
  - Son equivalentes:
    - El mercado es libre de arbitraje
    - existe medida libre de riesgo
    - existe vector de estado.
    Este es el Teorema Fundamental de Valoración de Activos.

  - El mercado es completo si y sólo si $QQ$ es única.
]
