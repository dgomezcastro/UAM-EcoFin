// LTeX: language=es

#import "../header/template.typ": *

= Nociones básicas de aritmética financiera

// Tipos de interés, capitalizaciones, préstamos, rentas.
// Rendimientos, tasa interna de rendimientos. Estructura temporal de tipos de interés, la curva cupón cero. Algunos
// cálculos actuariales.

== Tipos de interés y el bono cupón-cero

Un tipo de interés en una situación particular es la cantidad que el prestatario promete pagar al prestamista.
Esto incluye tipos hipotecarios, depositarios, y otros.
El tipo de interés aplicable depende del riesgo del crédito, es decir el riesgo de que el crédito no sea devuelto.

=== Intución

Esto funciona bien si pensamos por ejemplo, en una inversión hecha el 1 de enero 2025, y que devuelve el dinero el 1 de 2026.

En su presentación más sencilla, el tipo de interés $r$ (expresado en %), es el número tal que
$
  "dinero recibido \n el 1 de enero de 2026" = (1 + r) times "dinero invertido \n el 1 de enero de 2025."
$
Se habla del retorno
$
  "retorno" & := "dinero recibido" - "dinero invertido" \
            & = r times "dinero invertido"
$
Esto funciona bien si pensamos por ejemplo, en una inversión hecha el 1 de enero 2025, y que devuelve el dinero el 1 de 2026.

Si tomamos todo el dinero que sale de una inversión, y lo volvemos a invertir por el mismo plazo, al mismo tiempo entonces obtendremos
$
  "dinero recibido \n el 1 de enero de 2027" = (1 + r)^2 times "dinero invertido \n el 1 de enero de 2025".
$

#exercise[
  El 1 de enero de 2007, invirtió 1000€ en su libreta. El 1 de enero de 2008 el banco le informa que ha recibido 40€ de intereses a lo largo del año.
  - ¿Cuales son los intereses brutos asociados?
  - ¿Qué intereses recibirá a lo largo de 2008?
  - ¿Cuánto habría recibido de haber cerrado su cuenta el 1 de julio.
]

#exercise[Interés compuesto][
  Supongamos que si invertimos 1€ en el índice S&P500 obtenemos una rentabilidad del 7% anual en promedio. Si invertimos 500€ hoy ¿cuánto dinero tendremos en 5, 10, 15 años?
]<ex-interes-compuesto>

=== Fórmulas de conversión

Si tenemos una inversión que promete un retorno de $r$ a $T = 1/N$ años con $N in NN$, podemos utilizar la fórmula del interés compuesto para deducir cual es el tipo anual
$
  1 + r_("anual") = (1 + r)^N.
$
Habitualmente se habla de Tipo de Interés Nominal cuando $r = "TIN" / N$.

Esta es la idea detrás del TAE, que es un asunto más profundo del que hablaremos más adelante.

=== Midiendo tipos de interés. Interés compuesto

Anunciar el tipo de interés como un 10% anual parece claro y nada ambiguo. Sin embargo, depende de cómo se mida. El habitual permitir dividir el tipo de composición.
Si el tipo de interés con $r = 10%$ se mide con composición anual (_annual compunding_) entonces $100€$ crecen como
$
  100€ times 1.1 = 110€.
$
Sin embargo, si hablamos de composición bi-anual (_semi-annual compounding_) entonces aplicamos $5%$ cada 6 meses. Tras $6$ meses tendremos $100€ times 1.05 = 110.25€$ y acabado el año
$
  100€ times 1.05 times 1.05€ = 110.25€
$
En general si lo hacemos en $n$ periodos tendremos
$
  100€ times (1 + 0.1/n)^n.
$
Vemos más ejemplos en @table-interes-compuesto.
// #table(
//   columns: (1fr, auto),
//   table.header([*Composición*], [*Valor de $100€$ a final de año*]),
//   Anual, hola,
// )

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: (left, right),
    table.header([*Frecuencia \ de composición*], [*Valor de $100€$ \ a final de año*]),
    [Anual ($n=1$)], [110.00€],
    [Semi-anual ($n=2$)], [110.25€],
    [Cuatrimestral ($n=4$)], [110.38€],
    [Mensual ($n=12$)], [110.47€],
    [Semanal ($n=52$)], [110.51€],
    [Diario ($n=365$)], [110.52€],
  ),
  caption: "Interés compuesto",
)<table-interes-compuesto>

#exercise[
  Ordenar de menor a mayor los siguientes tipos de interés:
  - 6% anual;
  - 0,5% mensual;
  - 30% por 5 años;
  - 10% el primer año y 4% los dos siguientes.
]


