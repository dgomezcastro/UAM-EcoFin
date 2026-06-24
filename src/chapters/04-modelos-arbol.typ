// LTeX: language=es
#import "../header/template.typ": *

= Modelo de varios periodos temporales: árbol binomial

== Modelo de 2 periodos

Consideremos ahora un árbol, donde consideramos los eventos que ocurren en $t_k = k Delta t$ que podemos denotar como @fig-arbol
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  s[label="S_0"]
  s1[label="s_1^((1))"]
  s11[label="s_2^((11))"]
  s12[label="s_2^((10))"]
  s2[label="s_1^((0))"]
  s21[label="s_2^((01))"]
  s22[label="s_2^((00))"]
  s -> s1[label="p_1"]
  s -> s2[label="1-p_1"]
  s1 -> s11[label="p_12"]
  s1 -> s12 [label="1-p_12"]
  s2 -> s21 [label="p_22"]
  s2 -> s22[label="1-p_22"]
  }
  ```),
  caption: "Árbol binomial con dos periodos de tiempo",
)
Podría ocurrir que algunos de los valores anteriores coincidan.

$
  Omega = {(00), (01), (10), (11)}
$
En este modelo definimos $S_0, S_1, S_2 : Omega -> RR$ mediante
$
  S_0 (omega_1 omega_2) := S_0, quad S_1 (omega_1 omega_2) := s_1^( (omega_1)), quad S_2(omega_1 omega_2) := s_2^((omega_1omega_2))
$
En interesante señalar que $S_1$ no depende de $omega_2$.
Esta misma idea puede reproducirse en múltiples periodos.

== Modelo de $N$ periodos

Consideremos ahora un árbol, donde consideramos los eventos que ocurren en $t_k = k Delta t$ donde, por simplicidad, nos vamos
$
  PP(S_(t + Delta t) = u S_t) = p " y " PP(S_(t+Delta t)= d S_t) = 1-p \
  PP(B_t = e^(r t)) = 1
$<eq-arbol>
Podemos verlo en como @fig-arbol
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  s[label="S_0"]
  s1[label="u S_0"]
  s11[label="u^2 S_0"]
  s12[label="u d S_0"]
  s2[label="d S_0"]
  s22[label="d^2 S_0"]
  s111[label="..."]
  s112[label="..."]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1 -> s11[label="p"]
  s1 -> s12 [label="1-p"]
  s2 -> s12 [label="p"]
  s2 -> s22[label="1-p"]
  s11 -> s111[label="...."]
  s11 -> s112[label="...."]
  }
  ```),
  caption: "Árbol binomial con dos periodos de tiempo",
)<fig-arbol>

Según las hipótesis la elección de $u$ y $d$ se habla de modelo de Cox-Ross-Rubinstein o Jarrow-Rudd.

Muchas de las construcciones que vamos a hacer son completamente generales, pero este elección simple basta para la mayoría de ejemplos.

#exercise[
  Comprobar que si $t = n Delta t$ entonces las probabilidades de alcanzar un estado concreto vienen dadas por
  $
    PP(S_t = S_0 u^k d^(n-k)) = binom(n, k) p^k (1-p)^(n-k).
  $
  Relacionar este resultado con la distribución binomial.
]


== Carteras y arbitraje

Una presentación introductoria de esta sección se puede encontrar en @etheridgeCourseFinancialCalculus. Una presentación más avanzada puede verse en @bjorkArbitrageTheoryContinuous2019.

#definition(breakable: true)[Cartera de inversión][
  Si tenemos $M$ activos de cuyo valores denotamos $S_t^((i))$ una cartera consiste en mantener cantidades $theta^((i))_t in RR$ de ellos en los tiempos $[t , t + Delta t]$.
  Utilizamos la siguiente convención:
  - si $theta_t^((i)) > 0$ decimos que estamos en una posición larga (hemos comprado el activo en el mercado), y
  - si $theta_t^((i)) < 0$ decimos que estamos en una posición corta (hemos pedido prestado a un broker el activo).
  Una cartera es un proceso estocástico $theta_t = (theta_t^((1)), dots.c, theta_t^((M)))$
  definido para $t = 0, ..., T-Delta t$
  adaptado a la información conocida, es decir tal que
  $
    theta_t = F_t (S_0, S_(Delta t), S_(2 Delta t), dots.c, S_(t-Delta t)).
  $<eq-arbol-carteraadaptada>
  El valor de la cartera se expresa
  $
    V_t := sum_(i=1)^M theta_t^((i)) S_t^((i)) = theta_t dot S_t.
  $<eq-arbol-valorcartera>
]
Añadimos la condición de que sea autofinanciada, es decir que a tiempo $t+Delta t$ podríamos la posición y usamos todo el dinero para una nueva cartera
$
  underbrace(theta_t dot S_(t), "valor de la cartera" \ "construida a tiempo" t-Delta t "en" t) = underbrace(theta_(t+ Delta t) dot S_(t), "valor de la nueva cartera" \ "en" t)
  " para todo " t = 0, ..., T - Delta t.
