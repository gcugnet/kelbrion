#import "lib.typ": lib
#import "@preview/glossarium:0.5.6": gls, glspl, make-glossary, print-glossary, register-glossary

#show: lib.with(
  lang: "fr",
  title: "Kelbrion",
  document_type: "Supervision et mise en œuvre du portefeuille projets
  de la DSI",
  cursus: "Master Manager en architecture et applications logicielles des SI",
  authors: (
    (
      name: "Guillaume Cugnet",
      email: "guillaume.cugnet@viacesi.fr",
    ),
  ),
  pilote: (
    name: "Alexandre Berteaux",
    email: "alexandre.berteaux@viacesi.fr",
  ),
  tutor: (
    name: "Nicolas Pillon",
    email: "nicolas.pillon@mary.fr",
  ),
  year: "2025",
  to_print: false,
  page_count_start: 4,
)

#include "parts/01-introduction/00-part.typ"
#pagebreak()