=== Tipo de interés continuo
Jacob Bernouilli descubrió el número $e$, llamado número de Euler o de Napier, calculando límites en la fórmula de interés compuesto
$
  e := lim_(x -> oo) (1 + 1/x)^x.
$
Calculando el límite en la fórmula de interés compuesto obtenemos
$
  lim_(n -> oo) (1 + (r t)/n)^(n) & = lim_(n -> oo) [(1 + (r t)/n)^(n/(r t))]^(r t)
                                    = [lim_(x -> oo) (1 + 1/x)^(x)]^(r t) \
                                  & = e^(r t)
$
Esta representación nos será de gran utilidad. Si intentamos calcular el tipo anual equivalente, entonces
$
  1 + r_"anual" = e^r.
$

#exercise[
  Responder a las siguientes preguntas:
  - Dado un tipo del 10% compuesto semianualmente, ¿Cuál es el tipo continuo equivalente?
  - Un prestamista pretende conseguir el 8% continuo y cobra trimestralmente. ¿Cuál es el tipo anual para composición trimestral equivalente?
]

=== ¿Quién fija los tipos de interés?

Hay diferentes productos con tipos de interés públicos.
Los bonos estatales tiene unos cupones fijados a través de los cuales se obtiene beneficio. Este producto nos permite valorar "la evolución del valor del dinero" si no queremos que exista arbitraje. Nos habla del valor del dinero en los momentos de vencimiento de estos cupones.

También existen tipos de interés a "corto plazo", con el que los bancos se prestan dinero entre sí.
Esto también estable "restricciones".
Los dos ejemplo más relevantes en nuestro contexto son:

- LIBOR es el acrónimo del _London Interbank Offered Rate_. Es un tipo de préstamo a corto plazo entre bancos, sin garantías. Se calculan a diario cada día laborable en 10 monedas y 15 periodos (desde 1 día hasta 1 año).

- El euríbor (del inglés euribor), acrónimo de _Euro Interbank Offered Rate_ es un índice de referencia publicado diariamente que indica el tipo de interés promedio al que un gran número de bancos europeos dicen concederse préstamos a corto plazo entre ellos para prestárselo a terceros —particulares y empresas—.

#figure(
  image("02-figuras/euribor.png"),
  caption: [Euribor a 12 meses. https://www.euribor-rates.eu/en/euribor-charts/],
)


=== Bono de cupón cero

La hipótesis de no-arbitraje hace que un producto consistente en "invertir 1€ a tiempo $t$ con vencimiento a tiempo $T$" puede dar un único beneficio a tiempo $T$.
Vamos a utilizar este producto como referencia para valorar el resto de productos, bajo la hipótesis de no arbitraje.
El producto más habitual de esta naturaleza

Lo expresión más habitual del contrato no es escribir así el producto un contrato por el que una entidad se compromete a pagarnos una cantidad llamada «principal» denotado $K$ en la fecha de vencimiento $T$.
Asumiremos que quién vende el contrato (típicamente un estado o una entidad grande) es «de fiar» y pagará con total garantía, de modo que este producto no tiene riesgo.
Este producto es un producto llamado «bono»
Además, este producto es un tipo muy sencillo de «bono», que hace pagos intermedios, los llamados «cupones». Por eso se habla de «cupón cero».

#definition[Bono de cupón cero bajo la hipótesis de no-arbitraje][
  Un bono de cupón cero con fecha de vencimiento $T$ y principal $K$ es un contrato que garantiza a su poseedor $K$ unidades monetarias (por ejemplo \$) pagada en la fecha $T$.
  Denotaremos
  $
    p(t, T) := "precio a tiempo "t" de un bono de principal "K = 1" y maduración" T.
  $
  Asumimos que:
  - Se puede comprar o vender sin coste
  - A vencimiento instantáneo el precio es el principal, es decir
  $
    p(t,t) = 1 "para todo "t.
  $
]
Así, el valor a tiempo $t$ de un bono de cupón cero y principal $K$ es $K p(t,T)$.

Una de las tareas difíciles de la Matemática Financiera es aproximar este valor. Nótese que su existencia depende fuertemente de la hipótesis de no-arbitraje (que podría no cumplirse).

Hay otra forma muy habitual de expresar este valor, que es la siguiente