$
Denotando
$
  Delta S_t := S_(t + Delta t) - S_t,
$
$Delta theta_t := theta_(t+Delta t) - theta_t$, etc...  esto significa que
$
  S_(t) dot Delta theta_t = 0.
$<eq:arbol-autofinanciacion2>
Desarrollando
$
  Delta V_t & = (Delta theta_t) dot S_(t) + theta_t dot Delta S_t
$
obtenemos la formulación equivalente
#definition[Cartera autofinanciada][
  Diremos que una cartera $theta_t$ es autofinanciada si satisface
  $
    Delta V_t = theta_t dot Delta S_t " para todo " t = 0, ... , T - Delta t.
  $<eq:arbol-autofinanciacion>
]
La idea de arbitraje sigue siendo que conseguiremos dinero sin poner nada de nuestra parte. Esto quiere decir no hacer inversión inicial, y no tener que hacer inversiones posteriores. De aquí que nuestra nueva definición incluya la autofinanciación.
#definition[Oportunidad de arbitraje en el modelo discreto en tiempo][
  Decimos que una cartera $V$ es una oportunidad de arbitraje si existe
  $
    V_t "es autofinanciada",
    quad quad & V_0 <= 0,
                quad quad & V_T >= 0,
                            quad quad & PP(V_T > 0) > 0.
  $
]

#exercise[Condición de no-arbitraje][
  Comprobar que si falla la condición
  $
    d < e^(r Delta t) < u,
  $<eq-arbol-noarbitraje>
  entonces existen oportunidades de arbitraje en el mercado ${S, B}.$
]

== Valoración por replicación

Veamos ahora que las carteras autofinanciadas son las única que

#theorem[Valoración por replicación][
  Si $V_t$ y $H_t$ son dos productos tales que $H_T = V_T != 0$, entonces $H_t = V_t$ para todo $t in [0,T]$ o el mercado ${S, B, H}$ admite arbitrajes.
]
#proof[
  Veamos que si $V_t != H_t$ para algún $t$ entonces el mercado admite una oportunidad de arbitraje.
  Sea $t_0$ cualquier tiempo donde.
  Por construcción $t_0 < T$.
  En el mercado de productos $(V_t, H_t)$ podemos construir el producto
  construímos una nueva cartera formada por $hat(theta)_t^((1))$ unidades de la cartera replicante, y $hat(theta)_t^((2))$ unidades del derivado donde
  $
    hat(theta)_t^((1)) & := cases(0 & "si" t<=t_0, -sign(V_(t_0) - H_(t_0))H_(t_0) & "si" t>=t_0+Delta t) \
    hat(theta)_t^((2)) & := cases(0 & "si" t<=t_0, sign(V_(t_0) - H_(t_0))V_(t_0) & "si" t>=t_0+Delta t)
  $
  donde $sign(0) = 0$.
  Esta es una cartera admisible, porque mira sólo al pasado.

  Comprobamos que es autofinanciada verificando @eq:arbol-autofinanciacion2.
  Si $t != t_0$ entonces la condición es trivial porque $Delta theta_t = 0$.
  Tenemos que $theta_(t_0) = 0$.
  Por la elección de $t_0$ tenemos que $V_(t_0 + Delta t) = H_(t + Delta t_0)$ de modo que
  $
    Delta hat(theta)_(t_0)^((1)) dot V_(t_0) + Delta hat(theta)_(t_0)^((2)) dot H_(t_0) &= hat(theta)_(t_0+Delta t)^((1)) dot V_(t_0) + hat(theta)_(t_0 )^((2)) dot H_(t_0)
    \
    &= -sign(V_(t_0) - H_(t_0)) V_(t_0) H_(t_0) + sign(V_(t_0) - H_(t_0))H_(t_0) V(t_0)
    \
    &= 0.
  $

  Además, el valor de esta cartera resulta
  $
    hat(V)_t := cases(
      0 & "si" t in [0,t_0],
      sign(V_(t_0) - H_(t_0))(V_(t_0) H_t - H_(t_0) V_t) & "si" t in [t_0 + Delta t,T]
    )
  $
  De este modo $V_0 = 0$, $V_T = |V_(t_0) - H_(t_0)| H_T >= 0$. Como $V_(t_0) != H_(t_0)$ entonces $V_T > 0$ con probabilidad positiva.
]

