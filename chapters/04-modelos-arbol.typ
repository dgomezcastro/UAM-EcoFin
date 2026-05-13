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
  Desconentado el precio también
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
  El precio de no arbitraje de una opción europea viene dado por
  $
    C_0 = e^(-r T) EE^QQ [(S_T - K)_+].
  $
]
#proof[
  #box(fill: red)[Sólo si da tiempo]
]

