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
En este modelo definimos $S_0, S_(T/2), S_T : Omega -> RR$ mediante
$
  S_0 (omega_1 omega_2) := S_0, quad S_(T/2) (omega_1 omega_2) := s_1^( (omega_1)), quad S_T (omega_1 omega_2) := s_2^((omega_1omega_2))
$
En interesante señalar que $S_1$ no depende de $omega_2$.


== Modelo de $N$ periodos

Introducimos donde constantes $0 < d < u$ e, informalmente, el modelo dado por $S_0$ determinista y
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

#exercise[
  Comprobar que si $t = n Delta t$ entonces las probabilidades de alcanzar un estado concreto vienen dadas por
  $
    PP(S_t = S_0 u^k d^(n-k)) = binom(n, k) p^k (1-p)^(n-k).
  $
  Relacionar este resultado con la distribución binomial.
]

== Proceso estocástico

Tomamos
- $Omega = {0,1}^N$ donde $N Delta t = T$. Para $bold(omega) in Omega$ usaremos la notación $bold(omega) = (omega_(Delta t), omega_(2Delta t), dots.c , omega_T)$.
- $cal(F) = 2^Omega$, la $sigma$-álgebra de puntos
- La medida de probabilidad es
  $ PP(bold(omega)) := p^(a) (1-p)^(N-a) "donde" a := "número de 1s en "bold(omega) = sum_(t=1)^N omega_t. $

#exercise[Comprobar que la construcción $PP$ es la única medida de probabilidad en $Omega$ tal que
  + $PP({bold(omega) in Omega : omega_t = 1}) = p$ y
  + las variables aleatorias $X_t : Omega -> RR$ dadas por $X_t (bold(omega)) = omega_t$ son independientes.
]

Tomamos $S_0$ determinista y
$
  S_t := R_t S_(t-1)
$
donde los retornos $R_t$ vienen dados por
$
  R_t (bold(omega)) := cases(
    u & "si" omega_t = 1\,,
    d & "si" omega_t = 0.
  )
$
con $d < u$. Por supuesto $B_t (bold(omega)) = e^(r t)$.

#exercise[
  Comprobar que
  $
    PP(R_t = u) = PP(omega_t = 1) = p.
  $
]

Muchas de las construcciones que vamos a hacer son completamente generales, pero este elección simple basta para la mayoría de ejemplos.


== Carteras y arbitraje

Una presentación introductoria de esta sección se puede encontrar en @etheridgeCourseFinancialCalculus. Una presentación más avanzada puede verse en @bjorkArbitrageTheoryContinuous2019.

#definition[Derivado o derecho contingente en el modelo @eq-arbol][
  Proceso estocástico $H = (H_0, H_(Delta t), dots.c, H_T)$ contingente de los valores conocidos de $S$
  $
    H_t = h_t (S_0, dots.c, S_t)
  $
  donde si $t = n Delta t$ entonces $h_t : RR^n -> RR$ y depender de los parámetros del modelo
]
En inglés se habla de _contingente claim_.

#definition(breakable: true)[Cartera de inversión en el modelo @eq-arbol][
  Si tenemos $M$ derivados cuyos valores denotamos $S_t^((i))$ una cartera en el mercado ${S^((1)), dots.c , S^((M))}$ consiste en mantener cantidades $theta^((i))_t in RR$ de ellos en los tiempos $[t - Delta t, t ]$.
  Las escribimos en un vector $bold(theta)$.
  Fijamos por convención $bold(theta)_0 = bold(theta)_(Delta t)$.
  Una cartera es un proceso estocástico $bold(theta)_t = (theta_t^((1)), dots.c, theta_t^((M)))$
  definido para $t = 0, ..., T-Delta t$
  adaptado a la información conocida, es decir tal que
  $
    bold(theta)_t = bold(F)_t (bold(S)_0, bold(S)_(Delta t), bold(S)_(2 Delta t), dots.c, bold(S)_(t-Delta t)).
  $<eq-arbol-carteraadaptada>
  $bold(F)_t$ puede depender de los parámetros en @eq-arbol.
  El valor de la cartera se expresa
  $
    V^(bold(theta))_t := sum_(i=1)^M theta_t^((i)) S_t^((i)) = bold(theta)_t dot bold(S)_t.
  $<eq-arbol-valorcartera>
]
Añadimos la condición de que sea autofinanciada, es decir que a tiempo $t+Delta t$ podríamos la posición y usamos todo el dinero para una nueva cartera
$
  underbrace(bold(theta)_t dot bold(S)_(t), "valor de la cartera" \ "construida a tiempo" t-Delta t "en" t) = underbrace(bold(theta)_(t+ Delta t) dot bold(S)_(t), "valor de la nueva cartera" \ "en" t)
  " para todo " t = 0, ..., T - Delta t.
