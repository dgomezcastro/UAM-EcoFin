// LTeX: language=es

#import "../header/template.typ": *

= Modelo en tiempo continuo: Black-Scholes

== Paseos aleatorios y movimiento Browniano

Consideremos el proceso aleatorio dado por la siguiente distribución de Bernouilli
$
  Z := cases(
    +1 & "con probabilidad " 1/2,
    -1 & "con probabilidad " 1/2.
  )
$
Consideremos $Z_1, Z_2, ...$ independientes e idénticamente distribuidas.
Llamamos _paseo aleatorio_ a la variable aleatoria
$
  X_0 := 0, quad X_n := sum_(i=1)^n Z_i
$
Dado que $Z$ es esencialmente un lanzamiento de moneda, podemos contar el número de veces que ha salido $+1$. Si tenemos $k$ movimientos a la derecha y $n-k$ movimientos a la izquierda estaremos en la posición $k - (n-k) = 2k - n$. De modo que
$
  PP(X_n = 2k - n) = PP("B"(n,1/2) = k)= binom(n, k) (1/2)^n.
$
#exercise[Representar la función de masa del paseo aleatorio para diferentes valores de $n$. Comparar con una distribución normal. ¿Qué relación encuentras? Lee la entrada de Wikipedia sobre el tablero de Galton, y en particular mira el video:

  https://en.wikipedia.org/wiki/Galton_board

]
// TODO Añadir alguna figura. Hacer un pluto notebook.

Recordamos el teorema central del límite
#theorem[Teorema central del límite][
  Sean $Z_1, Z_2, ...$ una sucesión de proceso aleatorios independientes e idénticamente distribuidos como una variable aleatoria $Z$,
  de media $mu_Z$ y varianza $sigma_Z^2$.
  Entonces, las medias muestrales dadas por
  $
    overline(Z)_n := 1/n sum_(k=1)^n Z_k
  $
  convergence en distribución a una normal
  $
    overline(Z)_n ->^d N(mu_Z, sigma_Z^2).
  $
]
Equivalentemente, este teorema pueda rescribirse como
$
  (overline(Z)_n - mu_Z)/(sigma_Z) ->^d N(0,1).
$
Escalando, también deducimos el comportamiento de las sumas
$
  (n overline(Z)_n - n mu_Z)/(sigma_Z sqrt(n)) ->^d Y ~ N(0,1) " cuando " n -> oo.
$
Nótese que
$
  mu_Z := EE[Z] = 0, quad sigma_Z := sqrt(V(Z)) = EE[(Z-0)^2]^(1/2) = 1.
$
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
Hemos hecho la construcción de manera formal. Para una construcción analítica con funciones de Haar ver @Evans2013.
Es interesante también la presentación hecha en @bjorkArbitrageTheoryContinuous2019, donde se justifica con más detalle el paso el límite $Delta t -> 0$.

La construcción que hemos hecho se puede justificar, y de hecho es un resultado famoso.
#theorem[Teorema de Donsker][
  El límite @eq-limite-paseo-aleatorio se da  en sentido de distribuciones, y $W_t$ es un movimiento Browniano.
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

#figure(
  image("../figures/random-walk-limit.pdf"),
  caption: [Algunas muestras de paseos aleatorios re-escalados $h X_(h^2 t)$. Nótese que $W_t^((n))$ son constantes a trozos.],
)

== Cálculo de Itô

En tiempo descrito vamos a escribir incrementos de la forma
$
  X_(t + Delta t) - X_t = a(t, X_t) Delta t + b(t, X_t) (W_(t + Delta t) - W_t).
$
Cuando $Delta t -> 0$ formalmente querríamos escribir algo de la forma
$
  d X_t = a(t, X_t) dif t + b(t, X_t) dif W_t.
$<eq-SDE>
La forma de justificar esta "fórmula" es en términos de formas diferenciales. De manera rigurosa, diremos que se cumple @eq-SDE si se cumple para todo $t$ la fórmula integral
$
  X_t = X_0 + integral_0^t a(s, X_s) dif s + integral_0^t b(s, X_s) dif W_s.
