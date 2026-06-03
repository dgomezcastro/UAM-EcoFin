// LTeX: language=es

#import "../header/template.typ": *

= Instrumentos y mercados financieros

== Activos subyacentes

=== Acciones

=== Activos de renta fija: Bonos


In finance, a bond is a type of security under which the issuer (debtor) owes the holder (creditor) a debt, and is obliged – depending on the terms – to provide cash flow to the creditor; which usually consists of repaying the principal (the amount borrowed) of the bond at the maturity date, as well as interest (called the coupon) over a specified amount of time.

An investor who has a regular bond receives income from coupon payments, which are made semi-annually or annually. The investor also receives the principal or face value of the investment when the bond matures.

A zero-coupon bond (also discount bond or deep discount bond) is a bond in which the face value is repaid at the time of maturity.[1] Unlike regular bonds, it does not make periodic interest payments or have so-called coupons, hence the term zero-coupon bond. When the bond reaches maturity, its investor receives its par (or face) value. Examples of zero-coupon bonds include US Treasury bills, US savings bonds, long-term zero-coupon bonds,[1] and any type of coupon bond that has been stripped of its coupons.

En España: Letras y bonos del Tesoro.
#figure(
  // placement: bottom,
  image("02-figuras/bono-tesoro.jpg", width: 70%),
  caption: [Bono del Tesoro Español. Fuente: #link("https://bidkit.ams3.digitaloceanspaces.com/34/imgBig/50/2623.jpg")[link]],
)

=== _Yield curve_

#link("https://en.wikipedia.org/wiki/Yield_curve")

=== Curva cupón cero

En su formato más sencillo #link("https://es.wikipedia.org/wiki/Curva_cup%C3%B3n_cero")

#link("https://www.bluegamma.io/post/what-is-a-zero-coupon-curve-and-where-to-download")

#link("https://es.wikipedia.org/wiki/Curva_cup%C3%B3n_cero"):
A partir de diferentes curvas observables en el mercado (mercado monetario, swaps de tipos de interés, etc.) se construye la curva cupón cero. Se utilizan diferentes metodologías para su cálculo y, en especial, estimación para puntos no observables de la curva de tipos, como por ejemplo, el "bootstrapping"#footnote[#link("https://www.bis.org/publ/bppdf/bispap25.pdf")]

== Carteras de inversión

===

=== _Value-at-risk_ VaR

Cuando se usa un valor en riesgo se expresa:
#quote(block: true)[
  Estoy $X$% seguro de que no habrá una pérdida de más de $V$\$ en los próximos $N$ días.
]
Si supiésemos la distribución de los retornos, $R$
$
  N"-day" op("VaR") "at" X% := V "tal que" PP lr(("Ganancia/pérdida en" N "días" <= V), size: #200%) = 1 - X/100.
$
Por motivos que veremos abajo, la ganancia/pérdida escala se suele modelizar con distribuciones normales independientes como veremos más adelante
y por tanto se suele aproximar
$
  N"-day" op("VaR") "at" X% approx sqrt(N) lr((1"-day" op("VaR") "at" X%), size: #200%)
$

El modelo más habitual es el modelo histórico, que se leer en #cite(<Hull2015>, supplement: "Chapter 22").

==== Ejemplo para un sólo activo

Estudiemos el VaR de una cartera de 10M\$ en acciones de Microsoft, al 99% de confianza a lo largo de $N=10$ días.

Normalmente se asume que el cambio esperado de valor de una variable de mercado en un periodo corto es cero. Esto no es estrictamente cierto, pero es una hipótesis razonable porque es un cambio pequeño comparado con la volatilidad.
Si pensamos que
$
  "Ganancia/pérdida" N "días" approx dot Normal (N mu, N sigma^2).
$
entonces estamos diciendo que $mu << sigma$ y que podemos suponer $mu = 0$.
Por ejemplo, podríamos pensar que Microsoft tiene una volatilidad diaria del $sigma = 2%$ (que es una volatilidad anual del 32%).
Supongamos además que tiene un retornos del 20% anual.
En el periodo de 1 día estamos diciendo que tiene un retorno del $0.2/252 = 0.08%$ mientas que la volatilidad es del 2%.

En el periodo de 10 días, la volatilidad es de $sqrt(10) dot 2% approx 6.3%$.

Sobre esta cartera esto significa que $sigma = 200.000$\$.
Busquemos el VaR de 1 día al 99% de confianza
$
  0.01 = PP(10 dot Normal(0, sigma^2) < V) = PP(Normal(0, 1) < V / sigma)).
$
con lo que, utilizan las tablas de la Normal (o algún método más novedoso) $V/(sigma) = 2.326$ y deducimos que el VaR de un día resulta $V = 465,300$\$.
El VaR de diez días corresponde el VaR de 10 días es $sqrt(10) dot 465,300 = 1,471,300$\$.

==== Ejemplo para dos activos

Para reproducir el argumento anterior en un cartera con dos activos debemos tener en cuenta que
$
  sigma_(X+Y) = sqrt(sigma_X^2 + sigma_Y^2 + 2 rho sigma_X sigma_Y).
$
donde $rho$ es la correlación entre ambos productos.

== Derivados

=== Contrato a plazo (_forward contract_)

$F_0 = S_0 e^(r T)$

Ver @Hull2015 para una explicación del arbitraje.

=== _Futures_

Si $r$ es constante entonces el precio de un _future_ es el mismo que el de un _forward_. Aunque la justificación es complicada. @Hull2015

Cuando hay dividendo a ritmo $q$ entonces la fórmula resulta
$
  F_0 = S_0 e^((r-q) T).
$

=== Permuta financiera o _swaps_

Una permuta financiera o swap es un contrato por el cual dos partes se comprometen a intercambiar una serie de cantidades de dinero en fechas futuras.

#cite(<Hull2015>, supplement: "Chapter 7")

==== IRS (interest rate swap o «permuta financiera de tipo de interés»)

Entre ellas destaca la Permutas de tipos de interés de tipo variable frente a tipo fijo.

==== La crisis de 2008: _credit default swaps_

=== Opciones europeas

=== Opciones americanas

=== Otros derivados
