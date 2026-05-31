// LTeX: language=es
#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

= Modelo de varios pasos temporales: árbol binomial

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  s[label="s_0"]
  s1[label="s_1"]
  s11[label="s_11"]
  s12[label="s_12"]
  s2[label="s_2"]
  s21[label="s_21"]
  s22[label="s_22"]
  s -> s1[label="p_1"]
  s -> s2[label="1-p_1"]
  s1 -> s11[label="p_12"]
  s1 -> s12 [label="1-p_12"]
  s2 -> s21 [label="p_22"]
  s2 -> s22[label="1-p_22"]
  }
  ```),
  caption: "Árbol binomial con dos pasos de tiempo",
)
Según las hipótesis se habla de modelo de Cox-Ross-Rubinstein o Jarrow-Rudd.
Por simplicidad, vamos a suponer que
$
  PP(S_(t + Delta t) = u S_t) = p " y " PP(S_(t+Delta t)= d S_t) = 1-p.
$
== Medida libre de riesgo
Construímos el precio descontado
$
  tilde(S_t) = e^(-r t) S_t
$
#definition[Valor esperado condicionado][
  Sean $X, Y$ variables aleatorias discretas

  Se define la esperanza condicionada a un evento con $PP(Y=y) > 0$ como el escalar
  $
    EE^PP [X | Y=y] := sum_(x:PP(X=x) > 0) x PP(X = x|Y=y) = sum_(x:PP(X=x) > 0) x (PP(X = x inter Y=y))/(PP(Y=y)).
  $
  Se dice define la esperanza condicionada como
  $
    EE^PP [X|Y] := & "la única variable aleatoria" Z "tal que" \
                   & PP lr((Z = EE^PP [X | Y = y]), size: #200%) = PP(Y = y) \
                   & "para todo" y "tal que" PP(Y=y) >0.
  $

  De manera similar se puede definir $EE^PP [X|cal(F)]$ donde $cal(F)$ es una $sigma$-álgebra.
]
Diremos que $QQ << PP$ si $PP(A) = 0$ implica $QQ(A) = 0$.

#definition[Medida de riesgo neutro para un árbol binomial][
  Medida de probabilidad $QQ << PP$ tal que
  $
    EE^QQ [tilde(S)_(t+Delta t) | tilde(S_t) ] = tilde(S_t).
  $<eq-arbol-medida-libre-de-riesgo>
  Puede escribirse @eq-arbol-medida-libre-de-riesgo equivalentemente como
  $
    EE^QQ lr([tilde(S)_(t+Delta t) | tilde(S_t) = s], size: #200%) = s "para todo" s "tal que" QQ(tilde(S_t) = s) > 0
  $
]
Por inducción, es claro que
#proposition[
  Si $t > s$ entonces
  $
    EE^QQ [tilde(S_t) | tilde(S)_s] = tilde(S)_s.
  $ <eq-arbol-martingala>
]



Aplicamos la definición para calcular $q$ la probabilidad de subida
$
  s = EE^QQ [tilde(S)_(t + Delta t) | tilde(S)_t = s] = q e^(-r Delta t) u s + (1-q)e^(-r Delta t) d s
$
y deducimos
$
  q = (e^(r Delta t) - d)/(u - d)
$
#proposition[
  Existe una medida de riego neutro para el árbol binomial si y sólo si
  $
    0 <= d <= e^(-r Delta t) <= u.
  $
]

== Valoración de carteras
Ahora nuestra cartera descontada toma la forma
$
  V_t := x_t S_t + y_t B_t
$<eq-arbol-cartera>
Añadimos la condición de que sea autofinanciada, es decir que a tiempo $t+Delta t$ liquidamos la posición y usamos todo el dinero para una nueva cartera
$
  x_t S_(t+Delta t) + y_t B_(t + Delta t) = x_(t+ Delta t) S_(t+Delta t) + y_(t + Delta t) B_(t + Delta t)
$
Denotando $Delta x_t := x_(t+Delta t) - x_t$ esto significa que
$
  (Delta x_t) S_(t+Delta t) + (Delta y_t) B_(t+Delta t) = 0.
$<eq:arbol-autofinanciacion>

#theorem[][
  En un árbol binomial, una cartera @eq-arbol-cartera autofinanciada, es decir tal que @eq:arbol-autofinanciacion satisface
  $
    EE^QQ [tilde(V)_t] = V_0
  $
]
#proof[
  Descontando el precio obtenemos
  $
    (Delta x_t) tilde(S)_(t+Delta t) + (Delta y_t) tilde(B)_(t+Delta t) = 0.
  $
  Así, desarrollamos la resta
  $
    Delta tilde(V_t)
    &= (Delta x_t) tilde(S)_(t+Delta t) + (Delta y_t) tilde(B)_(t+Delta t) + x_t Delta tilde(S)_t + y_t Delta tilde(B)_t \
    &=x_t Delta tilde(S)_t + y_t Delta tilde(B)_t.
  $
  Aplicando @eq-arbol-martingala deducimos que $EE^QQ [tilde(V)_(t + Delta t)] = E^QQ [tilde(V)_t]$. Inductivamente deducimos el resultado.
]
También cabe señalar que
$
  Delta V_t = x_t Delta S_t + y_t Delta B_t.
$

== Valor de una call europea

De manera similar al caso de un paso, las opciones _call europeas_ se puede reproducir por una cartera, y deducimos que
#theorem[
  El precio de no arbitraje de una opción _call_ europea viene dado por
  $
    C_0 & = e^(-r T) EE^QQ [(S_T - K)_+] \
        & = S_0 op("B")(a; N, rho) - K e^(-r T) op("B")(a; N, q) .
  $<eq-arbol-call>
  donde $T = N Delta t$ y
  $
      a & := min {x in [0, N) inter ZZ : u^x d^(N-x) S_0 >= 0} \
      q & := (e^(-r Delta t) - d)/(u-d) \
    rho & := e^(-r Delta t) u q.
  $
]

En la fórmula anterior,
$
  op("B")(a; N,p) = sum_(j=a)^N binom(N, j) p^j (1-p)^(N-j)
$
es la probabilidad de extraer $a$ positivos en $N$ lanzamientos de una Bernouilli $p$.

#proof[
  Siguiendo la idea del modelo de un paso, es fácil construir una cartera $V_t$ que reproduce la opción _call_ por inducción. De modo que $V_t = C_t$ en cada tiempo, y por tanto también $tilde(C)_t = tilde(V)_t$. Concluímos que
  $
    C_0 = V_0 = EE^QQ [tilde(V)_T] = EE^QQ[tilde(C)_T] = EE^QQ[e^(-r T) C_T].
  $
  Así, tenemos que
  $
    EE^QQ [C_T] & = EE^QQ [(S_T - K)_+] = sum_(j=0)^N u^j d^(N-j) QQ(S_T = u^j d^(N-j)).
  $
  Observando el árbol es fácil basta contar caminos para ver que
  $
    QQ(S_T = u^j d^(N-j)) = binom(N, j) q^j (1-q)^(N-j).
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

=== Filtraciones y valor de una call en tiempo $t$

Para la definición de una $QQ$ nos ha bastado con condicionar $|tilde(S_t)$ por Markovianidad. Para valor una cartera, debemos saber el precio actual de la cartera, lo que requiere conocer los pesos. La forma más sencilla de hacer esto es utilizar "toda la información en $[0,t]$". La forma de hacer es con la filtración temporal.

Dada una variable aleatoria $X: Omega -> RR$ se define la $sigma$-álgebra generada por $X$ como
$
  cal(U)(X) := {X^(-1) (B) : B in cal(B)}
$
donde $cal(B)$ es la $sigma$-álgebra de Borel.
Es la menor $sigma$-álgebra respecto de la cual $X$ es medible.

Llamamos _filtración_ a tiempo $t$ a
$
  cal(F)_t := cal(U)(S_s | s in [0,s]).
$
De manera que podemos escribir
$
  tilde(S)_s = EE^QQ [tilde(S_t) | tilde(S)_s] = EE^QQ [tilde(S_t) | cal(F)_s].
$
De este modo, razonando como lo hicimos a tiempo $t = 0$ para tiempos generales, tenemos que
$
  C_t = e^(-r(T-t)) EE^QQ [(S_T - K)_+ | cal(F)_t].
$<eq-arbol-call-tiempot>


// Desde el punto de vista teórico, una filtración es
// #definition[Filtración][
//   En un espacio de probabilidad $(Omega, cal(U), PP)$,
//   una familia $cal(F)_t$ de $sigma$-álgebras de $cal(U)$ se llama filtración (o _no-anticipada respecto de $S$_) si
//   - $t>=s>=0$ implica $cal(F)(t) supset cal(F)(s)$
//   -
// ]
