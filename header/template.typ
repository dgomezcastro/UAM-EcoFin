#import "@preview/ilm:2.0.0": *

#import "@preview/theorion:0.5.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *

#let apuntes(doc, title: none, author: none, date: none, abstract: none, bibliography: none, lang: "es") = {
  show: show-theorion

  // set page(paper: "a4")
  // set heading(numbering: "1.1")

  show: ilm.with(
    title: title,
    authors: author,
    date: date,
    abstract: abstract,
    bibliography: bibliography,
    figure-index: (enabled: false),
    table-index: (enabled: false),
    listing-index: (enabled: false),
    footer: "page-number-center",
  )

  set text(lang: lang)
  set page(paper: "a4")
  set heading(numbering: "1.1.1")

  // show chapter on figure numbering
  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()))

  // show chapter on equation numbering
  set math.equation(numbering: (..num) => numbering("(1.1)", counter(heading).get().first(), num.pos().first()))

  show heading.where(level: 1): it => {
    // reset figure counters so they are counted per chapter
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: "code")).update(0)
    counter(figure.where(kind: "algo")).update(0)

    it
  }

  doc
}

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let code-block(body, caption: none) = {
  show: codly-init.with()
  codly(languages: codly-languages)
  figure(
    body,
    supplement: "Código",
    kind: "code",
    caption: caption,
  )
}

#import "@preview/algo:0.3.6": algo, comment, d, i
#let algo-block(body, caption: none) = {
  show table.cell.where(y: 0): it => {
    // ilm and algo have an incompatibility
    // Disable the smcp OpenType feature that smallcaps enables
    text(features: ("smcp": 0), it)
  }

  figure(
    body,
    supplement: "Algoritmo",
    kind: "algo",
    caption: caption,
  )
}

