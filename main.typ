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

#include "introduction.typ"
#pagebreak()

#include "parts/01-referentiel-pmo/00-part.typ"
#include "parts/01-referentiel-pmo/01-objectifs.typ"
#include "parts/01-referentiel-pmo/02-liste-livrables.typ"
#include "parts/01-referentiel-pmo/03-adaptation-livrables.typ"
#pagebreak()

#include "parts/02-priorisation-portefeuille/00-part.typ"
#include "parts/02-priorisation-portefeuille/01-criteres-ponderes.typ"
#include "parts/02-priorisation-portefeuille/02-calcul-rentabilite.typ"
#include "parts/02-priorisation-portefeuille/03-arbitrage-strategique.typ"
#include "parts/02-priorisation-portefeuille/04-cotation-projets.typ"
#include "parts/02-priorisation-portefeuille/05-diagramme-radar.typ"
#pagebreak()

#include "parts/03-gestion-projet/00-part.typ"
#include "parts/03-gestion-projet/01-presentation-projet.typ"
#include "parts/03-gestion-projet/02-cadrage.typ"
#include "parts/03-gestion-projet/03-charte-projet.typ"
#include "parts/03-gestion-projet/04-cahier-des-charges.typ"
#include "parts/03-gestion-projet/05-planning-previsionnel.typ"
#include "parts/03-gestion-projet/06-gestion-risques.typ"
#include "parts/03-gestion-projet/07-plan-communication.typ"
#include "parts/03-gestion-projet/08-budget-previsionnel.typ"
#pagebreak()

#include "parts/04-pilotage-tdb/00-part.typ"
#include "parts/04-pilotage-tdb/01-definition-kpi.typ"
#include "parts/04-pilotage-tdb/02-dashboard.typ"
#pagebreak()

#include "parts/05-recette-cloture/00-part.typ"
#include "parts/05-recette-cloture/01-plan-recette.typ"
#include "parts/05-recette-cloture/02-proces-verbal.typ"
#pagebreak()

#include "parts/06-capitalisation/00-part.typ"
#include "parts/06-capitalisation/01-retour-experience.typ"
#include "parts/06-capitalisation/02-boucle-amelioration.typ"
#pagebreak()

#include "conclusion.typ"
#pagebreak()

#include "glossaire.typ"
#pagebreak()
