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
$
Es decir que $S_t$ es log-normal. No sólo eso, si no que para cualquier $Delta t$
$
  log S_(t + Delta t) - log S_t = kappa Delta t + sigma (W_(t+Delta t) - W_t).
$<eq-BlackScholes-incremento-log>
Despejando
$
  S_t = S_0 exp(kappa t + sigma W_t)
$
<eq-BlackScholes-St-P>
La convención es escribir $kappa = mu - sigma^2 / 2$ por motivos que veremos a continuación.

== Verificando la log-normalidad

Hasta ahora, nuestros modelos han sido puramente teóricos. Pero ahora podemos verificar si @eq-BlackScholes-St-P tiene sentido comprobando si @eq-BlackScholes-incremento-log se cumple.
Vamos a tomar datos _reales_ de mercado para el valor de un activo, y a mirar si los incrementos del log-precio parecen normalmente distribuidos.
Para esto, vamos a usar `julia`.
Los activos que mejor representan este compartimento son los índices, como el S&P500 (`SPX` que include las 500 "principales" empresas americanas) o el Euro Stoxx 50 (`SX5E`)

#figure(
  image("05-figuras/lognormality.pdf", width: 75%),
  caption: "Los log-incrementos del S&P500 ajustados a una normal",
)

This can be generated with the julia code:
// #code-block(
#show: codly-init.with()
#codly(languages: codly-languages)
#raw(read("05-figuras/lognormality.jl"), lang: "julia", block: true),
// )

== Un comentario sobre el cálculo de Itô
Cálculo de Itô permite construir una teoría de ecuaciones diferenciales ordinarias de la forma
$
  d X_t = a(t,X_t) dif t + b(t, X_t) dif W_t .
$
En este marco, $S_t$ es la solución de la ecuación diferencial
$
  d S_t = mu S_t dif t + sigma S_t d W_t .
$
En este contexto, $W_t$ es un movimiento Browniano con la medida ambiente $PP$ que es el límite natural de la medida ambiente discreta.
Esta teoría permite escribir una versión continua de carteras reproductores, que permite escribir el precio de una opción _call_ europea a partir de una Ecuación en Derivadas Parciales (EDP), donde el precio de la opción es
$
  C_t = u(t, S_t)
$
donde $u$ es la solución de la famosa ecuación de Black-Scholes
$
  cases(
    display((partial u)/(partial t) + 1/2 sigma^2 s^2 (partial u)/(partial s^2) + r s (partial u)/(partial s)- r u = 0)
    & "for " t in [0,T] "and" s > 0,
    u(T,s) = e^(-r T)(s - K)_+
  )
$<eq-BlackScholes-PDE>

=== Medida libre de riesgo

Siguiendo la idea del caso discreto, busquemos escribir para algún valor $nu$
$
  S_t = S_0 exp(nu t + sigma W^QQ_t)
$
con una nueva medida $QQ$.
Si intentamos buscar una versión continua de @eq-arbol-martingala, utilizando la fórmula de la esperanza de una log-normal
$
  S_0 & = EE^QQ [tilde(S)_t] = EE^QQ [ S_0 exp(-r t + nu t + sigma W^QQ_t) ] \
      & = S_0 exp(-r t + nu t + sigma^2/2 t)
$
De modo que despejamos $nu$ y tenemos precisamente que
$
  S_t = S_0 exp((r-sigma^2/2)t + sigma W_t^QQ).
$<eq-BlackScholes-St-Q>
De nuevo, en medida libre de riesgo $QQ$, la ecuación sólo depende de $sigma$ y $r$.
Al igual que para árboles, de la versión continua de @eq-arbol-martingala se deduce que
$
  C_0 = e^(-r T) EE^QQ [(S_T - K)_+].
$<eq-BlackScholes-call-expectvalue>

De hecho, para construir $QQ$ el procedimiento consiste en observar que dado @eq-BlackScholes-St-P y @eq-BlackScholes-St-Q entonces
$
  W_t^QQ = (r/sigma-sigma/2)t + W_t .
$
La existencia de $QQ$ con esta propiedad se sigue del teorema de Girsanov, que no estudiaremos en este curso.

Usando cálculo de Itô, estas condiciones son equivalentes a
$
  d tilde(S)_t = sigma tilde(S)_t dif W_t^QQ.
$<eq-BlackScholes-SDEriskfree>

Es interesante observar que @eq-BlackScholes-PDE y @eq-BlackScholes-SDEriskfree no involucran a $mu$.

== Precio de una opción europea

Podemos calcular el precio de una call europea utilizando @eq-BlackScholes-St-Q -- @eq-BlackScholes-call-expectvalue de forma equivalente a como demostramos @eq-arbol-call a partir de binomiales.
Sin embargo, en estas notas deduciremos el precio de una _call_ europea como límite de @eq-arbol-call siguiendo @hsiaBINOMIALOPTIONPRICING1983.
//#link("https://gregorygundersen.com/blog/2023/06/03/hsia-proof-black-scholes/")
#theorem[Precio de una _call_ europea en el modelo de Black-Scholes][
  Se tiene que
  $
    C_0 = S_0 op("N")(d_1) - K e^(-r T) op("N") (d_2)
  $<eq-BlackScholes-call>
  donde $"N"$ es la función de distribución de una $N(0,1)$
  $
    op("N")(x) := 1 / sqrt(2 pi) integral_(-oo)^x e^(-z^2/2) dif z
  $
  y
  $
    d_1 & := ( log(S_0/K) + ( r + sigma^2/2 ) T)/ (sigma sqrt(T)) \
    d_2 & := ( log(S_0/K) + ( r - sigma^2/2 ) T)/ (sigma sqrt(T)) = d_1 - sigma sqrt(T)
  $
]
Nótese que @eq-BlackScholes-call no involucra a $mu$.
