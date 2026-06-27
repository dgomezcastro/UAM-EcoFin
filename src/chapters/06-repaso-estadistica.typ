// LTeX: language=es

#import "../header/template.typ": *

= Repaso de estadística y probabilidad

Un espacio de probabilidad es una terna $(Omega, cal(F), PP)$ donde $Omega$ es un conjunto, $cal(F) subset cal(P)(Omega)$ es una $sigma$-álgebra, cuyos elementos son los llamados _conjuntos medibles_, y $PP:cal(F) -> [0,1]$ es una medida de probabilidad.
Decimos que un conjunto $A$ es medible si $A in cal(F)$.

Una variable aleatoria $n$-dimensional es una función $X:Omega -> RR^n$ tal que $X^(-1)( B(0,R) )$ es medible para todo bola $B(0,R)$. Dada una variable aleatoria se denota para $A subset RR$
$
  PP(X in A) := PP(X^(-1)(A)).
$

== Distribución binomial

En un espacio de probabilidad $(Omega, cal(F), PP)$ se dice que una  $X$ se distribuye como una distribucional binomial de $N$ pasos y probabilidad $p$, y se denota $X ~^PP "Binomial"(n,p)$ si se tiene
$
  PP(X = k) = binom(n, k) p^k (1-p)^(n-k) "para todo" k in {0, dots.c, N}.
$
donde
$
  binom(n, k) = (n!)/(k!(n-k)!).
$

== La distribución normal

Decimos que una variable aleatoria $X$ tiene distribución normal respecto de una medida $PP$, y lo denotamos $X ~ "Normal"(mu, sigma^2)$ con $mu in RR$ y $sigma > 0$ si tiene por función de densidad
$
  f(x) = 1/(sqrt(2 pi sigma^2)) e^(- 1/2 ((x-mu)/sigma)^2 )
$
Es decir que
$
  PP(X <= a) = integral_(-oo)^(a) f(x) dif x.
$
Si se trabaja con varias medidas de probabilidad se utiliza la notación $~^PP$.
Si $Z ~ "Normal"(0,1)$ entonces
$
  mu + sigma Z ~ X.
$

Se tiene que
$
  EE[X] = mu quad var(X) = sigma^2.
$
Además tenemos que
$
  EE[X^2] = mu^2 + sigma^2, quad EE[X^3] = mu^3 + 3 mu sigma^2 , quad EE[X^4]=mu^4 + 6 mu^2 sigma^2 + 3 sigma^4.
$


== La distribución log-normal

Se tiene que $X$ es una distribución log-normal si $Y = log(X)$ es una distribución normal.
Equivalentemente $X = e^Y$. Se tiene que
$
  EE[X]
  //& =
  //EE[e^(mu + sigma Z)] = e^(mu) EE [e^(sigma Z)]
  = e^(mu + sigma^2/2 ).
$