$<eq-SDE-integral>
Ahora debemos construir estas integrales estocásticas.


Como $X_t : Omega -> RR$ y $(Omega, cal(F), PP)$ es un espacio de probabilidad, daremos por conocida la integral de Lebesgue (o Bochner), que nos permite controlar la primera integral. Llamaremos
$
  LL^2(0,T) = { (X_t)_t | integral_0^T X_t^2 dif t < oo}
$
Las funciones de este espacio pueden ser aproximar en $LL^2$ por funciones constantes a trozos.

Construimos ahora la integral respecto del movimiento Browniano.
Recordamos que si $X_t$ es constante a trozos $(t_i, t_(i+1))$ donde $t_N = T$, entonces sabemos que
$
  integral_0^T a(s, X_t) dif s & = sum_(i=0)^N a(s, X_(t_i)) (t_(i+1) - t_i).
$
Definimos la integral
$
  integral_0^T a(s, X_t) dif W_t & := sum_(i=0)^N a(s, X_(t_i)) (W_(t_(i+1)) - W_(t_i)).
$
Y esta construcción puede extenderse por continuidad a todo $L^2(0,T)$


#exercise[][
  Sean $a,b in RR$ y $G, H in LL^2(0,T)$. Demostrar que

  + $integral_0^T (a G_t + b H_t ) dif W_t = a integral_0^T G_t dif W_t + b integral_0^T H_t dif W_t$
  + $EE[integral_0^T G_t dif W_t] = 0$
  + $EE [(integral_0^T G_t d W_t)^2] = EE[integral_0^T G_t^2 dif s]$
  + $EE[integral_0^T G_t dif W_t integral_0^T H_t dif W_t] = EE[integral_0^T G_t H_t dif W_t]$
  + $integral_0^T W_t dif W_t = W_T^2 / 2 - T/2$
]

Con un poco de trabajo, de manera similar se prueba
#theorem[Regla de cadena de Itô][
  Sea $X_t$ solución de la ecuación
  $
    d X_t = a(t, X_t) dif t + b(t, X_t) dif W_t
  $
  y sea $u$ dos veces diferenciable en $x$ y $1$ vez en $t$ con derivada continua. Sea $Y_t = u(t, X_t)$ entonces
  $
    d Y_t = (a (partial u)/(partial t) + b^2 /2 (partial^2 u)/(partial x^2) ) dif t + b (partial u)/(partial x) dif W_t
  $
]<thm-Itochainrule>

La demostración de este resultado y todos los detalles de esta construcción pueden verse in @Evans2013.

== Límite de árboles binomiales

=== Condiciones suficientes de convergencia
Vamos a empezar esta sección con el siguiente resultado
$$
#theorem(breakable: true)[Límite de árboles binomiales cuando $Delta t -> 0$][
  Sea $S^((Delta t))$ el proceso construido por el árbol binomial @eq-arbol, añadiendo la dependencia en tiempo como $(Delta t)$.
  Definimos la interpolación constante a trozos
  $
    S_t^((Delta t)) := S_(n Delta t)^((Delta t)) quad "si " n Delta t <= t < (n+1) Delta t.
  $
  Supongamos que se puede descomponer
  $
    log u^((Delta t)) = nu^((Delta t)) + sigma^((Delta t)),
    quad log d^((Delta t)) = nu^((Delta t)) - sigma^((Delta t))
  $
  de tal modo que existen los límite
  $
    nu := lim_(Delta t -> 0) nu^((Delta t)) / (Delta t) quad "y" quad sigma := lim_(Delta t -> 0) sigma^((Delta t)) / sqrt(Delta t).
  $<eq-BlackScholes-condicionud2>
  Entonces se tiene que
  $
    S_t^((Delta t)) ->^d S_t = S_0 exp((mu - sigma^2/2)t + sigma W_t)
  $
  donde $W_t$ es un movimiento Browniano y $mu$ depende sólo de $nu$ y $p$. Es decir, $S_t$ es la solución de
  $
    dif S_t = mu S_t dif t + sigma S_t dif W_t
  $<eq-BlackScholes-SDE>
]
#proof[
  Para $t in (Delta t) NN$ tenemos que
  $
    S_(t+Delta t)^((Delta t)) = S_t^((Delta t)) R_t^((Delta t)) " donde " R_t^((Delta t)) :=
    cases(
      u & "con probabilidad " p,
      d & "con probabilidad " 1-p
    )
  $
  Aplicando las propiedades del logaritmo deducimos que
  $
    log S^((Delta t))_(n Delta t) = ln S_0 + sum_(k=1)^(n) log R^((Delta t))_(n Delta t)
  $
  Descomponemos $log R^((Delta t))_(n Delta t)$ en una parte determinista y un paseo aleatorio $xi_k$ sesgado
  $
    log R^((Delta t))_(n Delta t) = nu^((Delta t)) + sigma^((Delta t)) xi_k .
  $<eq-BlackScholes-condicionud1>
  Así
  $
    log S^((Delta t))_(n Delta t) & = log S_0 + n nu^((Delta t)) + sigma^((Delta t)) sum_(k=1)^(n)xi_k \
                                  & ->^d log S_0 + underbrace((nu + 2p-1), kappa) t + sigma W_t,
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
]