$
Denotando
$
  Delta bold(S)_t := bold(S)_(t + Delta t) - bold(S)_t,
$
$Delta theta_t := theta_(t+Delta t) - theta_t$, etc...  esto significa que
$
  bold(S)_(t) dot Delta bold(theta)_t = 0.
$<eq:arbol-autofinanciacion2>
Desarrollando
$
  Delta V_t & = (Delta bold(theta)_t) dot bold(S)_(t) + bold(theta)_t dot Delta bold(S)_t
$
obtenemos la formulación equivalente
#definition[Cartera autofinanciada][
  Diremos que una cartera $bold(theta)_t$ es autofinanciada si satisface
  $
    Delta V^(bold(theta))_t = bold(theta)_t dot Delta bold(S)_t " para todo " t = 0, ... , T - Delta t.
  $<eq:arbol-autofinanciacion>
]
La idea de arbitraje sigue siendo que conseguiremos dinero sin poner nada de nuestra parte. Esto quiere decir no hacer inversión inicial, y no tener que hacer inversiones posteriores. De aquí que nuestra nueva definición incluya la autofinanciación.
#definition[Oportunidad de arbitraje en el modelo discreto en tiempo][
  Decimos que una cartera $bold(theta)$ es una oportunidad de arbitraje si existe
  $
    bold(theta) "es autofinanciada",
    quad quad & V_0^(bold(theta)) <= 0,
                quad quad & V_T^(bold(theta)) >= 0,
                            quad quad & PP(V_T^(bold(theta)) > 0) > 0.
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
  Si $V_t$ y $H_t$ son dos derivados tales que $H_T = V_T != 0$, entonces $H_t = V_t$ para todo $t in [0,T]$ o el mercado ${S, B, H}$ admite arbitrajes.
]<thm-arbol-valor-replicacion>
#proof[
  Veamos que si $V_t != H_t$ para algún $t$ entonces el mercado admite una oportunidad de arbitraje.
  Sea $t_0$ cualquier tiempo donde.
  Por construcción $t_0 < T$.
  En el mercado de derivados $(V_t, H_t)$ podemos construir el derivado
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
    Delta hat(theta)_(t_0)^((1)) dot V_(t_0) + Delta hat(theta)_(t_0)^((2)) dot H_(t_0) &= hat(theta)_(t_0+Delta t)^((1)) dot V_(t_0) + hat(theta)_(t_0 + Delta t )^((2)) dot H_(t_0)
    \
    &= -sign(V_(t_0) - H_(t_0)) V_(t_0) H_(t_0) + sign(V_(t_0) - H_(t_0))H_(t_0) V_(t_0)
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
  En un árbol binomial, una cartera $bold(theta)$ autofinanciada satisface
  $
    EE^QQ [tilde(V)^(bold(theta))_t] = V_0
  $
]
#proof[
  Multiplicando @eq:arbol-autofinanciacion2 por $e^(-r (t + Delta t))$ obtenemos la versión descontada
  $
    (Delta bold(theta)_t) dot tilde(bold(S))_(t+Delta t) = 0.
  $
  Así, desarrollamos la resta
  $
    Delta tilde(V_t) & = bold(theta)_t dot Delta tilde(bold(S))_t.
  $
  Aplicando @eq-arbol-martingala con $s = 0$ deducimos que $EE^QQ [tilde(S)_t] = S_0$ y deducimos que $EE^QQ [tilde(V)_(t + Delta t)] = E^QQ [tilde(V)_t]$. Inductivamente deducimos el resultado.
]


#corollary[Valor de un derivadomediante medida de riesgo neutro][
  En el modelo @eq-arbol, consideremos un derivado$H$.
  Entonces el mercado ${S, B, H}$ es libre de arbitraje si y sólo si
  $
    H_0 = e^(-r T) EE^QQ [H_T].
  $
]

