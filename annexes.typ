#import "helpers.typ": hidden-heading
#import "@preview/zebraw:0.5.5": *

#show: zebraw
#let terminal(it) = zebraw(lang: false, numbering: false)[#set text(size: 9.4pt)
  #it
]

#heading(
  level: 1,
  numbering: none,
)[Annexes]

// Beginning of a hack
#show heading.where(level: 1): none

#heading(
  level: 1,
  outlined: false,
)[]
// End of the hack :)

#hidden-heading(level: 2)[Matrice tronquée d’urgence projets]
<matrice-urgence-projets>

#figure(
  rotate(
    -90deg,
    reflow: true,
    image("assets/matrice-urgence-projets.png", width: 89%),
  ),
  caption: "Matrice (tronquée) utilisée pour attribuer le critère d’urgence aux projets",
)

#hidden-heading(level: 2)[Matrice des risques projets]
<matrice-risques-projets>

#figure(
  rotate(
    -90deg,
    reflow: true,
    image("assets/matrice-risques-projets.png", width: 89%),
  ),
  caption: "Matrice utilisée pour attribuer le critère de maîtrise des risques aux projets",
)