=== Los modelos Cox-Ross-Rubinstein y Jarrow-Rudd

Hay dos aproximaciones clásicas para obtener @eq-BlackScholes-condicionud1 y @eq-BlackScholes-condicionud2. La más sencilla consiste es $nu_(Delta t) = 0$ y $sigma_(Delta t) = sigma sqrt(Delta t)$, que corresponde con
$
  u = e^(sigma sqrt(Delta t)) " y " d := e^(-sigma sqrt(Delta t)).
$
Otra posibilidad, propuesta por Jarrow-Rudd es tomar
$
  u = e^((r - sigma^2/2) t + sigma sqrt(Delta t))
  quad "y" quad
  d = e^((r - sigma^2/2) t - sigma sqrt(Delta t))
$
Cuando $p = 1/2$ esta fórmula lleva a la muy útil representación @eq-BlackScholes-St-Q, en la que no entraremos por ahora.

== Verificando la log-normalidad

Hasta ahora, nuestros modelos han sido puramente teóricos. Pero ahora podemos verificar si @eq-BlackScholes-St-P tiene sentido comprobando si @eq-BlackScholes-incremento-log se cumple.
Vamos a tomar datos _reales_ de mercado para el valor de un activo, y a mirar si los incrementos del log-precio parecen normalmente distribuidos.
Para esto, vamos a usar `julia`.
Los activos que mejor representan este compartimento son los índices, como el S&P500 (`SPX` que include las 500 "principales" empresas americanas) o el Euro Stoxx 50 (`SX5E`).
Estudiar con el siguiente código de `julia`, cuyo resultado es @fig-BlackScholes-lognormality-of-returns:
// #code-block(
#show: codly-init.with()
#codly(languages: codly-languages)
#raw(read("../scripts/lognormality.jl"), lang: "julia", block: true)//,
// )

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

Otra opción para deducir esta fórmula consiste en
que permite escribir el precio de una opción _call_ europea a partir de una Ecuación en Derivadas Parciales (EDP).

#exercise(breakable: true)[
  Consideremos una cartera autofinanciada de la forma $C_t = theta_t^((1)) S_t + theta_t^((2)) B_t$. Supongamos además que su precio viene descrito como
  $
    C_t = u(t, S_t).
  $

  + Para al límite en @eq:arbol-autofinanciacion para deducir que la condición de auto-financiación se escribe
    $
      dif C_t = theta_t^((1)) dif S_t + theta_t^((2)) dif B_t.
    $

  + Usar la regla de la cadena de Itô para deducir que si $u$ es la solución de la famosa ecuación de Black-Scholes
    $
      cases(
        display((partial u)/(partial t) + 1/2 sigma^2 s^2 (partial u)/(partial s^2) + r s (partial u)/(partial s)- r u = 0)
        & "for " t in [0,T] "and" s > 0,
        u(T,s) = e^(-r T)(s - K)_+
      )
    $<eq-BlackScholes-PDE>

  + Buscar una cambio de variable que permita escribir $u$ en función de la solución de la ecuación de calor con dato inicial.

  + Deducir @eq-BlackScholes-call.
]



