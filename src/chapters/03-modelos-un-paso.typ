// LTeX: language=es

#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

// = Modelos de un periodo temporal

// Modelo matricial (un periodo de tiempo)
// Valoración por replicación, carteras de cobertura, oportunidades de arbitraje.
// Numerarios y probabilidad de
// valoración, teorema fundamental de valoración, mercados completos e incompletos.
// Modelos en árboles binomiales.
// Construcción del modelo binomial de Jarrow-Rudd.
// Valoración de opciones europeas.
// periodo al límite, fórmulas de Black-Scholes.
// Valoración de opciones americanas, ejercicio óptimo.

= Modelo binomial: un sólo activo con dos posible estados

Modelicemos un activo financiero por el proceso estocástico más sencillo.
Denotemos por el precio en € de una unidad de este activo a tiempo por $S_t$.
El valor a $t = 0$, $S_0 > 0$, es conocido.
Supongamos que el valor del activo a tiempo $T$ sólo puede subir por un factor $u$ con cierta probabilidad $p$ o bajar por un factor $d$, es decir
$
  PP(S_T = u S_0) = p " y " PP(S_T = d S_0) = 1-p \
  PP(B_T = e^(r T)) = 1.
$<eq-unperiodo-2states>
Se representa en @fig:binomial.
Para este modelo no sea determinista, supongamos que
$
  0 < d < u.
$

Llamamos a $S_t$ *activo subyacente*. Su valor determina el estado estocástico del sistema.

Los derivados de los que hablaremos (por ejemplo las opciones) puede escribirse dentro de estos modelos como productos en el siguiente sentido

#definition[Derivado o derecho contingente en el modelo @eq-unperiodo-2states][
  Cualquier $H = (H_0, H_T)$ donde $H_0 in RR$ y $H_T = h (S_T)$.
  Permitimos que $h$ dependa de los parámetros de @eq-unperiodo-2states.
]<def-unpaso-derivado>

== $S_t$ como proceso estocástico

De esta manera, a lo largo supondremos que este un espacio de probabilidad $(Omega, cal(F), PP)$ y $S_t : Omega -> RR$ es una variable aleatoria.
Habitualmente hay más de un activo de riesgo, con lo que $bold(S)_t = (S_t^((1)), dots, S_t^((N)))$ donde cada $S_t^((i)) : Omega -> [0,oo)$.

Vamos a construir rigurosamente @eq-unperiodo-2states. Esto quiere decir que $Omega$ es un conjunto de dos elementos (cualesquiera), por ejemplo
$
  Omega = {"sube", "baja"}
