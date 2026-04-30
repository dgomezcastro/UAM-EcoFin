// LTeX: language=es

#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

= Valoración por no arbitraje, modelos de valoración.

// Modelo matricial (un periodo de tiempo)
// Valoración por replicación, carteras de cobertura, oportunidades de arbitraje.
// Numerarios y probabilidad de
// valoración, teorema fundamental de valoración, mercados completos e incompletos.
// Modelos en árboles binomiales.
// Construcción del modelo binomial de Jarrow-Rudd.
// Valoración de opciones europeas.
// Paso al límite, fórmulas de Black-Scholes.
// Valoración de opciones americanas, ejercicio óptimo.

== Modelo matricial (un periodo de tiempo)

Supongamos el producto estocástico más sencillo, que hoy vale $s_0$ y mañana valdrá $s_1$€ con probabilidad $p$ o $s_2$€ con probabilidad $1-p = 1-p$.

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="s_0"]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="s_1"]
  s2[label="s_2"]
  }
  ```),
  caption: "Modelo discreto con un periodo de tiempo",
)
Para este modelo no sea determinista, supongamos que $s_1 != s_2$

== Valoración por replicación

Una opción de compra (_call option_) es el derecho, pero no la obligación, de comprar mañana el activo a un precio $K$. Llamaremos al valor de la call $C$. Hoy su valor, que es lo que queremos fijar, es $C_0$, y el valor mañana es $C_1$.

Como el lógico, si el valor mañana $S_1 > K$ entonces puedo me interesará ejercer la opción, y ganaré $S_1 - K$. 
Si el valor es menor o igual $S_1 <= K$, entonces no la ejerzo, y no ganaré nada. Esto puede escribir como que el beneficio es el valor de la call mañana $C_1 = (S_1 - K)_+$.
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="c_0?"]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="(s_1-K)_+"]
  s2[label="(s_2-K)_+"]
  }
  ```),
  caption: "Modelo discreto con un periodo de tiempo",
)

Supongamos además que existe un bono, que hoy vale $b_0$ y mañana valdrá seguro $e^r b_1$. En tal caso podemos construir una cartera que a cada tiempo con $phi$ acciones y $psi$ bonos, cuyo valor inicial es
$
  d_0 = phi s_0 + psi b_0
$
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="phi s_0 + psi b_0"]
  s -> s1[label="p"]
  s -> s2[label="1-p"]
  s1[label="phi s_1 + psi e^r b_0"]
  s2[label="phi s_2 + psi e^r b_0"]
  }
  ```),
  caption: "Evolución de una cartera",
)
La convertimos en una *cartera de cobertura* haciendo que tanto si ocurre $s_1$ como si ocurre $s_2$ obtengamos el mismo resultado 
$
  phi s_1 + psi e^r b_0 = (s_1 - K)_+ \ 
  psi s_2 + psi e^r b_0 = (s_2 - K)_+
$
Matricialmente 
$
  mat(s_1, e^r b_0; 
    s_2, e^r b_0)
  mat(phi; psi) 
  = 
  mat((s_1-K)_+; (s_2 - K)_+)
$<eq:cobertura>
Como $s_1 eq.not s_2$ entonces encontramos una única solución del sistema.

Supongamos que yo valoro la opción con un valor $c_0 > d_0$ (y estoy dispuesto a comprarla o venderla a ese precio). En este caso, un inversor inteligente hace lo siguiente:
- Hoy: venderme la opción a precio $c_0$, y comprar en el mercado la cartera de cobertura lo que le cuesta $d_0$.
  Por ahora tiene un beneficio neto de $c_0 - d_0 > 0$.
  Esto requiere pedir "prestada" una de las acciones (lo que habitualmente se conoce como quedarse "corto"). 
- Mañana: como el inversor a pedido prestadas acciones, debe liquidar la cartera.
  + Si el valor de la acción es $s_i <= K$, yo no ejercerá la opción. La cartera ahora vale $psi s_i + psi e^r b_0 = (s_i - K)_+ = 0$, con lo que puede liquidarla sin perder o ganar dinero y ya no está corto ni largo acciones. 
  + Si el valor de la acción es $s_i > K$. Yo querré ejercer la opción, y comprar la acción por $K$€. Al liquidar la cartera el inversor obtiene (o pierde) $psi s_i + psi e^r b_0 = (s_i - K)_+ = s_i - K$. Junto esto con los $K$€ que yo le doy, puede comprar la acción, y dármela. En esta operación no pierde o gana dinero.

Al final de la jugada, el inversor inteligente se va a casa con $c_0 - d_0 > 0$ ¡con probabilidad 1! Este es el efecto es el conocido como *arbitraje*.
En caso de que $c_0 < d_0$ entonces el inversor me compra la opción, y vende en el mercado la cartera. 
De tal manera que el único precio que no genera opciones de arbitraje es 
$
  c_0 = phi s_0 + psi e^r b_0,
$
donde $(phi,psi)$ es la solución de @eq:cobertura, es el llamado *precio libre de arbitraje*.

Hemos hecho algunas suposiciones:
- Ausencia de comisiones: todas las operaciones de compra y venta se han hecho "gratis"
- Liquidez: el mercado está dispuesto a comprar y vender de todas las acciones que quiera, y en cantidades fraccionarias

== Valoración por valor esperado, la medida riesgo neutro

Es fácil observar que en general el valor libre de arbitraje no es el valor esperado 
$
  c_0 != bb(E)^(bb(P))[ (S_1 - K)_+ ] = p (s_1-K)_+ + (1-p) (s_2 - K)_+.
$
Sin embargo, es interesar observar que puede existir un valor $q$ tal que 
$
  c_0 = q (s_1-K)_+ + (1-q) (s_2 - K)_+.
$
En el caso no trivial $(s_1-K)_+ != (s_2 - K)_+$ obtenemos
$
  q = (c_0 - (s_2 - K)_+) / ((s_1 - K)_+ - (s_2 - K)_+).
$
Así, la opción de compra asociada al precio $K$ de  
#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="s_0"]
  s -> s1[label="q"]
  s -> s2[label="1-q"]
  s1[label="s_1"]
  s2[label="s_2"]
  }
  ```),
)
sí cumple 
$
  c_0 = bb(E)^(bb(Q))[(S_1 - K)_+].
$
Se conoce a $bb(Q)$ como la medida libre de riesgo. 

== Modelo de árboles binomiales

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  s[label="s_0"]
  s1[label="s_1"] 
  s11[label="s_11"] 
  s12[label="s_12"] 
  s2[label="s_2"] 
  s21[label="s_21"] 
  s22[label="s_22"]
  s -> s1[label="p_1"]
  s -> s2[label="1-p_1"]
  s1 -> s11[label="p_12"] 
  s1 -> s12 [label="1-p_12"]
  s2 -> s21 [label="p_22"]
  s2 -> s22[label="1-p_22"]
  }
  ```),
  caption: "Árbol binomial con dos pasos de tiempo",
)