== Volatilidad implícita

Es habitual denotar a @eq-BlackScholes-call mediante un nombre distinguido
$
  "Call"_"BS" (sigma,S_0, K,r,T) := S_0 op("N")(d_1) - K e^(-r T) op("N") (d_2).
$
En esta función $S_0, K, r, T$ son conocidos a la hora de hacer el contrato, pero $sigma$ es desconocido.
#theorem[][
  Dados $S_0, K, r, T$ fijos, la función
  $
    (0,oo) & ->  && (0,oo) \
     sigma & |-> && "Call"_"BS" (sigma,S_0, K,r,T)
  $
  es estrictamente decreciente y, además,
  $ partial / (partial sigma) "Call"_"BS" (sigma,S_0, K,r,T) = S_0 sqrt(T) op("N")'(d_1) < 0. $
  Esta valor es habitualmente conocido como _vega_ (que no es una letra griega) y se denota $nu$ (nu sí es una letra griega). En algunos contextos se utiliza el nombre kappa: $kappa$.
]

Además, es fácil ver que
$
  d_1 -> cases(
    oo & "si" sigma -> oo,
    oo & "si" sigma -> 0
  )
  #h(2cm)
  d_2 -> cases(
    -oo & "si" sigma -> oo,
    oo & "si" sigma -> 0
  )
$
y, por tanto, se tiene
$
  lim_(sigma -> oo) & "Call"_"BS" (sigma,S_0, K,r,T) = S_0 \
   lim_(sigma -> 0) & "Call"_"BS" (sigma,S_0, K,r,T) = S_0 - K e^(-r T).
$<eq-BlackScholes-call-limits-sigma>


A su inversa, cuando existe, se la conoce como _volatilidad implícita_
$
  sigma_"BS" (C_0, S_0, K, r, T)
  := cases(
    "si" C_0 in (S_0 - K e^(-r T), S_0),
    "único valor" sigma in (0,oo) "tal que",
    "Call"_"BS" (sigma,S_0, K,r,T) =C_0.
  )
$<eq-BlackScholes-impliedvol>
Este problema no tiene una solución analítica sencilla, y se han desarrollado diferentes métodos para resolverlo:
- Método de la bisección
- Método de Newton
- Let's be Rational

Es posible acceder a datos de mercado de estos valores, por ejemplo a través de Yahoo Finance. Tiene una API implementada en muchos lenguajes.
#raw(read("../scripts/yfinance-option.jl"), lang: "julia", block: true)
Aunque los datos de mayor "calidad" se obtienen de proveedores de pago.

Nótese en particular que estos datos hablan de bid y ask. Volvemos sobre la idea de que los market-makers no venden y comprar las opciones al mismo precio, si no que se quedan una diferencia como beneficio.

Si tomamos, para un vencimiento fijo $T$, los diferentes precios reales de opciones call, encontraremos una curva, que no es muy descriptiva.
En la práctica, lo que se estudia es la curva de volatilidades implícitas. Ver @fig-BlackScholes-smiles.
#figure(
  placement: auto,
  image("../figures/gatheral-smiles.pdf"),
  caption: [Tomado de @gatheralVolatilitySurfacePractitioners2006],
)<fig-BlackScholes-smiles>

Del mismo modo, si tomamos precios reales para diferentes $K$ y $T$, obtenemos una superficie de precios, que no es muy descriptiva.
En la práctica, lo que se estudia es la superficie de volatilidad implícita, que normalmente se llama simplemente _superficie de volatilidad_. Ver @fig-BlackScholes-surface.

#figure(
  placement: auto,
  image("../figures/gatheral-surface.pdf"),
  caption: [Tomado de @gatheralVolatilitySurfacePractitioners2006],
)<fig-BlackScholes-surface>

