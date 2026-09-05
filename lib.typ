#import "@preview/muchpdf:0.1.0": muchpdf
#let lib(
  lang: "fr",
  title: none,
  document_type: none,
  cursus: none,
  authors: (),
  pilote: (),
  tutor: (),
  year: none,
  to_print: false,
  page_count_start: 1,
  body,
) = {
  set text(lang: lang)
  set document(title: title)
  let count = authors.len()
  let ncols = calc.min(count, 3)

  page(align(center + horizon)[
    #v(18em)
    #text(1.6em)[*#document_type*] \
    #v(1em)
    #text(1.2em)[#cursus]
    #image("assets/logo-kelbrion.png", width: 70%)
    #text(
      1.2em,
    )[Pilotage et gestion de projets]
    #v(4em)
    #block(grid(
      columns: (1fr, 1fr),
      row-gutter: 24pt,
      ..authors.map(author => [
        *Étudiant :* \
        #author.name \
        #link("mailto:" + author.email) \
      ]),
      [
        *Pilote :* \
        #pilote.name \
        #pilote.email
      ],
    ))
    #v(2em)
    #block(grid(
      columns: (1fr,),
      row-gutter: 24pt,
      [#image("assets/logo-cesi.svg", width: 30%)],
    ))
    #v(5em)
    #text(1.2em, year)
  ])

  if to_print { pagebreak(to: "odd") } else { pagebreak() }

  // Outline represents the "table des matières"
  show outline.entry.where(level: 1): set block(above: 1em)
  show outline.entry.where(level: 1): it => text(it, size: 1.3em)
  show outline.entry.where(level: 2): it => text(it, size: 1.1em)

  // Heading represents how different headers are presented
  show heading.where(level: 1): it => text(it, size: 1.2em)
  show heading.where(level: 2): it => text(it, size: 1.1em)
  show heading.where(level: 3): it => text(it, size: 1.1em)
  show heading.where(level: 4): it => it.body
  show heading.where(level: 5): it => text(it.body, size: 0.9em)

  show heading.where(level: 2): it => pad(it, left: 0.5em)
  show heading.where(level: 3): it => pad(it, left: 2em)
  show heading.where(level: 4): it => pad(it, left: 4em)
  show heading.where(level: 5): it => pad(it, left: 5em)

  set page(
    paper: "a4",
    header: {
      grid(
        columns: (1fr, 1fr, 6fr),
        align: (left, left, right),
        [#image("assets/logo-cesi.svg", width: 90%) #v(6pt)],
        [#image("assets/logo-kelbrion.png", width: 140%) #v(5pt)],
        [#align(horizon, [*#document_type — #title*]) #v(5pt)],
        grid.hline(),
      )
    },
    margin: (x: 2.5cm, y: 4cm),
  )

  set par(
    leading: 6.6pt,
  )
  set text(size: 11pt)
  outline(title: "Plan")

  set heading(numbering: (..parents) => {
    let level = parents.pos().len()
    let num-str = parents.pos().map(str).last()

    if level == 4 {
      "•"
    } else {
      num-str + "."
    }
  })

  if to_print { pagebreak(to: "odd") } else { pagebreak() }

  // set heading(numbering: "1.", outlined: true)
  set par(
    leading: 5pt,
    justify: true,
  )

  set text(size: 12pt)

  show raw.where(block: false): it => (
    h(0.5em) + box(fill: gray.lighten(80%), outset: 0.25em, radius: 0.2em, it) + h(0.5em)
  )

  set table(fill: (_, y) => if calc.even(y) { rgb("f4f4f4") })

  // Reinitialize page count here.
  counter(page).update(1)

  set page(numbering: "1/1")

  body

  bibliography(
    "refs.yml",
    title: "Références",
    full: true,
    style: "assets/custom-ieee.csl",
  )
}

// NOTE: followed rules
// - text line space: 5pt
// - text font size: 12pt
// - plan must be on 1 page (if needed, do not display all sub-parts)

// TODO:
// - add title on first page : "Développement d’applications internes myCréance".
