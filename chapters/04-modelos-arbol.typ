// LTeX: language=es
#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

= Modelos en de varios pasos temporales

== Modelo de árboles binomiales

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

=== Probabilidades de transición constantes
Por simplicidad, vamos a suponer que
$
  PP(S_(t + Delta t) = u S_t) = p " y " PP(S_(t+Delta t)= d S_t) = 1-p.
$
Construímos el precio descontado
$
  tilde(S_t) = e^(-r t) S_t
$
#definition[Medida de riesgo neutro para un árbol binomial][
  Medida de probabilidad $QQ$ tal que
  $
    EE^QQ [tilde(S)_(t+Delta t) | tilde(S_t) =s] = s " para todo " s " tal que " PP(tilde(S_t) = s) > 0
  $<eq-arbol-medida-libre-de-riesgo>
]
A veces esto se denota simplemente
$
  EE^QQ [tilde(S)_(t+Delta t) | tilde(S)_t] = tilde(S_t)
$


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
    0 < d < e^(-r Delta t) < u.
  $
]
Nótese que bajo la medida de riesgo neutro, se tiene
#proposition[
  Si $t > s$ entonces
  $
    EE^QQ [tilde(S_t) | tilde(S)_s] = tilde(S)_s.
  $ <eq-arbol-martingala>
]
#proof[
  Por inducción.
]

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
  Siguiendo la idea del modelo de un paso, es fácil construir una cartera $V_t$ que reproduce la opción _call_. De modo que $V_t = C_t$ en cada tiempo, y por tanto también $tilde(C)_t = tilde(V)_t$. Concluímos que
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

