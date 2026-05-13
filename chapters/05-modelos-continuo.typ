// LTeX: language=es

#import "../header/template.typ": *

= Modelos en tiempo continuo

Recordamos
#theorem[Teorema central del límite][
  Sean $X_1, X_2, ...$ una sucesión de proceso aleatorios independientes e idénticamente distribuidos como una variable aleatoria $X$,
  de media $mu_X$ y varianza $sigma_X^2$
  Entonces, las media muestrales
  $
    overline(X)_n := 1/n sum_(k=1)^n X_k
  $
  convergence en distribución a una normal
  $
    overline(X)_n ->^d N(mu_X, sigma_X^2).
  $
]
Equivalentemente, este teorema pueda rescribirse como
$
  (overline(X)_n - mu_X)/(sigma_X) ->^d N(0,1).
$
Escalando, también deducimos el comportamiento de las sumas
$
  (n overline(X)_n - n mu_Z)/(sigma_Z sqrt(n)) ->^d Y ~ N(0,1) " cuando " n -> oo.
$

== Paseos aleatorios y movimiento Browniano

Consideremos el proceso aleatorio dado por la siguiente distribución de Bernouilli
$
  Z := cases(
    +1 & "con probabilidad " 1/2,
    -1 & "con probabilidad " 1/2.
  )
$
Lo llamaremos un _paso aleatorio_.
Nótese que
$
  mu_Z := EE[Z] = 0, quad sigma_Z := sqrt(V(Z)) = EE[(Z-0)^2]^(1/2) = 1.
$

Consideremos $Z_1, Z_2, ...$ independientes e idénticamente distribuidas.
Llamamos paseo aleatorio a la variable aleatoria
$
  X_0 := 0, quad X_n := sum_(i=1)^n Z_i
$
A este proceso se lo conoce como _paseo aleatorio_.
El teorema central del límite asegura que
$
  X_n approx n mu_Z + sigma_Z sqrt(n) Y = sqrt(n) Y
$
Ahora vamos a construir un proceso límite en tiempo. Consideremos un paso de tiempo $Delta t$ y sea el proceso en tiempo continuo y constante a trozos
$
  W_(t)^((n)) := X_(floor(n t))/(sqrt(n))
$
// Deducimos de los anterior que
// $
//   W_(n Delta t)^((n)) approx lambda_(n) sqrt(n) N(0,1).
// $
de modo que
$
  W_t^((n)) approx sqrt(t) N(0,1) ~ N(0, t)
$
Utilizando el teorema central del límite, existe el siguiente límite en sentido de distribuciones
$
  W_t := lim_(Delta t -> 0) W^((n))_(t) .
$<eq-limite-paseo-aleatorio>
Si $t = k / n$ y $s = ell/n$ entonces
$
  W_(t)^((n)) - W_(s)^((n)) = sqrt(n) sum_(ell = ell)^(k-1) Z_k approx N(0, t - s)
$
Además, como los $Z_k$ son independientes, si $s < t <= k/n < ell/n <= r < u$ entonces
$
  W_t^((n)) - W_s^((n))
  " y "
  W_r^((n)) - W_u^((n))
$
son independientes


#definition[Movimiento Browniano][
  Proceso continuo en tiempo con las propiedades
  - $W_0 = 0$
  - Si $t > s >= 0$ tenemos
  $
    W_t - W_s ~ N(0,t-s)
  $ <eq-browniano-incrementos-normales>
  - Si $0 < s < t < u < r$ entonces
  $
    W_t - W_s " y " W_r - W_u " son independientes".
  $<eq-browniano-incrementos-independientes>
]
Hemos hecho la construcción de manera formal. Para una demostración rigurosa ver
#block(fill: red)[Libro de Evans]

La construcción que hemos hecho se puede justificar, y de hecho es un resultado famoso.
#theorem[Teorema de Donsker][
  El límite @eq-limite-paseo-aleatorio existe en sentido de distribuciones, y $W_t$ es un movimiento Browniano.
]

Si consideramos un paseo aleatorio sesgado
$
  PP(xi=+1) = p " y " PP(xi=-1) = 1-p
$
entonces
$
  mu_xi := EE[xi] = 2p - 1.
$
Aplicando un razonamiento similar al anterior
$
  1 / sqrt(n)sum_(k=1)^( floor(t n) ) xi_k ->^d mu_xi t + W_t
$
donde $W_t$ es un movimiento Browniano.

== Modelo de Black-Scholes. Límite de Cox-Ross-Rubinstein
En el modelo de árbol binomial escribimos
$
  S_(t+Delta t) = S_t R_t " donde " R_t :=
  cases(
    u & "con probabilidad " p,
    d & "con probabilidad " 1-p
  )
$
Llamemos
$
  X_n := log S_(n Delta t)
  " y "
  Z_(n) := log R_(n Delta t).
$
Aplicando las propiedades de logaritmo, tenemos
$X_(n+1) - X_n = Z_n$ o,
equivalentemente,
$
  X_n = X_0 + sum_(k=1)^(n) Z_k
$
Descomponemos $Z$ en una parte determinista y un paseo aleatorio
$
  log u = tilde(nu) + tilde(sigma),
  quad log d = tilde(nu) - tilde(sigma),
  quad Z_k = tilde(nu) + tilde(sigma) xi_k .
$
Así
$
  X_n & = X_0 + n tilde(nu) + tilde(sigma) sum_(k=1)^(n)xi_k \
      & ->^d X_0 + (nu + 2p-1) t + sigma W_t,
$
si escalamos $tilde(nu) / (Delta t) -> nu$ y $tilde(sigma) / sqrt(Delta t) -> sigma$.
Esto quiere decir que
$
  log S_t = log S_0 + kappa t + sigma W_t
$<eq-BlackScholes-logSt>
La convención es escribir $kappa = mu - sigma^2 / 2$ por motivos que veremos a continuación.