$
El mercado se compone de dos procesos $S = (S_0, S_T)$ y $B = (1, B_T)$
$
  {S, B} : Omega & -> [0,+oo)^2 \
          "sube" & |-> lr({(S_0, S_0 u), (1, e^(r T) )}, size: #200%) \
          "baja" & |-> lr({(S_0, S_0 d), (1, e^(r T) )}, size: #200%).
$
Los conjuntos medibles son todos los posibles $cal(F)$ es $sigma$-álgebra discreta
$
  cal(F) := cal(P)(Omega) = lr({ emptyset, {"sube"}, {"baja"}, {"sube", "baja"}}, size: #200%)
$
De esta manera
$
        PP: cal(F) & -> [0,1] \
          emptyset & |-> 0 \
          {"sube"} & |-> p \
          {"baja"} & |-> 1-p \
  {"sube", "baja"} & |-> 1.
$

Informalmente, denotamos
$
  {S_T = S_0 u} := {(s_0,s_T) in RR^2 : s_T = S_0 u}
$
Así, la notación $PP(S_T = S_0 u)$ quiere decir la medida del conjunto informalmente escrito ${S_T = S_0 u}$,
$
  PP(S_T = S_0 u) := PP(S^(-1) lr(({S_T = S_0 u}), size: #200%)) = PP({"sube"}) = p.
$
Por salud mental, en adelante no volveremos a mencionar esta construcción tan complicada y tan poco descriptiva. Pero las matemáticas sustentas nuestros cálculos.
#remark[
  Habitualmente al presentar un modelo como @eq-unperiodo-2states normalmente quedará implícito cuál es el espacio de probabilidad subyacente.
]

Nótese que como $cal(F)$ es la $sigma$-álgebra discreta, cualquier derivado cumple que $H_T : Omega -> RR$ es medible.

Lo más habitual es el que valor de estos derivados a tiempo $T$ se escriba en función de $S_T$, en lugar de $Omega$. Por esto, es frecuente hablar de _contingent claims_.


#exercise[
  Calcular $EE[S_T]$ y cuál es la probabilidad de que $S_T > B_T$.
]

// TODO FINISH

== Cartera

Si pensamos en el modelo @eq-unperiodo-2states con un activo subyacente de valor $S_t$ y un bono de valor $B_t$, una _cartera_ consiste en tener $theta^((1)) in RR$ unidades de la activo, y $theta^((2)) in RR$ unidades del bono.
Así, una cartera en el mercado ${S,B}$ es un vector $bold(theta) in RR^2$. El valor de esta cartera es el proceso estocástico
$
  V_t^(bold(theta)) = theta^((1)) S_t + theta^((2)) B_t " donde " t in {0, T}.
$
Algunos autores la denotan $V^(bold(theta))$ para especificar que lo importante es el vector $theta$.

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="theta^((1)) S_0 + theta^((2)) "]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="theta^((1)) u S_0 + theta^((2)) e^(r T) "]
  s2[label="theta^((1)) d S_0 + theta^((2)) e^(r T) "]
  }
  ```),
  caption: "Evolución de una cartera",
)<fig:binomial_cartera>

#exercise(breakable: true)[Volatilidad de una cartera][
  Hemos visto que
  $
    EE [V^(bold(theta))_T] = theta^((1)) EE [S_T] + theta^((2)) e^(r T) = theta^((1)) (p u S_0 + (1-p) d S_0) + theta^((2)) e^(r T).
  $
  Comprobar que
  $
    var (V_T)
    //= EE [(V_T - overline(V)_T)^2] = EE [(theta^((1)) (S_t - overline(S)_t))^2]
    = (theta^((1)))^2 var (S_t).
  $
  Con la misma inversión inicial $V_0 = theta^((1)) S_0 + theta^((2))$, podemos controlar el "riesgo" deciendo cuanto invertimos en el "activo de riesgo" y cuanto en el activo seguro.

  Pensemos en el ejemplo más sencillo, donde $p=1/2$, $S_0 = 1$, $u = 2$, $d=1/2$ y $r = 0$.
  Supongamos que tenemos una cantidad inicial para invertir en una cartera de $V_0 = 1$. Escribir $theta^((2))$ en función de $theta^((1))$. Representar la $EE[V_T]$ y $sqrt(var(V_T))$ en función de $theta^((1))$. Representar también los valores de la $V_T$.

  ¿Qué sugiere esta gráfica?
]

#definition[Cartera en un mercado sobre el modelo @eq-unperiodo-2states][
  Si en el modelo @eq-unperiodo-2states contamos derivados de valor $S^((1)), dots.c, S^((N))$, una cartera en el mercado ${S^((1)), dots.c, S^((N))}$ consiste en una combinación de estos activos en cantidades $theta^((i)) in RR$.
  Así, la cartera es un vector $theta in RR^N$.
  El valor de la cartera a tiempo $t$ es
  $
    V^(bold(theta))_t := sum_(i=1)^N theta^((i)) S_t^((i)) = bold(theta)_t dot bold(S)_t.
  $
  Habitual la denotaremos simplemente $V$.
  Nótese que si $S^((i))$ son derivados en el modelo @eq-unperiodo-2states entonces las carteras son también derivados financieros.
]

Utilizamos la siguiente convención:
- si $theta_t^((i)) > 0$ decimos que estamos en una posición larga (hemos comprado el activo en el mercado), y
- si $theta_t^((i)) < 0$ decimos que estamos en una posición corta (hemos pedido prestado a un broker el activo).

== Opción europea

En este caso una opción europea corresponde a <fig:binomial_opcion>
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
  caption: "Opción europea y cartera con un período de tiempo",
)<fig:binomial_opcion>

Desconocemos el valor $C_0$. De manera similar a lo que hicimos con las opciones forward en @example-arbitrage-forward vamos a intentar encontrar el precio de no arbitraje por argumentos "de palabra".

Como el único activo que sabemos valorar son las carteras, vamos a crear lo que se llama una *cartera de cobertura*, es decir haciendo que tanto si ocurre $u S_0$ como si ocurre $d S_0$ obtengamos el mismo pago a tiempo a $T$
$
  theta^((1)) u S_0 + theta^((2)) e^(r T) 1 = (u S_0 - K)_+ \
  theta^((1)) d S_0 + theta^((2)) e^(r T) 1 = (d S_0 - K)_+.
$
Matricialmente
$
  mat(
    u S_0, e^(r T);
    d S_0, e^(r T)
  )
  mat(theta^((1)); theta^((2)))
  =
  mat((u S_0-K)_+; (d S_0 - K)_+)
$<eq:cobertura>
Como $u S_0 eq.not d S_0$ entonces encontramos una única solución del sistema.

Supongamos que yo valoro la opción con un valor $C_0 > V_0$ (y estoy dispuesto a comprarla o venderla a ese precio). En este caso, un inversor inteligente hace lo siguiente:
- Hoy: venderme la opción a precio $C_0$, y comprar en el mercado la cartera de cobertura lo que le cuesta $V_0$.
  Por ahora tiene un beneficio neto de $C_0 - V_0 > 0$.
  Esto requiere pedir "prestada" una de las acciones (lo que habitualmente se conoce como quedarse "corto").
- Mañana: como el inversor a pedido prestadas acciones, debe liquidar la cartera.
  + Si el valor de la acción es $S_T <= K$, yo no ejercerá la opción. La cartera ahora vale $theta^((2)) S_T + theta^((2)) e^(r T) = (S_T - K)_+ = 0$, con lo que puede liquidarla sin perder o ganar dinero y ya no está corto ni largo acciones.
  + Si el valor de la acción es $S_T > K$. Yo querré ejercer la opción, y comprar la acción por $K$€. Al liquidar la cartera el inversor obtiene (o pierde) $theta^((1)) S_T + theta^((2)) e^(r T) = (S_T - K)_+ = S_T - K$. Junto esto con los $K$€ que yo le doy, puede comprar la acción, y dármela. En esta operación no pierde o gana dinero.

Al final de la jugada, el inversor inteligente se va a casa con $C_0 - V_0 > 0$ ¡con probabilidad 1! Este es el efecto es el conocido como *arbitraje*.
En caso de que $C_0 < V_0$ entonces el inversor me compra la opción, y vende en el mercado la cartera.
De tal manera que el único precio que no genera opciones de arbitraje es
$
  C_0 = theta^((1)) S_0 + theta^((2)) e^(r T),
$
donde $(theta^((1)),theta^((2)))$ es la solución de @eq:cobertura, es el llamado *precio libre de arbitraje*. Hay otra forma, más elegante, de expresar este valor.

#remark[Hipótesis sobre el mercado][
  Hemos hecho algunas suposiciones:
  - Ausencia de comisiones: todas las operaciones de compra y venta se han hecho "gratis"
  - Liquidez: el mercado está dispuesto a comprar y vender de todas las acciones que quiera, y en cantidades fraccionarias
]


== Arbitraje: unicidad de precios, carteras de cobertura, completitud de mercado

Llamamos arbitraje a la posibilidad de ganar dinero de manera segura sin inversión inicial
#definition[Arbitraje en el modelo @eq-unperiodo-2states][
  Un derivado $H$ es una oportunidad de arbitraje si existe
  $
    H_0 <= 0,
    quad quad & H_T >= 0,
                quad quad & PP(H_T > 0) > 0.
  $
  Habitualmente podemos construirlo con $H_0 = 0.$

  Dados derivados $S^((1)), dots.c, S^((N))$ decimos que el mercado ${S^((1)), dots.c, S^((N))}$ admite arbitraje si existe una cartera que es una oportunidad de arbitraje. En caso contrario, diremos que el mercado está _libre de arbitraje_.
]
Si lo intentamos a través de una cartera tenemos que
$0 = V_0 = theta^((1)) S_0 + theta^((2)) 1$
luego $theta^((2)) = -theta^((1)) S_0$. A tiempo final tenemos entonces
$
  V_T = theta^((1)) (S_T - e^(r T)).
$

- Si $e^(r T) <= d < u$ entonces tomando $theta^((1)) > 0$ tenemos que $V_T >= 0$ siempre, y $V_T > 0$ cuando $S_T = u S_0$.
- Si $d < u <= e^(r T)$ entonces tomando $theta^((1)) < 0$ tenemos que $V_T >= 0$ siempre, y $V_T > 0$ cuando $S_T = u S_0$.
#theorem[Condición de no arbitraje][
  Dado $S, B$ descritos en @eq-unperiodo-2states el mercado ${S,B}$ es libre de arbitraje si y sólo si
  $
    d < e^(r T) < u.
  $<eq-binomial-condicion-no-arbitraje>
]

#exercise(breakable: true)[Contrato a plazo][
  Vamos a volver sobre el @example-arbitrage-forward, estudiada en el mercado @eq-unperiodo-2states.
  Un contrato a plazo es el derecho y la obligación de comprar un bien a un valor fijado $F_0$ a un tiempo fijado $T$.
  Sea $H_T$ el valor de este contrato.
  Como en el contrato a futuro no se intercambia dinero a tiempo $0$ se establece que $H_0 = 0$.
  A tiempo $T$ ejecuto el contrato, como el bien por $F_0$€, y luego puedo venderlo inmediatamente por $S_T$€.
  De modo que el beneficio es
  $
    H_T = S_T - F_0.
  $
  Cuando introducimos un nuevo derivado, por ejemplo $H_t$, en el mercado, estamos extendiendo el mercado de tal modo que ahora tiene tres activos con los que construir carteras: ${S, B, H}$.

  + Suponer que $F_0 > S_0 e^(r T)$ y construir una cartera en el mercado ${S, B, H}$ que sea una oportunidad de arbitraje.

  + Adaptar la cartera en el caso $F_0 < S_0 e^(r T)$

  + Escribir una cartera que sirva en ambos casos, utilizando la función signo
    $
      sign(s) = cases(
        1 & "si" s > 0,
        0 & "si" s = 0,
        -1 & "si" s < 0
      )
    $

  + ¿Qué ocurre con estas carteras si $F_0 = S_0 e^(r T)$?
]<ex-unperiodo-2states-forward>

// #proof[
//   Supongamos que $F_0 > S_0 e^(r T)$. Entonces, en mercado de activos $(S_t, B_t, H_t)$, podemos construimos la cartera de valor
//   $
//     V_t = underbrace(-H_t, "vender contrato") + underbrace(S_t, "comprar el activo") - underbrace(S_0 B_t, "financiarlo con deuda").
//   $
//   Esta cartera tiene $V_0 = 0 + S_0 - S_0 = 0$, y $V_T = -(S_T - F_0) + S_T - e^(r T) S_0 = F_0 - e^(r T) S_0 > 0$. Esta es una oportunidad de arbitraje.

//   Si $F_0 < S_0 e^(r T)$ entonces construimos la cartera al revés.
// En la demostración anterior, podríamos haber construído ambos casos con la cartera
// $
//   V_t = sign(F_0 - e^(r T) S_0) (-H_t + S_t - S_0 B_t ).
// $
// ]

Vamos a hacer rigurosa la idea de que si hay dos derivados que tienen el mismo _payoff_, entonces tienen el mismo valor en todo momento

#theorem[Unicidad del precio][
  Sea $V, H$ dos derivados en el modelo @eq-unperiodo-2states tales que $H_T = V_T$.
  Si $V_0!=H_0$ entonces existe una oportunidad de arbitraje en el mercado ${V, H}$.
]<thm-binomial-unicidad-precio>
#proof[
  Podemos pensar en la opción $H_t$, una vez se encuentra en el mercado, es otro activo con el que podemos hacer carteras.
  Sea $bold(theta)_t$ la cartera autofinanciada (en el mercado ${S,B}$) que reproduce la opción (es decir $H_T = V_T$), y
  supongamos que $H_0 != V_0$, para comprobar que hay una oportunidad de arbitraje.

  Consideramos en el mercado ${V, B}$ la cartera dada por
  $
    hat(theta)^((1)) = op("signo")(H_0 - V_0 ) H_0 quad "y" quad hat(theta)^((2)) = -op("signo")(H_0 - V_0 ) V_0
  $
  es decir la cartera de valor
  $
    hat(V)_t := op("signo")(V_0 - H_0 )( H_0 V_t - V_0 H_t )
  $
  Se tiene $hat(V)_0 = 0$ y $hat(V)_T = |V_0 - H_0| H_T.$
]

Como el precio es único y conocemos el valor de carteras, introducimos la siguiente idea:

#definition[Cartera de cobertura][
  Llamamos cartera de cobertura en un mercado a una cartera $bold(theta)$ en el mismo mercado que $H_T = V_T^(bold(theta))$. Esto quiere decir que $H_T (omega) = V_T (omega)$ para todo $omega in Omega$.
]


Como en el caso de la opción _call_ europea, esto nos lleva a un sistema compatible determinado
$
  mat(
    u S_0, e^(r T);
    d S_0, e^(r T)
  )
  mat(theta^((1)); theta^((2)))
  =
  mat(H_T ("sube"); H_T ("baja")).
$

#definition[Mercado completo][
  Decimos que un mercado es completo si para cada derivado existe una cartera de cobertura.
]
En el modelo @eq-unperiodo-2states el mercado ${S, B}$ es completo.


== La medida riesgo neutro

Empezamos recordando una definición
#definition[Equivalencia de medidas][
  Dos medidas de probabilidad $PP$ y $QQ$ son equivalentes, y se denota $PP ~ QQ$, si están definidas sobre el mismo espacio de medida y para todo conjunto $A$ medible
  $
    PP(A) = 0 <=> QQ(A) = 0
  $
]
El motivo por el que se pide la equivalencia es

#lemma[Valor esperado de una oportunidad de arbitraje][
  Si un derivado$H$ es una oportunidad de arbitraje y $QQ ~ PP$ entonces
  $
    EE^QQ [H_T] > 0.
  $
]<lem-binomial-esperanza-oportunidad-arbitraje>
#proof[
  Existe un evento $omega_0 in Omega$ con $PP({omega_0}) > 0$ y $V_T (omega_0) > 0$. Dado que $QQ ~ PP$ entonces $QQ(V_T in A) > 0$.
  Así, dado que $V_T >= 0$ tenemos
  $
    EE^QQ [V_T] = sum_(omega in Omega) PP({omega}) V_T (omega) >= PP({omega_0}) V_T (omega_0) > 0. #qedhere
  $
]

Podemos hacer el cálculo anterior de valor esperado. Para ello introducimos el precio descontado
$
  tilde(S)_t := S_t / B_t.
$
#definition[Medida libre de riesgo, medida riesgo neutro o medida martingala para el modelo @eq-unperiodo-2states][
  Medida de probabilidad $QQ ~ PP$ tal que
  $
    EE^QQ [tilde(S)_T] = S_0
  $
]
Se dice que $tilde(S)_T$ es una martingala respecto de $QQ$. Volveremos sobre este concepto.
Dado que sólo hay posibilidades, si llamemos
$
  q := QQ(S_T = u S_0).
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
que está en $[0,1]$ si $d <= e^(r T) <= u$.
Normalmente se pide a la medida que sea equivalente con la medida ambiente $PP$.


De modo que, como $p in (0,1)$ tenemos
#proposition[Existencia de la medida libre de riesgo][
  Existe medida libre de riesgo $QQ ~ PP$ si y sólo si se da la condición de no-arbitraje @eq-binomial-condicion-no-arbitraje.
  En tal caso, es única.
]<prop-arbol-existenciaQ>

#remark[][
  Hay dos "principios" que se cumplen habitualmente tanto en los modelos de mercado tanto continuos como discretos.
  @prop-arbol-existenciaQ es un ejemplo del llamado *primer teorema fundamental de valoración de activos*, que dice:
  $
    QQ "existe" <=> "mercado libre de arbitraje".
  $
  Por su parte, el *segundo teorema fundamental de valoración* dice
  $
    QQ "es única" <=> "mercado completo".
  $
]

Una gran propiedad es la siguiente
#theorem[Valoración de cartera por riesgo neutro][
  Si $theta$ es una cartera es una cartera en el mercado ${S, B}$ entonces para $t in {0,T}$
  $
    e^(-r t) EE^QQ [V_t^(bold(theta))] = V_0^(bold(theta)).
  $
]<thm-binomial-valor-cartera-riesgo-neutro>
#proof[
  Calculamos el valor de la cartera descontada
  $
    EE^QQ [tilde(V)_t] = theta^((1)) EE^QQ [tilde(S)_t] + theta^((2)) EE^QQ [tilde(B)_t] = theta^((1)) S_0 + theta^((2)) = V_0. #qedhere
  $
]
De modo que $tilde(V)$ tiene esperanza constante. Pero dado que $H_t = V_t$ entonces $tilde(C)_t = tilde(V)_t$ y, por tanto, también tiene esperanza constante. Entonces
$
  H_0 = tilde(H)_0 = EE^QQ [ tilde(H)_T ]. //= EE^QQ [ e^(-r T) (S_T - K)_+]
$
Enunciemos el siguiente resultado como teorema, porque nos será de gran utilidad más adelante:
#theorem[Valoración por riesgo neutro][
  Consideremos el modelo @eq-unperiodo-2states y la condición de no arbitraje @eq-binomial-condicion-no-arbitraje.
  Para todo derivado$H$ el mercado ${S, B, H}$ es libre de arbitraje si y sólo si
  $
    H_0 = e^(-r T) EE^QQ [H_T].
  $
]
Primero hacemos notar que cualquier otro precio produce una opción de arbitraje.
Para demostrar esto existe una cartera de cobertura, el precio de la cartera de cobertura es el valor esperado (@thm-binomial-valor-cartera-riesgo-neutro), y el precio de dos derivados con el mismo pay-off coincide o hay arbitraje (@thm-binomial-unicidad-precio).
Veamos, por último, que este precio garantiza la ausencia de arbitraje.
#proposition[
  Consideremos el modelo @eq-unperiodo-2states y la condición de no arbitraje @eq-binomial-condicion-no-arbitraje.
  Para todo derivado$H$ si
  $
    H_0 = e^(-r T) EE^QQ [H_T].
  $
  entonces el mercado ${S, B, H}$ es libre de arbitraje.
]<prop-binomial-esperanza-implica-noarbitraje>
#proof[
  Sea $hat(bold(theta))$ una cartera en el mercado ${S,B,H}$.
  Vamos a calcular valor de la cartera descontada
  $
    e^(-r T) EE^QQ [V^(hat(bold(theta)))_t]
    &= hat(theta)^((1)) e^(-r T)EE^QQ [S_t] + hat(theta)^((2)) e^(-r T) EE^QQ [B_t] + hat(theta)^((3)) EE^QQ [H_T]
    \
    &= hat(theta)^((1)) S_0 + hat(theta)^((2)) + hat(theta)^((3)) H_0
    = V_0.
  $
  con lo que, recordando @lem-binomial-esperanza-oportunidad-arbitraje, $hat(V)_t$ no puede ser una oportunidad de arbitraje.
]




#exercise[Paridad _put-call_][
  Una opción de venta, o _put_, europea tiene pay-off $P_T = (K - S_T)_+$. Utilizar la medida de riesgo neutro $QQ$ para demostrar la siguiente relación, conocida como _paridad put-call_
  $
    C_0 - P_0 & = S_0 - e^(-r T) K.
  $<eq-unperiodo-putcall>
]<ex-unperiodo-putcall>

// De manera similar, para una _call_ y _put_ europeas, se tiene
// $
//   C_0 = e^(-r T) EE^QQ [(S_T - K)_+]
//   quad "y" quad
//   P_0 = e^(-r T) EE^QQ [(K - S_T)_+].
// $
// Restando obtenemos
// $
//   C_0 - P_0 & = e^(-r T) EE^QQ [S_T - K] = EE^QQ [tilde(S)_t ] - e^(-r T) K
// $

Observamos en @eq-arbol-call se tiene que
$
  C_0 = S_0 e^(-r T)EE^QQ [(S_T/S_0 - K/S_0)_+] = S_0 EE^QQ [(tilde(S)_T/S_0 - tilde(K)/S_0)_+]
$
de modo que siempre se puede asumir que $S_0 = 1$, y reescalar $K$. Trabajando con los precios descontados podemos suponer que $r = 1$, lo que puede simplificar operaciones.

= Otros modelos de un periodo de tiempo

== Modelo trinomial: un sólo activo con 3 estados

Consideremos como caso académico como $u > m > d$ y el sistema
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="S_0"]
  s -> s1[label="p_u"]
  s -> s2[label="p_m"]
  s -> s3[label="p_d"]
  s1[label="u S_0"]
  s2[label="m S_0"]
  s3[label="d S_0"]
  }
  ```),
  caption: "Modelo discreto con un periodo de tiempo",
)<fig-trinomial>