== Medida libre de riesgo

Recordamos un par de una definición de estadística.
#definition(breakable: true)[Valor esperado condicionado][
  Sean $X, Y$ variables aleatorias discretas

  Se define la esperanza condicionada a un evento con $PP(Y=y) > 0$ como el escalar
  $
    EE^PP [X | Y=y] := sum_(x:PP(X=x) > 0) x PP(X = x|Y=y) = sum_(x:PP(X=x) > 0) x (PP(X = x inter Y=y))/(PP(Y=y)).
  $
  Se define la esperanza condicionada como $g(Y) := EE^PP [X|Y]$ la variable aleatoria tal que
  $
    g(y) := EE^PP [X|Y = y].
  $

  De manera similar se puede definir $EE^PP [X|cal(F)]$ donde $cal(F)$ es una $sigma$-álgebra. Ocurre que $EE^PP [X | Y] = EE^PP [X | sigma(Y)]$.
]

Ahora vamos a introducir la medida de riesgo neutro, utilizando el precio descontado
$
  tilde(S)_t := S_t / B_t.
$

#definition[Medida de riesgo neutro para un árbol binomial][
  Medida de probabilidad $QQ ~ PP$ tal que
  $
    EE^QQ [tilde(S)_(t+Delta t) | tilde(S_t) ] = tilde(S_t).
  $<eq-arbol-medida-libre-de-riesgo>
  Puede escribirse @eq-arbol-medida-libre-de-riesgo equivalentemente como
  $
    EE^QQ lr([tilde(S)_(t+Delta t) | tilde(S_t) = s], size: #200%) = s "para todo" s "tal que" PP(tilde(S_t) = s) > 0
  $
]
#exercise[
  Demostrar por inducción que si $t > s$ entonces
  $
    EE^QQ [tilde(S_t) | tilde(S)_s] = tilde(S)_s.
  $ <eq-arbol-martingala>
]


Deducimos de nuevo que

#theorem[Existencia de la medida de no arbitraje][
  Existe una medida de riego neutro para el árbol binomial si y sólo si se da la condición de no arbitraje @eq-arbol-noarbitraje.
  En tal caso se tiene
  $
    QQ(S_(t + Delta t) = u S_t) = (e^(r Delta t) - d)/(u - d)
  $
  Es habitual denotar este valor por $q$.
]
Nótese que
$
  QQ(S_(t + Delta t) = d S_t) = (u - e^(r Delta t))/(u - d).
$
#proof[
  Aplicamos la definición para calcular $q$ la probabilidad de subida
  $
    s = EE^QQ [tilde(S)_(t + Delta t) | tilde(S)_t = s] = q e^(-r Delta t) u s + (1-q)e^(-r Delta t) d s.
  $
  Dado que $QQ ~ PP$ debemos imponer que $0 < q < 1$.
]

Las carteras autofinanciadas son martigalas. Para evitar introducir ahora la noción detallada, vamos simplemente a demostrar la siguiente propiedad que nos permitirá valor activos a tiempo $t = 0$.

#proposition[][
  En un árbol binomial, una cartera @eq-arbol-valorcartera autofinanciada, es decir tal que @eq:arbol-autofinanciacion satisface
  $
    EE^QQ [tilde(V)_t] = V_0
  $
]
#proof[
  Multiplicando @eq:arbol-autofinanciacion2 por $e^(-r (t + Delta t))$ obtenemos la versión descontada
  $
    (Delta theta_t) dot tilde(S)_(t+Delta t) = 0.
  $
  Así, desarrollamos la resta
  $
    Delta tilde(V_t) & = theta_t dot Delta tilde(S)_t.
  $
  Aplicando @eq-arbol-martingala con $s = 0$ deducimos que $EE^QQ [tilde(S)_t] = S_0$ y deducimos que $EE^QQ [tilde(V)_(t + Delta t)] = E^QQ [tilde(V)_t]$. Inductivamente deducimos el resultado.
]


#corollary[Valor de un derivado con vencimiento a tiempo fijo][
  En el modelo @eq-arbol, consideremos un derivado de valor $H$ del que conocemos su valor a vencimiento $T$ con $H_T >= 0$. El precio libre de arbitraje viene dado por
  $
    H_0 = e^(-r T) EE^QQ [H_T].
  $
]

