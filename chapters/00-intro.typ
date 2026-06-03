// LTeX: language=es

#import "../header/template.typ": *

= Introducción

#set heading(numbering: none)


== Mercados

=== Over-the-counter markets

=== Contratos a plazo

=== Contratos a futuro

=== Opciones

== Tipos de _traders_

==== _Hedgers_

==== Especuladores

==== _Arbitrageurs_

== Tipos de interés

=== Intución

Esto funciona bien si pensamos por ejemplo, en una inversión hecha el 1 de enero 2025, y que devuelve el dinero el 1 de 2026.

En su presentación más sencilla, el tipo de interés $r$ (expresado en %), es el número tal que
$
  "dinero recibido \n el 1 de enero de 2026" = (1 + r) times "dinero invertido \n el 1 de enero de 2025".
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

Si tenemos una inversión que promete un retorno de $r$ a $T$ años (típicamente $1/T$ es natural), podemos utilizar la fórmula del interés compuesto para deducir cual es el tipo anual
$
  1 + r_("anual") = (1 + r)^(1/T).
$
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
    columns: (1fr, 1fr),
    inset: 10pt,
    align: (left, right),
    table.header([*Frecuencia de composición*], [*Valor de $100€$ a final de año*]),
    [Anual $m=1$], [110.00€],
    [Semi-anual ($m=2$)], [110.25€],
    [Cuatrimestral ($m=4$)], [110.38€],
    [Mensual ($m=12$)], [110.47€],
    [Semanal ($m=52$)], [110.51€],
    [Diario ($m=365$)], [110.52€],
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

== El tiempo
En finanzas, la unidad de tiempo es el año.
Sin embargo si no se precisa más, esto resulta ambiguo:
- ¿Cuántos días tiene un año?
- ¿Qué pasa con los bisiestos?
- ¿Cuánto son 6 meses?

Para evitar esta y otras ambigüedades, los mercados financieros usan reglas como la 30/360 (bonos municipales y corporativos en USA). Ver
#quote(block: true)[#link("https://en.wikipedia.org/wiki/Day_count_convention").]

Por ejemplo, uno de los componentes de esta cuenta $D_1/M_1/Y_1$ y $D_2/M_2/Y_2$ se calcula
$
  "DayCountFactor" = (360 times (Y_2-Y_1) + 30 times (M_2 - M_1) + (D_2-D_1))/360
$
El resultado, natural, queda expresado en años.


== El planteamiento estocástico

El mercado contiene una serie de activos de diferentes tipos que ya hemos presentado: acciones, bonos, opciones, ...
Habitualmente denotamos por $S_t$ al valor de un activo a tiempo $t$.
Modelizar la evolución valor de los activos de riesgo, $S_t$, es el problema más difícil en Matemática Financiera. Dado que en este valor influyen muchos factores que no somos capaces de modelizar, pensaremos que el valor tiene una componente estocástica. Así, usaremos nociones de procesos estocásticos.

De esta manera, a lo largo supondremos que este un espacio de probabilidad $(Omega, cal(F), PP)$,
donde $Omega$ es el conjunto de sucesos, $cal(F)$ (cuyos elementos son sub-conjuntos de $Omega$) es una $sigma$-álgebra de sucesiones medibles y $PP:cal(F) -> [0,1]$ es una medida de probabilidad.
Así $S_t : Omega -> [0,oo)$ asumimos que para cualquier $A$ de la $sigma$-álgebra de Borel $S_t^(-1)(A) in cal(F)$ y, de esta manera damos sentido a
$
  PP(S_t in A) := PP(S_t^(-1)(A)).
$
Habitualmente hay más de un activo de riesgo, con lo que $S_t = (S_t^((1)), dots, S_t^((N)))$ donde cada $S_t^((i)) : Omega -> [0,oo)$.

#example[Árbol binomial][
  Consideremos un activo muy sencillo descrito mediante
  Supongamos que el valor del activo a tiempo $T$ sólo puede subir por un factor $u$ con cierta probabilidad $p$ o bajar por un factor $d$, es decir
  $
    bb(P)(S_T = u S_0) = p " y " bb(P)(S_T = d S_0) = 1-p
  $
  Esto quiere decir que $Omega$ es un conjunto de dos elementos (cualesquiera), por ejemplo
  $
    Omega = {"sube", "baja"}
  $
  Así $cal(F)$

  // TODO FINISH

  #figure(
    raw-render(```
    digraph {
      rankdir=LR
    node[math=true, xmath=true]
    edge[lmath=true]
    // s[label="sum_(n=0)^3 n"]
    s[label="S_0"]
    s -> s1[label="p"]
    s -> s2[label="1-p"]
    s1[label="u S_0"]
    s2[label="d S_0"]
    }
    ```),
    caption: "Modelo discreto con un periodo de tiempo",
  )<fig:binomial>
]
=== Carteras de inversión

Una cartera es una combinación de diferentes activos en diferentes cantidades.
Puede estar compuesta de activos subyacentes y derivados.
Por ejemplo: 5 acciones de IBM, 1 bono del Tesoro, y una opción europeas de compra de 5 acciones de Microsoft.
Lo normal es que estas cantidades cambien con el tiempo.
Se suele expresar $x^((i))_t$ denota la cantidad del activo $i$-ésimo a tiempo $t$.
Si llamamos $S_t^((i))$ al valor del activo $i$-ésimo en tiempo $t$, el valor de la cartera se escribe como
$
  V_t := sum_(i=1)^N x_t^((i)) dot S_t^((i)).
$
Según el momento trabajaremos con tiempo $t$ discreto o continuo.

== Ejercicios
+ ¿Cuantos años hay entre el 30/11/06 y el 01/03/08?

+ El 1 de enero de 2007, A invirtió 1000€ en su libreta. El 1 de enero de 2008 el banco le informa que ha recibido 40€ de intereses a lo largo del año.
  - ¿Cuales son los intereses brutos asociados?
  - ¿Qué intereses recibirá a lo largo de 2008?
  - ¿Cuánto habría recibido de haber cerrado su cuenta el 1 de julio.

+ Ordenar de menor a mayor los siguientes tipos de interés:
  - 6% anual;
  - 0,5% mensual;
  - 30% por 5 años;
  - 10% el primer año y 4% los dos siguientes.

+ Responder a las siguientes preguntas:
  - Dado un tipo del 10% compuesto semianualmente, ¿Cuál es el tipo continuo equivalente?
  - Un prestamista pretende conseguir el 8% continuo y cobra trimestralmente. ¿Cuál es el tipo anual para composición trimestral equivalente?