=== Condición de no arbitraje en el mercado ${S,B}$

Veamos si el mercado ${S, B}$ admite arbitraje.
Estudiamos una cartera $bold(theta)$
$
  V_t^(bold(theta)) = theta^((1)) S_t + theta^((2)) B_t.
$
Habría arbitraje si existe $theta$ tal que
- La primera condición es que no me cueste nada
  $
    theta^((1))S_0 + theta^((2)) = 0
  $
- La segunda es que no pierda dinero
  $
    cases(
      theta^((1)) u S_0 & + theta^((2)) e^(r T) & >= 0,
      theta^((1)) m S_0 & + theta^((2)) e^(r T) & >= 0,
      theta^((1)) d S_0 & + theta^((2)) e^(r T) & >= 0,
    )
  $
- La tercera es que gane dinero con probabilidad no nula, es decir que alguna de las desigualdades anteriores sea estricta.

Simplificamos el sistema y deducimos
$
  cases(
    theta^((1)) S_0 (u - e^(r T)) & >= 0,
    theta^((1)) S_0 (m - e^(r T)) & >= 0,
    theta^((1)) S_0 (d - e^(r T)) & >= 0,
  )
$
Es decir que existe arbitraje si $u <= e^(r T)$ o $d <= e^(r T)$ (y tomamos $theta^((1)) = plus.minus 1$). La condición de no arbitraje es precisamente es, como en modelo @eq-unperiodo-2states
$
  d < e^(r T) < u.
