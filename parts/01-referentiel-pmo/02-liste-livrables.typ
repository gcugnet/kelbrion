#import "../../helpers.typ": hidden-heading

== Liste des livrables standards
// ~2,5 pages

Pour répondre aux objectifs évoqués dans la partie précédente, le référentiel PMO doit imposer un certain nombre de documents à adapter à chaque projet.

Nous avons créé ce référentiel autour de 9 rubriques, qui réunissent plusieurs documents. Nous allons présenter chacune de ces rubriques, et leurs documents principaux (que nous allons lister de D1 à D10, et pour lesquels nous proposerons des exemples).

#hidden-heading(level: 3, numbering: none)[Cadrage et besoins]

#hidden-heading(level: 4, numbering: none)[D1 - Fiche projet]

Cette rubrique contient en premier lieu la fiche projet, premier document créé (avant même que le projet ne soit validé par la direction de l’entreprise). Cette fiche doit présenter le commanditaire, la raison d’être du projet, son intérêt pour l’entreprise, et apporter de premiers éléments de chiffrage (macro-budget, cotations pour le portefeuille). Elle permet au CODIR de l’entreprise de valider chaque nouveau projet. Un exemple de fiche projet est disponible #highlight()[en annexe].

#hidden-heading(level: 4, numbering: none)[D2 - Cahier des charges fonctionnel]

