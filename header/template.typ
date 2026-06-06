#import "math.typ": *

#import "@preview/itemize:0.2.0" as el

#import "@preview/diagraph:0.3.7": *

#import "@preview/ilm:2.0.0": *

#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *

#import "@preview/headcount:0.1.0": *

// #let (exercise-counter, exercise-box, exercise, show-exercise) = make-frame(
//   "exercise",
//   theorion-i18n-map.at("exercise"),
//   inherited-levels: 1,
//   inherited-from: heading,
//   numbering: "1.1",
//   render: (prefix: none, title: "", full-title: auto, body) => block(width: 100%)[
//     #if full-title != "" {
//       strong[#full-title.]
//       sym.space
//     }
//     #body
//   ],
// )

#show: show-exercise

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
    table-of-contents: outline(depth: 2),
  )

  set text(lang: lang)
  set page(paper: "a4")
  set heading(numbering: "1.1.1")
  // set enum(numbering: chapter-item-numbering, full: true)

  show heading.where(level: 4): set heading(numbering: none)
  show heading.where(level: 5): set heading(numbering: none)
  // #set heading(numbering: (first, ..nums) => numbering("1.", ..nums))
  set figure(numbering: dependent-numbering("1.1"))
  show heading: reset-counter(counter(figure.where(kind: image)))

  set math.equation(numbering: dependent-numbering("(1.1)"))
  show heading: reset-counter(counter(math.equation))
  // Number only labeled equations
  // https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations/977/17
  show math.equation: it => {
    if it.block and not it.has("label") and it.numbering != none [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)
    ] else {
      it
    }
  }

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location()),
      )
    } else {
      // Other references as usual.
      it
    }
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