#definition[Rendimiento (o _yield_) del cupón cero con composición continua a tiempo $t$ con vencimiento $T$][
  Valor $R(t,T)$ tal que $R(t,T) = e^(-y(T -t))$, es decir
  $
    R(t, T) := -(log p(t,T))/(T-t).
  $<eq-zerocoupon-yield>
  A la curva $T |-> R(t,T)$ se la llama curva de rendimiento de cupón cero.
  Por comodidad denotaremos $R(T) := R(0,T).$
]
También se utilizan otras terminologías como tipo (_rate_) o índice (_index_).
La traducción de vencimiento en inglés es _maturity_.

#proposition[Tipo _forward_. Estructura temporal de los tipos de interés][
  Bajo la hipótesis de no arbitraje, el valor a tiempo $t$ de la inversión de $1$\$ a tiempo $T_1 > t$ y vencimiento $T_2 > T_1$
  es
  $
    p(t, T_1) / p(t, T_2)
  $
  Este el llamado tipo _forward_.
]
#proof[
  Para entender el precio de un bono cupón cero a diferentes tiempo podemos pensar en la siguiente estrategia. Sea $t < T_1 < T_2$:
  - A tiempo $t$ vendemos un bono con vencimiento en $T_1$ (es decir el compromiso de devolver 1\$ a tiempo $T_1$).
    Su valor es $p(t, T_1)$\$.
  - A tiempo $t$ usamos ese dinero para comprar $p(t,T_1) / p(t, T_2)$ bonos con vencimiento $T_2$. No hemos invertido nada.
  - A tiempo $T_1$ debemos pagar 1\$, que es la inversión que hacemos.
  - A tiempo $T_2$ recibimos $p(t,T_1) / p(t, T_2)$\$.
  La inversión de 1\$ a tiempo $T_1$ ha producido $p(t,T_1) / p(t, T_2)$ \$ a tiempo $T_2$. Esto está garantizado.
]

Podemos escribirlos de diferentes maneras:

- El tipo simple hacia adelante (_simple forward rate_ o tipo LIBOR _forward_), es la solución de la ecuación
  $
    1 + (T-S) L = p(t,S)/p(t,T)
  $
  De modo que
  $
    L(t; T_1, T_2) := - (p(t, T_2) - p(t, T_1)) / ((T_2 - T_1) p(t; T_2).)
  $<eq-LIBOR>

- El _simple spot rate for $[S,T]$_ o _LIBOR spot rate_ se define como
  $
    L(T_1, T_2) := - (p(T_1, T_2) - 1)/((T_2-T_1) p(T_1, T_2))
  $
#remark[
  En realidad, el tipo LIBOR entre $T_1$ y $T_2$ (denotado $L(T_1, T_2)$) es un valor que decide el organismo correspondiente a tiempo $T_1$, y este «fija una condición» sobre el rendimiento cupón cero (que es un ente "a posteriori"), si creemos en la ausencia de arbitraje.
  Más abajo en @ex-calculo-zerocouponyield construiremos $y(t;T)$ en varios tiempos a partir de bonos de cupón fijo. Podríamos al cálculo otros productos, como tipos LIBOR entre fechas, o precios de otros derivados.
]

// - El *_continuously compounded spot rate_* en el periodo $[T_1,T_2]$ contratado en $t$ viene dado por
//   $
//     e^(R (T-S)) = (p(t,S))/(p(t,T)).
//   $
//   es decir tal que
//   $
//     R(t; T_1, T_2) := - (log p(t, T_2) - log p (t, T_1)) / ( T_2 - T_1 )
//   $
// - El _continuously compounded spot rate_ del periodo $[T_1, T_2]$ viene dado por
//   $
//     R(T_1, T_2) := - (log p(T_1, T_2)) / (T_2 - T_1).
//   $
//   Nótese que coincide con el rendimiento del cupón cero en ese periodo.

- Se llama _instantenous forward rate rate with maturity $T$ contracted at $t$_ a
  $
    f(t, T) := - (partial log p (t,T)) / (partial T)
  $
- _instanteneous short rate_ viene dado por
  $
    r(t) := f(t,t).
  $

El bono de composición continua con valor inicial $B_0 = 1$ (a tiempo $t = 0$) viene dado por
$
  B_t = exp(integral_0^t r(s) dif s).
$
En todos nuestros ejercicios de valoración de opciones trabajaremos con $r(t)$ constante, por simplicidad.

Se tiene la relación
$
  p(t, T_2) = p(t,T_1) exp(- integral_(T_1)^(T_2) f(t,u) dif u).
$

== Préstamos y rentas

