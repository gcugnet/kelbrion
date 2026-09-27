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

#pagebreak()

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

#pagebreak()

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

#pagebreak()

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

#pagebreak()

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

#pagebreak()

#hidden-heading(level: 2)[Tableau de priorisation des projets]
<tableau-priorisation-projets>

#figure(
  rotate(
    -90deg,
    reflow: true,
    image("assets/tableau-priorisation-projets.png", width: 94%),
  ),
  caption: "Tableau utilisé pour calculer la priorité de chaque projet",
)

#pagebreak()

#hidden-heading(level: 2)[Aperçu de la fiche projet P4]
<apperçu-fiche-projet>

#figure(
  rotate(
    0deg,
    reflow: true,
    image("assets/apperçu-fiche-projet.png", width: 94%),
  ),
  caption: "Capture écran du document « Fiche projet » complété pour P4 - déploiment du MES.",
)

#pagebreak()

#hidden-heading(level: 2)[Tableau des resources du projet P4]
<tableau-ressources-p4>

#figure(
  rotate(
    0deg,
    reflow: true,
    image("assets/tableau-ressources-p4.png", width: 100%),
  ),
  caption: "Tableau détaillant les différentes ressources du projet P4 « Déploiment du MES » avec indication sur la charge en jours homme et la période d’occupation.",
)

~

#hidden-heading(level: 2)[Tableau des fournisseurs du projet P4]
<tableau-fournisseurs-p4>

#figure(
  rotate(
    0deg,
    reflow: true,
    image("assets/tableau-fournisseurs-p4.png", width: 100%),
  ),
  caption: "Tableau détaillant les différents fournisseurs du projet P4 « Déploiment du MES » avec indication du montant et du mode de pilotage.",
)
