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

=== Tipo de interés nominal: TIN

#quote(block: true, attribution: "Wikipedia")[
  El tipo de interés nominal (o, por sus siglas, TIN), conocido también como interés nominal, es el porcentaje que se agregará al capital cedido como remuneración durante un periodo determinado (no necesariamente un año). El TIN no tiene en cuenta otros gastos de la operación como pueden ser las comisiones o las vinculaciones que conlleva el producto.

  El interés dado un TIN de $r_i$ y un capital $C$ se calcula:
  $
    i=C times r_i
  $
  A partir de una TIN puede calcularse el interés anual ($r_a$):
  $
    r_a=(1+r_i)^(1/n)-1
  $
  siendo $n$ el número de años o una fracción si el periodo es menor.
]
Como veremos más abajo, en hipotecas es habitual utilizar fracciones sencillas del $"TIN"_"anual"$.


== Préstamos

*Ejemplo (Hipoteca)*.
En una hipoteca el tipo de interés se suele expresar en TIN anual.
A esto hay que añadirle una comisión de apertura (por ejemplo el 1.5% del principal), así como otras posibles comisiones por cancelación anticipada, etc...

=== Amortización francesa

La premisa de esta amortización es que la cuota mensual, $c$, permanece fija si el interés nominal no cambia.
De manera que hemos de deducir $c$.
El interés en el mes $n$-ésimo, $i_n$, es siempre la proporcionales al principal pendiente, $p_n$, es decir $i_n = r p_n$, donde $r$ es el tipo de interés mensual.
En la práctica se aplica la convención de que el tipo mensual es
$
  r = "TIN"_"anual" / 12.
$
El $"TIN"_"anual"$ es el tipo de interés que negociaremos con el banco.
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