#proof[
  Siguiendo la idea del modelo de un periodo, es fácil construir una cartera autofinanciada $V_t$ tal que $V_T = H_T$.
  De modo que usando @thm-arbol-valor-replicacion, o bien $V_t = H_t$ en cada tiempo, o es posible construir una cartera con arbitraje en el mercado ${S, B, H}$. Por tanto, también se tiene $tilde(H)_t = tilde(V)_t$. Concluimos que
  $
    H_0 = V_0 = EE^QQ [tilde(V)_T] = EE^QQ [tilde(H)_T] = EE^QQ [e^(-r T) H_T].
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
            S_0 op("B")(a; N, rho) - K e^(-r T) op("B")(a; N, q) & "si" u^N S_0 > K,
            0 & "si" u^N S_0 <= K.
          )
  $<eq-arbol-call>
  donde $T = N Delta t$ y, si $u^N S_0 > K$ entonces definimos
  $
                  a & := ceil((log K/S_0 - N log d)/(log u - log d)) \
                  q & := (e^(r Delta t) - d)/(u-d) \
                rho & := e^(-r Delta t) u q \
    op("B")(a; N,p) & := sum_(j=a)^N binom(N, j) p^j (1-p)^(N-j)
  $
]<thm-arbol-call>
Nótese que
$
  op("B")(a; N,p) = 1 - F_(op("B")(N,p)) (a-1).
$

#proof[
  Primero observamos que si $K >= u^N S_0$ entonces $S_T <= K$. De modo que $(S_T - K)_+ = 0$ y $C = 0$.
  Si $K < u^N S_0$ entonces escribimos
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
  Ahora descomponemos la parte positiva tomando
  $
    a & := min {x in [0, N) inter ZZ : u^x d^(N-x) S_0 - K >= 0}
  $
  de forma que tenemos
  $
    (u^j d^(n-j) S_0 - K)_+
    = cases(
      u^j d^(n-j) S_0 - K & "si " j >= a,
      0 & "si " j < a.
    )
  $
  Tomando logaritmos deducimos que en la definición de $a$
  $
    x log x + (N-x) log d >= log K / S_0.
  $
  Despejando obtenemos el valor de $a$ del enunciado.
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

Sea $phi.alt(s) = (s - K)_+$. En cada momento puedo:
- Ejercer la opción, y ganar $phi.alt(S_t)$
- Mantener la opción una unidad de tiempo, que siguiendo la teoría de opciones europeas, tiene valor $e^(-r Delta t) EE^QQ [V_(t + Delta t)|S_t]$

Dado que estas son las dos cosas que podemos hacer deducimos que
$
  V_T & = phi.alt(S_T), \
  V_t & = max lr(
          (
            underbrace(phi.alt(S_t), "valor de ejercer \n la opción"), quad
            underbrace(e^(-r Delta t) EE^QQ [ V_(t + Delta t) | S_t], "valor de mantener la opción \n una unidad de tiempo")
          ) quad "para" t = 0, dots.c, T-Delta t
          , size: #50%
        ).
$<eq-arbol-americana>
Dado que $V_t$ depende sólo del valor "futuro", podemos resolver este sistema a tiempo $t = T - Delta t, T - 2 Delta t, dots.c$

Hasta ahora hemos demostrado la valoración de derivados a tiempo $T$, pero no de frontera libre. Se propone el siguiente ejercicio.
#exercise[
  Como el mercado ${S,B}$ en el modelo @eq-arbol es completo, cualquier _derivado_ (en nuestro sentido riguroso) se puede escribir como un cartera autofinanciada
  + Comprobar que @eq-arbol-americana es un _derivado_ en nuestro sentido riguroso.

  + Suponer que la opción americana tiene valor $H_t$, y comprobar que si $V_t != H_t$ entonces el mercado ${S,B,H}$ admite arbitraje.
    Sugerencia: considerar el máximo de los $t$ donde no coinciden y distinguir casos.
]

