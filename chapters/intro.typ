// LTeX: language=es

#import "../header/template.typ": *

= Introducción

Texto
#theorem[Euclid's Theorem][
  There are infinitely many prime numbers.
] <thm:euclid>

#code-block(
  ```julia
  a::Int64 = 1
  ```,
  caption: "Test",
)

#code-block(
  ```python
  def f()
    return true
  ```,
  caption: "Test",
)

#figure([], caption: "Hi")

#algo-block(
  algo(
    title: "Fib",
    parameters: ("n",),
  )[
    if $n < 0$:#i\        // use #i to indent the following lines
    return null#d\      // use #d to dedent the following lines
    if $n = 0$ or $n = 1$:#i #comment[you can also]\
    return $n$#d #comment[add comments!]\
    return #smallcaps("Fib")$(n-1) +$ #smallcaps("Fib")$(n-2)$
  ],
  caption: "Un algoritmo",
)

@BaxterRennie
