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
  W_(t)^((Delta t)) := lambda_(Delta t) X_(floor(t/(Delta t)))
$
Así cuando $t = n Delta t$ tenemos $W_t^((Delta t)) = lambda_(Delta t) X_n$.
// Deducimos de los anterior que
// $
//   W_(n Delta t)^((Delta t)) approx lambda_(Delta t) sqrt(n) N(0,1).
// $
Si queremos que este proceso tenga un buen límite buscamos que todas las $lambda_n sqrt(n)$ sea función de $t$, tomamos
$
  lambda_(Delta t) := sqrt(Delta t).
$
De este modo deducimos que si $t = n Delta t$
$
  W_t^((Delta t)) approx sqrt(t) N(0,1) ~ N(0, t)
$
Como podemos escribir $Delta t = t / n$ llamamos
$
  W_t := lim_(Delta t -> 0) W^((Delta t))_(ceil(t/(Delta t))Delta t) .
$
Escribimos
$
  W_(k Delta t)^((Delta t)) - W_(n Delta t)^((Delta t)) = sqrt(Delta t) sum_(ell = n)^(k-1) Z_k approx N(0, Delta t ( k - n ))
$
Además, como los $Z_k$ son independientes, si $k < n < m < p$ entonces
$
  W_(k Delta t)^((Delta t)) - W_(n Delta t)^((Delta t))
  " y "
  W_(p Delta t)^((Delta t)) - W_(m Delta t)^((Delta t))
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

== Límite del modelo de Cox-Ross-Rubinstein
En el modelo de árbol binomial escribimos
$
  S_(t+Delta t) = S_t R_t " donde " R_t :=
  cases(
    log u & "con probabilidad " p,
    log d & "con probabilidad " 1-p
  )
$
Así, deducimos que $log(b/a) = log b - log a$ tenemos que
$
  log S_(t + Delta t) - log S_t = log R_t.
$
Llamemos $X_n = log S_(n Delta t) - log S_0$ e $Z_(n+1) = log R_(n Delta t)$
tenemos
$
  X_(n+1) - X_n = Z_n.
$
Equivalentemente
$
  X_0 = 0, quad X_n = sum_(k=1)^n Z_k
$
Para el paso al límite vamos a tomar
$
  log u := mu Delta t + sigma sqrt(Delta t) quad log d := mu Delta t - sigma sqrt(Delta t).
$

y sumando obtenemos
$
  X_(t + tau) - X_t = sum_(t<= s < t + tau \ s = k Delta t, k in ZZ ) Y_s ~
$
