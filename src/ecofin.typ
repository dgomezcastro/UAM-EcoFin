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

#include "chapters/00-intro.typ"
#include "chapters/01-nociones.typ"
#include "chapters/02-instrumentos.typ"
#include "chapters/03-modelos-un-paso.typ"
#include "chapters/04-modelos-arbol.typ"
#include "chapters/05-modelos-continuo.typ"

#set heading(numbering: "A.1", supplement: [Apéndice])
#counter(heading).update(0)

#include "chapters/06-repaso-estadistica.typ"
#include "chapters/07-tae.typ"