#proof[
  Siguiendo la idea del modelo de un periodo, es fácil construir una cartera autofinanciada $V_t$ tal que $V_T = H_T$.
  De modo que $V_t = H_t$ en cada tiempo (o es posible construir una cartera con arbitraje), y por tanto también $tilde(H)_t = tilde(V)_t$. Concluímos que
  $
    H_0 = V_0 = EE^QQ [tilde(V)_T] = EE^QQ [tilde(H)_T] = EE^QQ [e^(-r T) C_T].
  $
  Esto concluye la demostración.
]

== Valor de una call europea

De manera similar al caso de un periodo, las opciones _call europeas_ se puede reproducir por una cartera, y deducimos que
#theorem[
  El precio de no arbitraje de una opción _call_ europea viene dado por
  $
    C_0 & =
          cases(
            0 & "si" u^N S_0 <= K,
            S_0 op("B")(a; N, rho) - K e^(-r T) op("B")(a; N, q) & "si" u^N S_0 > K.
          )
  $<eq-arbol-call>
  donde $T = N Delta t$ y, si $u^N S_0 > K$ entonces definimos
  $
                  a & := min {x in [0, N) inter ZZ : u^x d^(N-x) S_0 - K >= 0} \
                  q & := (e^(r Delta t) - d)/(u-d) \
                rho & := e^(-r Delta t) u q \
    op("B")(a; N,p) & := sum_(j=a)^N binom(N, j) p^j (1-p)^(N-j)
  $
]
Nótese que
$
  op("B")(a; N,p) = 1 - F_(op("B")(N,p)) (a-1).
$

#proof[
  Así, tenemos que
  $
    EE^QQ [C_T] & = EE^QQ [(S_T - K)_+] = sum_(j=0)^N (u^j d^(N-j) S_0 - K)_+ QQ(S_T = u^j d^(N-j)S_0).
  $
  Observando el árbol es fácil basta contar caminos para ver que
  $
    QQ(S_T = u^j d^(N-j)S_0) = binom(N, j) q^j (1-q)^(N-j).
  $
  Concluímos que
  $
    C_0 = e^(-r T) sum_(j=0)^N binom(N, j) q^j (1-q)^(N-j) (u^j d^(N-j) S_0 - K)_+.
  $
  Ahora descomponemos la parte positiva
  $
    (u^j d^(n-j) S_0 - K)_+
    = cases(
      u^j d^(n-j) S_0 - K & "si " j >= a,
      0 & "si " j < a.
    )
  $
  Así, reescribimos
  $
    C_0 & = e^(-r T) sum_(j=a)^N binom(N, j) q^j (1-q)^(N-j) (u^j d^(n-j) S_0 - K) \
        & = S_0 sum_(j=a)^N binom(N, j) (e^(-r Delta t) u q)^j (e^(-r Delta t) d(1-q))^(N-j) \
        & quad - K e^(-r T) sum_(j=a)^N binom(N, j) q^j (1-q)^(N-j) \
  $
  Recordando la construcción de $q$ y tomando $rho = e^(-r Delta t) u q$ observamos que $e^(-r Delta t) d (1-q) = 1-rho$. De modo que, recordando la fórmula de una binomial
  $
    C_0 & = S_0 sum_(j=a)^N binom(N, j) rho^j (1-rho)^(N-j) - K e^(-r T) sum_(j=a)^N binom(N, j) q^j (1-q)^(N-j) \
        & = S_0 op("B")(a; N, rho) - K e^(-r T) op("B")(a; N, q)
  $

  Lo que concluye la demostración.
]

#exercise[][
  + Valorar una opción _call_ europea donde
    $
      S_0 = 1, u=1.2, d=0.9, K=1, r=0, T=1, N = 2
    $
  + Escribir un programa que permita valorar opciones europeas de manera automática.
]

== Opciones americanas

Sea $phi.alt(s) = (s - K)_+$. Para una opción americana debe tenerse que
$
  V_t = max lr(
    (
      underbrace(phi.alt(S_t), "valor de ejercer \n la opción"), quad
      underbrace(e^(-r Delta t) EE^QQ [ V_(t + Delta t) | S_t], "valor de mantener la opción \n una unidad de tiempo")
    )
    , size: #50%
  )
$
Dado que $V_t$ depende sólo del valor "futuro", podemos resolver este sistema a tiempo $t = T - Delta t, T - 2 Delta t, dots.c$

