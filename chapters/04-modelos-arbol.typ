// LTeX: language=es
#import "../header/template.typ": *
#import "@preview/diagraph:0.3.7": *

= Modelos en de varios pasos temporales

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
