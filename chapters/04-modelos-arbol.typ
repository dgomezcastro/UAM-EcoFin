// LTeX: language=es
#import "../header/template.typ": *

= Modelo de varios pasos temporales: árbol binomial

Consideremos ahora un árbol, donde consideramos los eventos que ocurren en $t_k = k Delta t$ que podemos denotar como @fig-arbol
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  s[label="S_0"]
  s1[label="s_1^((0))"]
  s11[label="s_2^((00))"]
  s12[label="s_2^((01))"]
  s2[label="s_1^((1))"]
  s21[label="s_2^((10))"]
  s22[label="s_2^((11))"]
  s -> s1[label="p_1"]
  s -> s2[label="1-p_1"]
  s1 -> s11[label="p_12"]
  s1 -> s12 [label="1-p_12"]
  s2 -> s21 [label="p_22"]
  s2 -> s22[label="1-p_22"]
  }
  ```),
  caption: "Árbol binomial con dos pasos de tiempo",
)<fig-arbol>
Según las hipótesis se habla de modelo de Cox-Ross-Rubinstein o Jarrow-Rudd.
Por simplicidad, vamos a suponer que
$
  PP(S_(t + Delta t) = u S_t) = p " y " PP(S_(t+Delta t)= d S_t) = 1-p \
  PP(B_t = e^(r t) B_0) = 1
$<eq-arbol>
De modo que $s_t^((a)) = S_0 u^(k) d^(t-k)$ si la cadena $a$ contiene $k$ ceros y $t-k$ unos.

== Carteras y arbitraje

#definition[Cartera de inversión][
  Si tenemos algunos activos de cuyo valores denotamos $S_t^((i))$ una cartera consiste en mantener cantidades $theta^((i))_t in RR$ de ellos.
  Cuando $theta_t^((i)) > 0$ decimos que estamos en una posición larga, y si $theta_t^((i)) < 0$ decimos que estamos en una posición corta.
  Una cartera es un proceso estocástico $theta_t = (theta_t^(1), dots.c, theta_t^(N))$
  adaptado a la información conocida, es decir tal que
  $
    theta_t = F_t (S_0, S_(Delta t), S_(2 Delta t), dots.c, S_(t-1)).
  $<eq-arbol-carteraadaptada>
  El valor de la cartera se expresa
  $
    V_t := sum_(i=1)^N theta_t^((i)) S_t^((i)) = theta_t dot S_t.
  $<eq-arbol-valorcartera>
]
Añadimos la condición de que sea autofinanciada, es decir que a tiempo $t+Delta t$ podríamos la posición y usamos todo el dinero para una nueva cartera
$
  underbrace(theta_t dot S_(t+Delta t), "valor de la cartera" \ "construida a tiempo" t "en" t + Delta t) = underbrace(theta_(t+ Delta t) S_(t+Delta t), "valor de la nueva cartera" \ "en" t + Delta t)
$
Denotando
$
  Delta S_t := S_(t + Delta t) - S_t,
$
$Delta theta_t := theta_(t+Delta t) - theta_t$, etc...  esto significa que
$
  S_(t+Delta t) dot Delta theta_t = 0.
$<eq:arbol-autofinanciacion2>
Desarrollando
$
  Delta V_t & = (Delta theta_t) dot S_(t+Delta t) + theta_t dot Delta S_t
$
obtenemos la formulación equivalente
#definition[Cartera autofinanciada][
  Diremos que una cartera $theta_t$ es autofinanciada si satisface
  $
    Delta V_t = theta_t dot Delta S_t .
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


#theorem[Valoración por replicación][
  Si $V_t$ y $H_t$ son dos productos tales que $H_T = V_T$, entonces $H_t = V_t$ para todo $t in [0,T]$.
]
#proof[
  Veamos que si $V_t != H_t$ para algún $t$ entonces el mercado admite una oportunidad de arbitraje.
  Sea $t_0$ el mínimo tiempo donde no coinciden.
  En el mercado de productos $(V_t, H_t)$ podemos construir el producto
  construímos una nueva cartera formada por $hat(x)_t^((1))$ unidades de la cartera replicante, y $hat(x)_t^((2))$ unidades del derivado donde
  $
    hat(x)_t^((1)) & := cases(0 & "si" t<t_0, -sign(V_(t_0) - H_(t_0))H_(t_0) & "si" t>=t_0+Delta t) \
    hat(x)_t^((2)) & := cases(0 & "si" t<t_0, sign(V_(t_0) - H_(t_0))V_(t_0) & "si" t>=t_0+Delta t)
  $
  donde $sign(0) = 0$.
  Esta es una cartera admisible, porque mira sólo al pasado.
  Entonces el valor de esta cartera resulta
  $
    hat(V)_t := cases(
      0 & "si" t in [0,t_0],
      sign(V_(t_0) - H_(t_0))(V_(t_0) H_t - H_(t_0) V_t) & "si" t in [t_0,T]
    )
  $
  Así, la cartera es autofinanciada, $V_0 = 0$, $V_T = |V_(t_0) - H_(t_0)| H_T >= 0$. Como $V_(t_0) != H_(t_0)$ entonces $V_T > 0$ con probabilidad positiva.
]

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

Por inducción, es claro que
#proposition[
  Si $t > s$ entonces
  $
    EE^QQ [tilde(S_t) | tilde(S)_s] = tilde(S)_s.
  $ <eq-arbol-martingala>
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
    sum_(i=1)^N (Delta theta_t^((i))) tilde(S)_(t+Delta t) = 0.
  $
  Así, desarrollamos la resta
  $
    Delta tilde(V_t) & = sum_(i=1)^N theta_t^((i)) Delta tilde(S)_t^((i)).
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
  Siguiendo la idea del modelo de un paso, es fácil construir una cartera autofinanciada $V_t$ tal que $V_T = H_T$.
  De modo que $V_t = H_t$ en cada tiempo (o es posible construir una cartera con arbitraje), y por tanto también $tilde(H)_t = tilde(V)_t$. Concluímos que
  $
    H_0 = V_0 = EE^QQ [tilde(V)_T] = EE^QQ [tilde(H)_T] = EE^QQ [e^(-r T) C_T].
  $
  Esto concluye la demostración.
]

== Valor de una call europea

De manera similar al caso de un paso, las opciones _call europeas_ se puede reproducir por una cartera, y deducimos que
#theorem[
  El precio de no arbitraje de una opción _call_ europea viene dado por
  $
    C_0 & = S_0 op("B")(a; N, rho) - K e^(-r T) op("B")(a; N, q) .
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
  Así, tenemos que
  $
    EE^QQ [C_T] & = EE^QQ [(S_T - K)_+] = sum_(j=0)^N (u^j d^(N-j) S_0 - K)_+ QQ(S_T = u^j d^(N-j)).
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
La condición de que la cartera esté adaptada a la información conocida (ver @eq-arbol-carteraadaptada) se expresa en estos términos como que $theta_t$ es un *proceso adaptado a $cal(F)_t$*.

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