Si escribimos
$
  V_j^((i)) := lr(["value at" t = j Delta t "of" V_(t) "provided that" S_(t) = S_0 u^(i) d^(j - i)], size: #150%)
$
para $T = N Delta t$ entonces $V_N^((i)) = phi.alt(S_0 u^i d^(N - i))$ y si tomamos $j < N$ entonces
$
  V_j^((i)) = max lr(
    (
      phi.alt(S_0 u^i d^(j-i))
      quad , quad
      e^(-r Delta t) (q V_(j+1)^((i+1))+ (1-q) V_(j+1)^((i)))
    )
    , size: #150%
  )
$

#exercise[
  + Valorar una opción _call_ americana donde
    $
      S_0 = 1, u=1.2, d=0.9, K=1, r=0, T=1, N = 2
    $
  + Escribir un programa que permita calcular el valor de una opción americana en función de $(K, r, N, u, d)$.
  + Además, dibujar el árbol y señalar en rojo en qué estados la opción se ha ejercido, es decir cuando $V_t = phi.alt(S_t)$.
    A este valor se le llama a veces "frontera libre".
]


== Filtraciones y valor de una call en tiempo $t$

Para la definición de una $QQ$ nos ha bastado con condicionar $|tilde(S_t)$ por que cada periodo depende sólo del anterior, a esto se lo conoce como Markovianidad. Para valor una cartera, debemos saber el precio actual de la cartera, lo que requiere conocer los pesos. La forma más sencilla de hacer esto es utilizar "toda la información en $[0,t]$". La forma de hacer es con la filtración temporal.

Una filtración es una sucesión no-decreciente de $sigma$-algebras
$
  s < t => cal(F)_s subset cal(F)_t.
$

Dado que a tiempo $t = n Delta t$ sabemos qué ha ocurrido pero no qué ocurrirá, los conjuntos de sucesos que podemos medir
son los que están en la $sigma$-álgebra correspondiente es
$
  cal(F)_t := {S_s^(-1) (B) : B in cal(B), s in [0,t]}.
$
Si $A in cal(F)_t$ entonces
$
  A = A' times {0,1}^(N-n) " con " A' in {0,1}^n.
$

Esta es la llamada $sigma$-álgebra generada por $(S_s | s in [0,s])$, que a veces se denota $cal(U)(S_s | s in [0,s])$.

La condición de que la cartera esté adaptada a la información conocida (ver @eq-arbol-carteraadaptada) se expresa en estos términos como que $theta_t$ sea medible respecto de $cal(F)_(t-Delta t)$, lo que a veces se llama que sea *proceso adaptado a $cal(F)_(t-Delta t)$*.

#exercise[
  Sea $theta_t = F_t (S_0, dots.c, S_N)$ con $T = N Delta t$ y sea $t = n Delta t$ con $n < N$.
  Comprobar que son equivalentes
  - $theta_t = F_t (S_0, dots.c, S_(t-Delta t))$
  - $theta_t^(-1) ({a}) = A' times {0,1}^(N-n+1)$
  - $theta_t$ es medible respecto $cal(F)_(t-Delta t)$
]

Podemos pensar en
$
  EE[Phi(S_0, dots.c, S_T) | cal(F)_t]
$
como la esperanza fijados $S_0, dots.c, S_t$ y promediando entre los valores de $S_(t+Delta t), dots.c, S_T$.

De manera que podemos escribir
$
  tilde(S)_s = EE^QQ [tilde(S_t) | tilde(S)_s] = EE^QQ [tilde(S_t) | cal(F)_s].
$
De este modo, razonando como lo hicimos a tiempo $t = 0$ para tiempos generales, tenemos que
$
  C_t = e^(-r(T-t)) EE^QQ [(S_T - K)_+ | cal(F)_t].
$<eq-arbol-call-tiempot>

== VaR

Dada una cartera con coeficientes $theta$, se tiene la probabilidad
$
  PP(V_T <= v) = sum_(j "s.t." theta dot D_(bullet j) <= v) PP(S_T = D_(bullet j)).
$
Esto nos da una función de "distribución" discreta, y hemos de buscar el mínimo $v$ de manera que se de esta propiedad
$
  "VaR" N-"días al" X% = "inf" { v "tal que" PP(V_T <= v) >= 1 - X/100 }.
$


// Desde el punto de vista teórico, una filtración es
// #definition[Filtración][
//   En un espacio de probabilidad $(Omega, cal(U), PP)$,
//   una familia $cal(F)_t$ de $sigma$-álgebras de $cal(U)$ se llama filtración (o _no-anticipada respecto de $S$_) si
//   - $t>=s>=0$ implica $cal(F)(t) supset cal(F)(s)$
//   -
// ]