$
Recordamos que esta es la ecuación @eq-binomial-condicion-no-arbitraje.


=== Medida de riesgo neutro

Vamos a intentar construir esta medida. Las medidas $QQ$ equivalentes a $PP$ vienen dadas por los valores
$
  q_u := QQ(S_T = u S_0), quad q_m := QQ(S_T = m S_0), quad "y" quad q_d := QQ(S_T = d S_0) .
$
Debemos pedir $q_u, q_m, q_d in (0,1)$.
Tenemos que pedir que el precio descontado sea una martingala, es decir que
$
  S_0 = e^(-r T) EE^QQ [S_T] = e^(-r T) (q_u u S_0 + q_m m S_0 + q_d d S_0).
$
donde $q_i = QQ(S_T = i S_0)$. Escribiendo $q_m = 1 - q_u - q_d$ deducimos que
$
  e^(r T) = q_u (u -m) + m - q_d (m - d).
$
// En el plano $(q_u,q_d)$ esto es una recta que pasa por los puntos $((e^(r T) - m)/(m-d), 0)$ y $(0, (m-e^(r T))/(m-d))$.
que reescribimos como
$
  q_d = (m - e^(r T) )/(m-d) + q_u (u-m)/(m-d).
$
Además debemos pedir que $q_i > 0$ con lo que basta pedir $q_u + q_d in (0,1)$. Cuando $q_u in (0,1)$ entonces $q_d in ((m - e^(r T) )/(m-d), (u - e^(r T) )/(m-d) )$. La pregunta es si este intervalo interseca $(0,1)$.