== Medida libre de riesgo

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

Para construir $QQ$ el procedimiento consiste en observar que dado @eq-BlackScholes-St-P y @eq-BlackScholes-St-Q entonces
$
  W_t^QQ = (mu - r)/sigma t + W_t .
$
La existencia de $QQ$ con esta propiedad se sigue del teorema de Girsanov, que no estudiaremos en este curso.

De nuevo, en medida libre de riesgo $QQ$, la ecuación sólo depende de $sigma$ y $r$.
Al igual que para árboles, de la versión continua de @eq-arbol-martingala se deduce que
$
  C_0 = e^(-r T) EE^QQ [(S_T - K)_+].
$<eq-BlackScholes-call-expectvalue>

#remark[
  + Usando cálculo de Itô, @eq-BlackScholes-St-Q es equivalente a que
    $
      d tilde(S)_t = sigma tilde(S)_t dif W_t^QQ.
    $<eq-BlackScholes-SDEriskfree>
    Si $X_t$ es solución de @eq-SDE donde $W_t$ es un movimiento Browniano respecto a $PP$, entonces $X$ es una martingala respecto a $PP$ si y sólo si $a(t, X_t) = 0$.

  + Es interesante observar que @eq-BlackScholes-PDE y @eq-BlackScholes-SDEriskfree no involucran a $mu$, al igual que pasaba en el caso de árboles.
]



== Sistemas de activos. Correlación.

Al igual que en el mercado discreto en tiempo, podemos tener sistemas de activos en cuyo caso el límite satisface ecuaciones
$
  d S_t^((i)) = mu^((i)) S_t^((i)) dif t + sigma^((i)) S_t^((i)) dif W_t^((i))
$
cuya solución es
$
  log S_t^((i)) = (mu^((i)) - (sigma^((i)))^2/2) t + sigma^((i)) W_t^((i))
$
Dado que los activos son "independientes", estamos ante un movimiento Browniano multi-dimensional $W_t = (W_t^((i)))$. Podemos pensar en medir
$
  corr(W_(t + h)^((i)) - W_t^((i)), W_(t+h)^((j)) - W_t^((j)))
  &= (EE[(W_(t + h)^((i)) - W_t^((i)))( W_(t+h)^((j)) - W_t^((j)))])/(EE[W_(t+h)^((i)) - W_t^((i))] EE[W_(t+h)^((j)) - W_t^((j))])
  \
  &= (EE[(W_(t + h)^((i)) - W_t^((i)))( W_(t+h)^((j)) - W_t^((j)))])/(h).
$
Si seguimos una construcción como la de Cox-Ross-Rubinstein, llegaremos a que esta cantidad es constante en $h$, y la podemos llamar $rho^((i j))$.
Para un Browniano multi-dimensional asumimos que este valor es constante, y en términos de cálculo de Itô se denota
$
  d W_t^((i)) dot.c d W_t^((j)) := rho_(i j).
$
Dado que
$
  log S_(t + h)^((i)) - log S_t^((i)) = (mu^((i)) - (sigma^((i)))^2/2) h + sigma^((i)) (W_(t+h)^((i)) - W_t^((i)))
$
La primera parte nos da el valor esperado. Así, deducimos que
$
  cov(log S_(t + h)^((i)) - log S_t^((i)), log S_(t + h)^((j)) - log S_t^((j))) = sigma^((i)) sigma^((j)) rho^((i j)) h.
$
Dado que $sigma^((i)) sqrt(h) = var(log S_(t +h)^((i)) - log S_(t)^((i)))$ obtenemos
$
  rho^((i j)) = corr(log S_(t + h)^((i)) - log S_t^((i)), log S_(t + h)^((j)) - log S_t^((j))) .
$<eq-correlation-from-market-data>

Podemos deducir estos valores de datos de mercado.

Esta cantidad nos permite construir "carteras equilibridas" donde el riesgo de que un active baje se compensa con el que tiene negativamente correlado suba. Existe toda una cartera de optimización de carteras, en la que no entraremos.
