#import "src/header/template.typ": *
#set text(lang: "es")

#import datetime: *
#import "@preview/datify:1.0.1": *

#show: apuntes.with(
  title: [Economía y\ Finanzas Matemáticas],
  author: "David Gómez-Castro",
  abstract: [Departamento de Matemáticas\ Facultad de Ciencias\
    Universidad Autónoma de Madrid\
    \
    #custom-date-format(datetime.today(), pattern: "long", lang: "es")
  ],
  bibliography: bibliography("refs.bib", style: "harvard-cite-them-right"),
)

#include "src/chapters/00-intro.typ"
#include "src/chapters/01-nociones.typ"
#include "src/chapters/02-instrumentos.typ"
#include "src/chapters/03-modelos-un-paso.typ"
#include "src/chapters/04-modelos-arbol.typ"
#include "src/chapters/05-modelos-continuo.typ"
#include "src/chapters/06-mas.typ"