Hay tres opciones:
- Si $m >= e^(r T)$ entonces, si además tenemos la condición de no arbitraje $d < e^(r T)$ deducimos $(m-e^(r T))/(m-d) in [0,1)$ y existen soluciones
- Si $m <= e^(r T)$ entonces $(m - e^(r T) )/(m-d) <=0$, pero con la condición $u > e^(r T)$ deducimos que $(u - e^(r T) )/(m-d) > 0$ y, por tanto, hay soluciones.

De hecho, la intersección es siempre un intervalo y, por tanto,
#proposition[
  En el mercado @fig-trinomial, bajo la hipótesis @eq-binomial-condicion-no-arbitraje existen infinitas medidas de riesgo neutro.
]

=== Valoración de derivados

Ahora ocurre que con un sólo activo de riesgo y el bono, las carteras no permiten general replicar todos los estados, porque el sistema tiene 2 incógnitas y 3 ecuaciones.
Se dice que el mercado es *incompleto*.

Siguiendo el mismo razonamiento que en @prop-binomial-esperanza-implica-noarbitraje obtenemos el siguiente resultado:
#proposition[
  Consideremos un derivado $C$ y
  $
    C_0 = e^(-r T) EE^QQ [C_T] "para alguna" QQ "medida de riesgo neutro".
  $
  Entonces el mercado ${S, B, C}$ no admite arbitraje.
]