#example(breakable: true)[Hipoteca con tipo fijo y amortización francesa][
  En una hipoteca el tipo de interés se suele expresar en TIN anual.
  A esto hay que añadirle una comisión de apertura (por ejemplo el 1.5% del principal), así como otras posibles comisiones por cancelación anticipada, etc...

  La premisa de esta amortización es que la cuota mensual, $c$, permanece fija si el interés nominal no cambia.
  De manera que hemos de deducir $c$.
  El interés en el mes $n$-ésimo, $i_n$, es siempre la proporcionales al principal pendiente, $p_n$, es decir $i_n = r p_n$, donde $r$ es el tipo de interés mensual.
  Vamos a suponer que la amortización y pago de intereses se hace mensualmente.
  En la práctica se aplica la convención de que el tipo mensual es
  $
    r = "TIN" / 12.
  $
  La amortización $a_n$ varía con el tiempo de manera que $c = a_n + i_n$ sea constante. Calculamos la actualización del principal
  $
    p_(n+1) = p_n - a_n = p_n - (c - i_n) = (1 + r) p_n - c .
  $
  Esta es una ecuación de recurrencia de primer orden, lineal, y no homogénea.
  Tomamos el punto fijo
  $p^* = (1 + r)p^* - c$
  (es decir $p^* = c/r$) y para $x_n = p_n - p^*$ deducimos la ecuación
  $x_(n+1) = (1 + r)x_n$
  de modo que, por inducción, $x_n = (1 + r)^n x_0$.
  // Así $p_n = p^* + (1 + r)^n (p_0 - p^*).$
  Dado que buscamos que $p_N = 0$, si queremos que amortizar la hipoteca en $N$ años,  despejamos
  $
    c = (p_0 r)/(1-(1+r)^(-N)).
  $
]

*Comentario: Hipotecas variables*. Un tipo habitual de hipotecas tiene tipo variable o es mixta (unos primeros años con tipo fijo, y luego tipo variable).
Es habitual que el tipo variable se exprese en función como
$
  "Euribor" + "Diferencial".
$
El diferencial se pacta con el banco en la hipoteca, y el euribor es anunciado
En este caso, $r$ va cambiando. Es habitual que se revise cada 6 meses utiliza como $"TIN"_"anual"$ el correspondiente #link("https://www.euribor-rates.eu/es/tipos-euribor-actualmente/4/euribor-valor-12-meses/")["Euribor a 12 meses"].
El capital amortizado cada mes no cambia, pero se pagan los intereses que correspondan.

*Otros tipos de amortización:* Existen hipotecas con otros tipos de amortización como el alemán, pero no son muy relevantes en nuestro contexto.

== _Value-at-risk_ VaR

Cuando se usa un valor en riesgo se expresa:
#quote(block: true)[
  Estoy $X$% seguro de que no habrá una pérdida de más de $v$\$ en los próximos $N$ días.
]
Si supiésemos la distribución de los retornos y esta fuese continua, $R$
$
  op("VaR") N"-días al" X% := v "tal que" PP lr(("ganancia en" N "días" <= v), size: #200%) = 1 - X/100.
$
Por motivos que veremos abajo, la ganancia/pérdida escala se suele modelizar con distribuciones normales independientes como veremos más adelante
y por tanto se suele aproximar
$
  op("VaR") N"-días al" X approx sqrt(N) dot lr((op("VaR") 1"-día al" X), size: #200%)
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
  0.01 = PP(10 dot Normal(0, sigma^2) < v) = PP(Normal(0, 1) < v / sigma).
$
con lo que, utilizan las tablas de la Normal (o algún método más novedoso) $v/(sigma) = 2.326$ y deducimos que el VaR de un día resulta $v = 465,300$\$.
El VaR de diez días corresponde el VaR de 10 días es $sqrt(10) dot 465,300 = 1,471,300$\$.

En resumen, supuesto un compartimento normal de media nula
$
  "VaR" N"-días al" X% = sqrt(N) dot sigma_(1 "día") dot "erf"(1-X/100)
$


==== Ejemplo para varios activos

Para reproducir el argumento anterior en un cartera con dos activos debemos tener en cuenta que
$
  sigma_(X+Y) = sqrt(sigma_X^2 + sigma_Y^2 + 2 rho sigma_X sigma_Y).
$
donde $rho$ es la correlación entre ambos productos.

Y de hecho,
$
  var(sum_i a_i X_i) =
  underbrace((a_1, dots, a_N), a^trans)
  underbrace(
    mat(
      V(X_1), cov(X_1, X_2), dots, cov(X_1, X_N); cov(X_2, X_1), var(X_2);
      , , dots.down;
      , , , V(X_N)
    ),
    cov(X, X)
  )
  underbrace(vec(a_1, dots.v, a_N), a),
$

