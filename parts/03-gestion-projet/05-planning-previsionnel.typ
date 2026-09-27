#import "../../helpers.typ": hidden-heading

== Planning prévisionnel
// ~1 page

Le planning prévisionnel nous donne une répartition dans le temps des missions à réaliser pour répondre au plan de management et au cahier des charges. Il est mis à jour chaque semaine pour suivre l’évolution du projet. Les durées y sont exprimées en jours ouvrés (hors jours fériés et périodes de fermeture de l’entreprise).

#hidden-heading(level: 3, numbering: none)[Démarrage]

L’ensemble des projets du portefeuille sont validés en même temps par la direction, car ils constituent un lot pour l’ouverture du nouveau site. Cette validation est intervenue le 22/09/2026. Néanmoins, le projet P4 ne pourra réellement débuter qu’après la réalisation de 2 prérequis déjà observés, à savoir :

1. le déploiement du réseau (P2)
2. la conception de l’architecture cible (P3)

Son kick-off est donc fixé au 11/01/2027, et sa clôture, environ 28 semaines plus tard, au 23/07/2027. La mise en service intervient suffisamment en amont de l’ouverture du site en septembre 2027, ce qui devrait permettre au projet P10 dédié à la supervision de se connecter au MES pour en récupérer des métriques.

// #figure(
//   image("../../assets/gantt-p4.png", width: 100%),
//   caption: "Diagramme de Gantt du projet P4 « Déploiement du MES ».",
// )

#hidden-heading(level: 3, numbering: none)[Phases]

Le projet suit les 5 phases du cycle en V retenues dans le plan de management. Le tableau ci-dessous en résume les dates, les principales tâches et les responsables.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 9.5pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (1.3fr, 1.4fr, 3.6fr, 2fr),
          align: (left + horizon, center + horizon, left + horizon, left + horizon),

          [#strong[Phase]], [#strong[Période]], [#strong[Tâches principales]], [#strong[Responsables]],

          [Cadrage],
          [11/01 au 29/01/2027],
          [Réunion de kick-off, ateliers de recueil des besoins, cahier des charges, plan de management],
          [CP DSI],

          [Conception],
          [01/02 au 26/02/2027],
          [Définition du paramétrage, précision des interfaces MES-ERP, DAT, sécurité, cahier de recette, sélection des fournisseurs],
          [CP DSI, développeurs, responsable qualité, fournisseur MES choisi],

          [Réalisation],
          [mars à fin mai 2027],
          [Création des environnements, paramétrage du MES, interfaçage avec l’ERP, reprise des données de l’entreprise, réception des terminaux mobiles, tests d’intégration],
          [DevOps, développeurs, éditeur MES],

          [Recette et déploiement],
          [31/05 au 22/07/2027],
          [Recette technique, formation des équipes, recette fonctionnelle, mise en production],
          [CP DSI, DevOps, développeurs, éditeur MES, responsable de l’atelier],

          [Clôture], [19/07 au 23/07/2027], [Bilan de projet et fiches REX], [CP DSI],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Grandes phases du projet P4, avec leurs dates, tâches principales et responsables
  ],
)

La réalisation est la phase la plus longue (environ 3 mois). C’est aussi celle qui contient le plus d’incertitudes, notamment sur les délais, et qui mobilise le plus de ressources (DevOps, développeurs, fournisseur du MES). Elle est divisée en sous-phases qui concernent le paramétrage du MES (30 jours), le développement des interfaces (25 jours côté ERP et 25 jours côté MES) et le déploiement des terminaux en atelier. Tout retard pris durant cette phase impactera non seulement la suite de ce projet, mais également les autres projets du portefeuille (notamment P10).

#hidden-heading(level: 3, numbering: none)[Jalons]

Le projet est divisé en 6 jalons, et chacun est validé ou non au cours d’une réunion dédiée :

- G0 le 22/09/2026 : validation de la fiche projet en CODIR
- G1 le 29/01/2027 : validation du cadrage par le Directeur de la production et le DSI
- G2 le 26/02/2027 : validation de la phase de conception en COPIL
- G3 le 28/05/2027 : validation de la phase de réalisation en COPIL
- G4 le 25/06/2027 : signature du PV par le Directeur de la production et go pour la mise en service
- clôture, le 23/07/2027 : présentation du bilan de projet en CODIR

Entre G4 et la clôture, la bascule en production a lieu le 28/06/2027. Elle est suivie d’environ 2 semaines d’accompagnement au démarrage, jusqu’à la fin opérationnelle du projet prévue le 08/07/2027.

Ces jalons correspondent aux réunions du COPIL prévues dans le plan de management. Le chef de projet DSI avance librement entre 2 jalons, tant qu’aucun seuil d’alerte n’est franchi.

Vous trouverez ci-dessous un aperçu simplifié et tronqué du diagramme de Gantt du projet (en bleu foncé les tâches planifiées, en bleu clair l’indicateur d’avancement, et en orange les jalons, « instantanés » dans le temps) :

#figure(
  rotate(
    reflow: true,
    image("../../assets/gantt-raccourci.png", width: 100%),
  ),
  caption: "Diagramme de Gantt tronqué du projet P4 « Déploiement d’un MES »",
)

Vous pouvez retrouver la version complète et interactive de ce diagramme en suivant #link("https://docs.google.com/spreadsheets/d/1jGbTjYVkqXgt-2_57qTqi7UHspG3DhIw/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien].

#hidden-heading(level: 3, numbering: none)[Dépendances]

Chaque tâche du planning est rattachée à une ou plusieurs dépendances, qui doivent être terminées avant qu’elle ne puisse commencer. La chaîne la plus tendue est celle des interfaçages avec l’ERP : les informations techniques livrées par l’éditeur permettent le développement de la réception des OF puis la remontée des informations sur la production réelle. Il est prévu que les tests d’intégration se terminent seulement 2 jours ouvrés avant la fin du jalon G3, ce qui laisse très peu de marge de manœuvre.

Par ailleurs, nous avons déjà évoqué les dépendances amont et aval de P4 avec 4 autres projets du portefeuille :
- le déploiement du réseau (P2), prérequis au démarrage et à l’installation des terminaux en atelier
- l’architecture cible (P3) dont les règles s’appliquent au dossier d’architecture
- l’authentification unique (P9), à intégrer pendant la réalisation
- la supervision (P10), qui intègre des données liées à la production présentes dans le MES.