#proof[
  Por ejemplo, sea $C_t$ una _call_ europea. No hay una forma de dar un precio por replicación a $C_0$. Supongamos que existe una cartera $hat(theta)$ con arbitraje
  $
    hat(V)_t = theta^((1)) S_t + theta^((2)) B_t + theta^((3)) C_t.
  $
  Pero entonces calculando el valor esperado
  $
    0 < e^(-r T) EE^QQ [hat(V)_T] &= theta^((1)) e^(-r T) EE^QQ [S_t] + theta^((2)) e^(-r T) EE^QQ [B_t] + theta^((3)) e^(-r T) EE^QQ [C_T] \
    &= theta^((1)) S_0 + theta^((2)) + theta^((3)) C_0 = V_0 <= 0.
  $
  Esto es una contradicción.
]
Esto nos permite definir el conjunto de precios de no arbitraje
$
  cal(C)_0 := lr({e^(-r T) EE^QQ [C_T] : QQ "es medida de riesgo neutro para" {S,B}}, size: #150%)
$

#exercise[][
  Comprobar en un ejemplo que si $C_0 in.not cal(C)_0$ entonces el mercado ${S, B, C}$ admite arbitraje.
]

== Modelo matricial: $N$ activos y $M$ estados

Supongamos ahora que hay $N$ activos (incluyendo opciones y bonos). Denotaremos
$
  bold(S)_t = vec(S^((1))_t, dots.v, S_t^((N))) in RR^N
