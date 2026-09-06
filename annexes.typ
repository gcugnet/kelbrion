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

#hidden-heading(level: 2)[Titre de l’annexe]
<titre-pour-lien>
