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

#hidden-heading(level: 2)[Tableau d’estimation des coûts et gains projets]
<estimation-couts-gains-projets>

#figure(
  rotate(
    -90deg,
    reflow: true,
    image("assets/tableau-couts-gains-projets.png", width: 94%),
  ),
  caption: "Tableau utilisé pour renseigner les coûts et gains attendus par projet",
)

#hidden-heading(level: 2)[Tableau de rentabilité par projets]
<tableau-rentabilite-projets>

#figure(
  rotate(
    -90deg,
    reflow: true,
    image("assets/tableau-rentabilite-projets.png", width: 94%),
  ),
  caption: "Tableau indiquant la rentabilité par projet",
)

#hidden-heading(level: 2)[Tableau reflétant l’alignement stratégique par projet]
<tableau-alignement-strategique>

#figure(
  rotate(
    -90deg,
    reflow: true,
    image("assets/tableau-alignement-strategique.png", width: 94%),
  ),
  caption: "Tableau permettant de classer les projets par alignement stratégique",
)