$
donde $S^i_t$ denota la cantidad del activo $i$-ésimo a tiempo $t$.
Asumimos que $S_0$ es conocido y $S_T$ puede estar en $M$ estados.
Una cartera consiste en un vector $theta in RR^N$ donde $theta_i$ indica el número de acciones del activo $i$-ésimo.
Denotamos $D_(i j)$ al valor del activo $i$-ésimo en el estado $j$-ésimo a tiempo $T$, de modo que
$
  bold(S)_T in { D_(bullet 1), dots, D_(bullet M) } "donde" D_(bullet j) = vec(D_(1j), dots.v, D_(N j))
$
y $PP(bold(S)_T = D_(bullet j)) > 0$ para todo $j$.

=== Carteras y vector de estado
Así el valor de cartera a tiempo $t$
$
  V_0 = bold(S)_0 dot theta => V_T in { D_(bullet 1) dot theta, dots, D_(bullet M) dot theta } = op("elements") (D^trans theta).
$
donde $trans$ denota la transposición de matrices.

Introducimos la notación para $x in RR^N$ se dice que
- $x >= 0$ (o $x in RR^N_+$) si $x_i >= 0$ para todo $i$. Es decir, todas las entradas son no-negativas.
- $x gt.neq 0$ o si $x>=0$ y $x != 0$. Es decir, tiene alguna entrada positiva.
- $x > 0$ (o $x in RR^N_(++)$) si $x_i > 0$ para todo $i$. Es decir, tiene _todas_ las entradas positivas.

