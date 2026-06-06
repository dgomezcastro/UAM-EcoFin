// LTeX: language=es

#import "../header/template.typ": *

= Nociones básicas de aritmética financiera

// Tipos de interés, capitalizaciones, préstamos, rentas.
// Rendimientos, tasa interna de rendimientos. Estructura temporal de tipos de interés, la curva cupón cero. Algunos
// cálculos actuariales.

== Tipos de interés

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

=== Fórmulas de conversión

Si tenemos una inversión que promete un retorno de $r$ a $T$ años (típicamente $1 "año" = N T$ donde $N in NN$), podemos utilizar la fórmula del interés compuesto para deducir cual es el tipo anual
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


=== Algunos ejemplos

==== Tipos del Tesoro (_Treasury rates_)

Los del #link("https://home.treasury.gov")[_US Treasury_] o el Banco de España, en letras y bonos (_Treasury bills_ and _Treasury bonds_). Estos son los instrumentos usados por los Gobiernos para pedir dineros prestado en su propia moneda.
Se suele asumir que los gobiernos no llegará a impago (_default_), de manera que se asume que estos tipos de interés son libres de riesgo.

Volveremos sobre las letras y los bonos más abajo.
==== Tipos interbancarios

LIBOR es el acrónimo del _London Interbank Offered Rate_. Es un tipo de préstamo a corto plazo entre bancos, sin garantías. Se calculan a diario cada día laborable en 10 monedas y 15 periodos (desde 1 día hasta 1 año).

El euríbor (del inglés euribor), acrónimo de _Euro Interbank Offered Rate_ es un índice de referencia publicado diariamente que indica el tipo de interés promedio al que un gran número de bancos europeos dicen concederse préstamos a corto plazo entre ellos para prestárselo a terceros —particulares y empresas—.

==== Cupón cero

Se llama cupón a la cantidad de beneficios que recuperamos de una inversión antes del vencimiento en forma de dividendo, y por tanto dinero que no re-invertimos.

Se habla de tipo de interés con cupo cero en $n$ años (_$n$-year zero-coupon interest rate_). Por ejemplo, sin invertimos $100€$ al 5% a lo largo de 5 años, podemos calcular
$
  100 times e^(0.05 times 5) = 128.40€.
$
La mayor parte de los productos en el mercado no tiene cupón cero.

== Préstamos

*Ejemplo (Hipoteca)*.
En una hipoteca el tipo de interés se suele expresar en TIN anual.
A esto hay que añadirle una comisión de apertura (por ejemplo el 1.5% del principal), así como otras posibles comisiones por cancelación anticipada, etc...

=== Amortización francesa

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
$p^* = (1 + r)p^* + c$
(es decir $p^* = -c/r$) y para $x_n = p_n - p^*$ deducimos la ecuación
$x_(n+1) = (1 + r)x_n$
de modo que, por inducción, $x_n = (1 + r)^n x_0$.
// Así $p_n = p^* + (1 + r)^n (p_0 - p^*).$
Dado que buscamos que $p_N = 0$, si queremos que amortizar la hipoteca en $N$ años, es decir $p_N = 0$, podemos despejar
$
  c = (p_0 r)/(1-(1+r)^(-N)).
$

*Comentario: Hipotecas variables*. Un tipo habitual de hipotecas tiene tipo variable o es mixta (unos primeros años con tipo fijo, y luego tipo variable).
Es habitual que el tipo variable se exprese en función como
$
  "Euribor" + "Diferencial".
$
El diferencial se pacta con el banco en la hipoteca, y el euribor es anunciado
En este caso, $r$ va cambiando. Es habitual que se revise cada 6 meses utiliza como $"TIN"_"anual"$ el correspondiente #link("https://www.euribor-rates.eu/es/tipos-euribor-actualmente/4/euribor-valor-12-meses/")["Euribor a 12 meses"].

=== Amortización alemana

=== Amortización americana
