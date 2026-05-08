// LTeX: language=es

#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

= Modelos de un paso temporal

// Modelo matricial (un periodo de tiempo)
// Valoración por replicación, carteras de cobertura, oportunidades de arbitraje.
// Numerarios y probabilidad de
// valoración, teorema fundamental de valoración, mercados completos e incompletos.
// Modelos en árboles binomiales.
// Construcción del modelo binomial de Jarrow-Rudd.
// Valoración de opciones europeas.
// Paso al límite, fórmulas de Black-Scholes.
// Valoración de opciones americanas, ejercicio óptimo.

Supongamos que tenemos un modelo discreto y estudiamos sólo lo tiempos $t = 0$ y $t = T$.


== Modelo con un activo y dos estados

#figure(
  raw-render(```
  digraph {
    rankdir=LR
  node[math=true, xmath=true]
  edge[lmath=true]
  // s[label="sum_(n=0)^3 n"]
  s[label="s_0"]
  s -> s1[label="0 + 1"]
  s -> s2
  s1[label="0"]
  s2[label="1"]
  }
  ```),
  caption: "A graph",
)

== Modelo con un activo y tres estados

== Modelo con $N$ activos y $n$ estados

== La medida libre de riesgo