Así, la condición de no-arbitraje se traduce en que existe $theta in RR^N$ tal que
$
  bold(S)_0 dot bold(theta) <= 0 & " y " D^trans bold(theta) gt.neq 0.
$
#definition[Vector de estado][
  Vector $psi in RR^M_(++)$ tal que
  $
    bold(S)_T = D psi.
  $
]
Supongamos que podemos encontrar carteras $bold(theta)^([i])$ tales que
$
  D^trans bold(theta)^([i]) = e_i in RR^M "para todo" i in {1,dots,N}.
$
se llaman valores de Arrow-Debreu. En tal caso tenemos
$
  bold(S)_0 dot bold(theta)^([i]) = (D psi) dot bold(theta)^([i]) = psi dot (D^trans bold(theta)^([i])) = psi dot e_i = psi_i.
$

#theorem[Teorema Fundamental de Valoración de Activos][
  En el modelo de un periodo temporal, $N$ activos, $M$ estados no existe arbitraje si y sólo si existe un vector de estados.
]

La demostración de este teorema es una aplicación del teorema de separación de Hahn-Banach.
Ver #cite(<etheridgeCourseFinancialCalculus>, supplement: "Theorem 1.5.2").

=== Medida de riesgo neutro
Este vector de estados, también nos da una forma de construir la medida de riesgo nulo
$
  QQ(bold(S)_T = D_(bullet j)) := psi_j / psi_0
  quad "y" quad
  psi_0 := sum_(j=1)^M psi_j.
$
Entonces observamos que
$
  EE^QQ [bold(S)_T] = bold(S)_0 / psi_0
$
Así, $psi_0$ resulta nuestro factor de descuento, y el precio descontado $tilde(bold(S)_t) = psi_0 bold(S)_t$ es una martingala respecto de $QQ$.

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

=== Volatilidad de una cartera

Ahora estudiamos
$
  var(V^(bold(theta))_t) & = EE [(bold(theta) dot.c bold(S)_t - overline(bold(theta) dot.c bold(S)_t) )^2] = EE[ ( bold(theta) dot.c (bold(S)_t - overline(bold(S))_t) )^2] \
  & = sum_(i,j) theta_i theta_j cov(S_t^((i)), S_t^((j))) \
  & = bold(theta)^trans Sigma(bold(S)_t) bold(theta)
$
donde $Sigma (bold(S)_t)$ es la matriz de covarianzas.