Si le projet est validé, cette rubrique accueillera de nouveaux documents pour affiner la portée du projet : le cahier des charges fonctionnel / backlog (exemple #highlight()[en annexe]) et les critères d’acceptation. Ces documents sont rédigés par le maître d’ouvrage ou chef de projet, en concertation avec les métiers concernés. Ils sont validés par le commanditaire.

#hidden-heading(level: 3, numbering: none)[Plan de management projet]

#hidden-heading(level: 4, numbering: none)[D3 - Le Plan de management projet]

Le Plan de management projet est rédigé par le chef de projet après validation du projet en CODIR. Ce document informe sur les règles du projet : sa gouvernance, les tolérances à l’intérieur desquelles le projet est considéré comme sain, la gestion des risques, la communication, les principales échéances, les coûts et la qualité, et les indicateurs clés. D’une certaine manière, c’est un condensé d’autres documents que l’on retrouve dans les sections rubriques suivantes (notamment le planning et budget). Il peut être revu si besoin à la fin de chaque jalon (phases de validations). Un modèle est disponible en #highlight()[suivant ce lien].

#hidden-heading(level: 3, numbering: none)[Pilotage et suivi]

#hidden-heading(level: 4, numbering: none)[D4 - Diagramme de Gantt]

Dans la rubrique dédiée au pilotage, le diagramme de Gantt est réalisé par le chef de projet. Il se présente comme un macro-planning et a pour objectif de répartir dans le temps les tâches à réaliser pour répondre aux exigences fonctionnelles. Il permet de piloter l’évolution temporelle du projet, et de vérifier que son exécution ne prend pas de retard sur le planning. Il est mis à jour chaque semaine pour informer de ce qui a été réalisé et reste encore à réaliser. #highlight()[Voir annexe.]

#hidden-heading(level: 4, numbering: none)[D5 - Budget]

Le budget est le pendant financier du diagramme de Gantt : en précisant les principaux postes de dépenses du projet, il doit d’abord permettre de vérifier que l’enveloppe totale est suffisante pour le projet (prévisionnel), et ensuite vérifier que les dépenses réellement engagées n’excèdent pas les dépenses initialement prévues. Il est tenu à jour mensuellement par le chef de projet, et un exemple est disponible #highlight()[en annexe].

#hidden-heading(level: 4, numbering: none)[D6 - Tableau de bord]

Le tableau de bord est un autre outil stratégique permettant de suivre l’évolution du projet dans le temps. Il condense les informations présentes dans le planning et dans le budget sous forme d’indicateurs clés : le projet est-il en bonne voie en ce qui concerne les délais, les coûts, la qualité ? Il est créé après la validation du projet, puis maintenu à jour chaque semaine par le chef de projet. Un modèle de tableau de bord est disponible #highlight()[via le lien].

#hidden-heading(level: 3, numbering: none)[Registres]

#hidden-heading(level: 4, numbering: none)[D7 - Évaluation des risques (AMDEC)]

L’ADMEC est une méthode permettant d’évaluer les risques pouvant affecter un projet : l’équipe projet va identifier les risques puis proposer des estimations sur leur gravité, fréquence et non-détection. Un score de criticité est ensuite calculé pour chaque risque, à partir des autres indicateurs : criticité = gravité x fréquence x non-détection. Plus ce score est élevé, plus il faut prendre des actions pour l’atténuer, le détecter ou l’éviter. Toutes ces informations peuvent se retrouver dans un même tableau, à maintenir à jour en fonction de l’évolution du projet. Il s’agit de la matrice des risques, disponible en suivant #highlight()[ce lien].

#hidden-heading(level: 4, numbering: none)[D8 - REX]

Les fiches de retour d’exérience permettent de garder un témoignage structuré de ce qui a été réalisé durant le projet. Rédigées par les membres de l’équipe projet lorsque des situations importantes et peu documentées sont rencontrées, elles incluent les erreurs, les réussites et les enseignements. Elle sont utiles pour officialiser des retours sur le déroulé d’actions passées, et justifier des évolutions dans la gestion de projet (pour éviter de reproduire des erreurs par exemple). Ces fiches forment également une base intéressante pour le bilan de projet. Nous en proposons un exemple via #highlight()[ce lien].

#hidden-heading(level: 3, numbering: none)[Fournisseurs et contrats]

Les documents relatifs aux consultations de fournisseurs (présentations, propositions commerciales) et aux accords avec des fournisseurs (contrats et annexes, PV de réunions, avenants) sont consignés dans cette rubrique. Il n’existe pas vraiment de modèle préétabli pour ces documents qui dépendent fortement du contexte et des fournisseurs. Certains projets réalisés exclusivement avec les ressources internes n’ont pas besoin d’alimenter cette rubrique.

#hidden-heading(level: 3, numbering: none)[Technique]

Cette rubrique permet de centraliser les documents techniques produits en lien avec le projet : document d’architecture technique (DAT), décisions d’architecture (ADR), dossiers d’installation, de paramétrage, de sécurité sur les équipements, etc. Cette rubrique peut parfois être vide également, pour de petits projets dont les réalisations ne recquièrent pas la rédaction de documents supplémentaires par rapport à la fiche projet et au cahier des charges fonctionnel pour bien comprendre ce qui a été produit.

#hidden-heading(level: 3, numbering: none)[6 - Communication]

#hidden-heading(level: 4, numbering: none)[D9 - Plan de communication]

Le plan de communication est rédigé par le chef de projet, pendant la phase de démarrage. Ce document permet de répondre à ces questions : qui doit communiquer quoi, à qui, à quelle fréquence, et par quel moyen (email, téléphone, réunion, outil de chat) ? Il peut être revu sur demande. Vous en trouverez un exemple en suivant #highlight()[ce lien].

#hidden-heading(level: 3, numbering: none)[Recette]

#hidden-heading(level: 4, numbering: none)[D10 - PV de recette]

Le procès verbal de recette est rédigé par le chef de projet, en concertation avec le référent métier ou le maître d’ouvrage. Il définit les critères de validation, et indique s’ils ont été atteints ou non. Il renseigne sur la validation des livrables : sans réserves, avec réserves, ou non validé, et permet aux fournisseurs d’être payés le cas échéant. Il est complété à chaque phase de recette. Un exemple est disponible via #highlight()[ce lien].

#figure(
  [#figure(
      align(center)[#table(
        columns: (0.35fr, 1.6fr, 4fr, 1.6fr),
        align: (center, left, left, left),

        [#strong[N°]], [#strong[Rubrique]], [#strong[Contenu type]], [#strong[Créé / mis à jour]],

        [0],
        [Cadrage \ et besoins],
        [
          - fiche projet \
          - cotations, macro-budget \
          - commanditaire \
          - objectifs, enjeux (bénéfices attendus, ...) \
          - cahier des charges fonctionnel, backlog \
          - exigences, critères d’acceptation \
        ],
        [
          - G0 fiche projet\
          - G1 autres docs
          - revue à chaque jalon
        ],

        [1],
        [Plan de \ management projet (PMP)],
        [
          - identité, objectifs et périmètres \
          - gouvernance, organisation et responsabilités \
          - gestion des risques \
          - délais, coûts, qualité \
          - communication \
          - KPI
        ],
        [
          - G1 \
          - revue à chaque jalon
        ],

        [2],
        [Pilotage et suivi],
        [
          - planning jalonné (+ PERT et Gantt si utile) \
          - suivi budgétaire (prévu, consommé, engagé) \
          - gestion des risques
          - tableau de bord
        ],
        [
          - G1 \
          - hebdomadaire
        ],

        [3],
        [Registres],
        [
          - risques \
          - décisions (inclut changements + REX) \
          - actions
        ],
        [
          - en continu \
          - revue \ hebdomadaire
        ],

        [4],
        [Fournisseurs et contrats],
        [
          - consultations (devis, ...) \
          - contrats + annexes \
          - PV de réunions contractuelles, avenants
        ],
        [
          - à la \ consultation \
          - à chaque \ signature
        ],

        [5],
        [Technique],
        [
          - DAT \
          - dossiers d'installation/paramétrage, sécurité
        ],
        [aux jalons \ concernés],

        [6],
        [Communication],
        [- plan de communication],
        [
          G1 \
        ],

        [7],
        [Recette],
        [
          - stratégie de recette \
          - cahier de recette (cas de tests), journaux d'exécution \
          - tests d’acceptation \
          - PV de recette interne (si pas de presta)
        ],
        [avant chaque \ recette],

        [8], [Clôture], [- bilan de projet], [jalon final],
      )],
      kind: table,
    )
  ],
  caption: [
    Rubriques et contenu proposé du référentiel PMO.
  ],
)

#hidden-heading(level: 3, numbering: none)[Clôture]

Le chef de projet est en charge de rédiger un bilan de projet à la fin du jalon final. Ce document prend la forme d’une synthèse générale qui informe sur la conformité des résultats obtenus, analyse les éventuels écarts, la communication, aborde la gestion des risques, condense les expériences acquises (fiches REX) et évalue la satisfaction des parties prenantes à l’égard du projet.
