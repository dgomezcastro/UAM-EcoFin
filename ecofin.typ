#import "header/template.typ": *
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
#include "chapters/intro.typ"
#include "chapters/01-nociones.typ"
#include "chapters/02-instrumentos.typ"
#include "chapters/03-arbitraje.typ"