Para calcular estos valores a lo largo del árbol, vamos a considerar
$
  V_j^((i)) := lr([V_(t) "en" t = j Delta t "si el activo" S_(t) = S_0 u^(i) d^(j - i)], size: #150%)
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

=== Intuición y definición riguosa

Para la definición de una $QQ$ nos ha bastado con condicionar $|tilde(S_t)$ por que cada periodo depende sólo del anterior, a esto se lo conoce como Markovianidad. Para valor una cartera, debemos saber el precio actual de la cartera, lo que requiere conocer los pesos. La forma más sencilla de hacer esto es utilizar "toda la información en $[0,t]$". La forma de hacer es con la filtración temporal.

Definimos la siguiente sucesión de $sigma$-álgebras:
- $cal(F)_0 := {emptyset, Omega}$
- Definimos $A_1 = {bold(omega) in Omega: omega_(Delta t) =1 }$ y $A_0 = {bold(omega) in Omega: omega_(Delta t) =0 }$ y definimos
  $
    cal(F)_(Delta t) := {emptyset, A_1, A_0, Omega}.
  $
- Definimos los conjuntso $A_(00) = {bold(omega) in Omega: omega_(Delta_t) = 0, omega_(2 Delta t) =0 }$, etc... y definimos $cal(F)_(2 Delta t)$ la $sigma$-álgebra generada
  $
    cal(F)_(2 Delta t) := sigma(A_(11), A_(10), A_(01), A_(00)).
  $
- Repetimos este proceso hasta que $F_T = 2^Omega$.

#exercise[Construir $cal(F)_(2 Delta t)$.]

#definition[
  Una filtración es una sucesión no-decreciente de $sigma$-algebras
  $
    cal(F)_0 subset cal(F)_(Delta t) subset dots.c subset cal(F)_T.
  $
]

#exercise[Comprobar que lo construído anteriormente es una filtración]

=== Filtraciones y procesos

Una vez tenemos la construcción rigurosa, señalamos que la condición de "utilizar la información conocida" puede escribirse en términos de las filtraciones.
#exercise[
  Sea $H_t : Omega -> RR$.
  Comprobar que son equivalentes
  + $H_t = bold(F)_t (S_0, dots.c, S_(t))$
  // - $bold(theta)_t^(-1) ({a}) = A' times {0,1}^(N-n+1)$
  + $H_t$ es medible respecto $cal(F)_t$
  Cuando $H_t$ es un proceso estocástico y esto ocurre para todo $t$, se dice que es *proceso adaptado a $cal(F)_(t)$*
]

#remark[
  Los productos son procesos $H_t$ adaptados $cal(F)_t$,
  mientras que las carteras (@eq-arbol-carteraadaptada) son procesos $bold(theta)_t$ adaptados a $cal(F)_(t-Delta t)$.
]

Para facilitar la analogía al caso continuo, también podemos escribir
$
  cal(F)_t = {S_s^(-1) (B) : B in cal(B), s in [0,t] inter NN_(Delta t)}
$
donde $NN_(Delta t) := {0, Delta t, 2 Delta t, dots.c}$.
// Si $A in cal(F)_t$ entonces
// $
//   A = A' times {0,1}^(N-n) " con " A' in {0,1}^n.
// $
Esta es la llamada $sigma$-álgebra generada por $(S_s | s in [0,t]inter NN_(Delta t))$, que a veces se denota $cal(U)(S_s | s in [0,t] inter NN_(Delta t))$. Nótese que también podemos escribir
$
  cal(F)_t = cal(U)(R_s | s in [0,t] inter NN_(Delta t))
$

=== Esperanza condicionada a la filtración y valoración a tiempo $t$

Podemos pensar en
$
  EE[Phi(S_0, dots.c, S_T) | cal(F)_t]
$
como la esperanza fijados $S_0, dots.c, S_t$ y promediando entre los valores de $S_(t+Delta t), dots.c, S_T$. De manera rigurosa definimos

#definition[Esperanza condicionada a una $sigma$-álgebra][
  Dada $cal(G)$ una $sigma$-álgebra, definimos $EE[X | cal(G)] := Y$ la única variable aleatoria tal que:
  - $EE[ |Y| ] < oo$
  - $Y$ es medible respecto de $cal(G)$
  - Para todo evento $A in cal(G)$ se tiene $EE[Y bold(1)_A] = EE[X bold(1)_A]$, donde $bold(1)_A$ es la función indicatriz de $A$.
]

De manera que podemos escribir la condición de martingala como
$
  tilde(S)_s = EE^QQ [tilde(S_t) | tilde(S)_s] = EE^QQ [tilde(S_t) | cal(F)_s].
$
Razonando como lo hicimos a tiempo $t = 0$ para tiempos generales, tenemos que
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
