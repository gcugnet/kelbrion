#import "../../helpers.typ": hidden-heading

== Critères pondérés
// ~1 page

En gestion de projet, nous pensons que garder les choses simples peut-être une voie intéressante à suivre : cela facilite la compréhension des équipes, les mises à jour régulières et donc la capacité à travailler avec des données « fraîches ». Nous pensons que plus le contexte est complexe, plus l’exercice de simplification est important. Nous proposons par conséquent de limiter le nombre de critères utilisés pour noter chaque projet.

En partant de ce postulat, nous avons défini 4 critères pondérés pour calculer la criticité de chaque projet et les prioriser en fonction du résultat.

Ces 4 critères sont :
- alignement stratégique
- urgence pour l’ouverture
- rentabilité
- maîtrise des risques

Chaque critère est calculé à partir d’une méthode qui permet de rendre son score le plus transparent et justifiable possible. Malgré tout, certaines notations restent le fruit d’un arbitrage partial. Par exemple, comment chiffrer avec exactitude le nombre de jours homme à allouer à un projet avant de connaître tous les détails du projet et la vélocité des ressources qui y seront allouées, sur ce type de projet précisément ? C’est très difficile d’avoir une réponse exacte. Pour cela, nous essayons de ne pas trop faire peser les données les moins sûres sur la notation des projets.

#hidden-heading(level: 3, numbering: none)[Alignement stratégique]

Ce critère est construit à partir des 5 orientations stratégiques de Kelbrion :
- accroître la capacité de production et réduire les délais de livraison client
- accélérer l’innovation et réduire le délai de mise sur le marché des nouveaux produits
- renforcer la sécurité, la conformité et la résilience du système d’information
- rationaliser le parc applicatif et maîtriser les coûts informatiques
- améliorer la productivité et l’expérience numérique des collaborateurs

Nous détaillerons la méthode utilisée pour attribuer une note par projet en fonction de ces critères dans la partie 2.@arbitrage-strategique[] Arbitrage stratégique.

#hidden-heading(level: 3, numbering: none)[Urgence]

Le critère d’urgence mesure l’importance de rapidement exécuter le projet pour qu’il ne ralentisse pas l’ouverture du nouveau bâtiment. Il s’appuie sur 3 sous-critères calculés directement à partir du portefeuille projets :
- 50% de la note d’urgence : l’effet de levier du projet sur les autres (est-ce que le développement du projet facilite le développement d’autres projets ?)
- 30% de la note d’urgence : la chaîne aval (quelle est la durée cumulée du plus long chemin de successeurs ?), qui permet de calculer la durée incompressible #emph[après] réalisation du projet
- 20% de la note d’urgence : le caractère bloquant pour l’ouverture du nouveau bâtiment

Nous souhaitons normaliser la note finale sur une échelle de 1 (= peu urgent) à 5 (= très urgent), ce qui signifie une amplitude de 4. Le calcul des différents sous-critères diffère. Pour l’effet levier, nous appliquons la formule ```1 + min(4,n)```.

Pour la chaîne aval, nous appliquons ce barème :

#figure(
  [#figure(
      align(center)[#table(
        columns: (3fr, 3fr, 1fr),
        align: (center, center, center),

        [#strong[Paliers de chaîne aval]], [#strong[Mois de travail dépendants au minimum]], [#strong[Score]],

        [Aucun successeur], [0], [1],

        [1 à 2 mois], [1], [2],

        [3 à 5 mois], [3], [3],

        [6 à 8 mois], [6], [4],

        [9 mois et plus], [9], [5],
      )],
      kind: table,
    )
  ],
  caption: [
    Calcul du score de chaîne aval.
  ],
)

Pour le caractère bloquant à l’ouverture du bâtiment, la note est binaire : 1 (si non bloquant) ou 5 (si bloquant).

Un aperçu tronqué du tableau utilisé pour noter les projets sur le critère de l’urgence est disponible en annexe @matrice-urgence-projets[] Matrice de l’urgence projets. La version complète est disponible en suivant #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], dans l’onglet « Dependances ».

#hidden-heading(level: 3, numbering: none)[Rentabilité]

Ce critère est construit autour de la notion de retour sur investissement (ROI). Nous avons par conséquent estimé le coût prévisionnel projet, puis estimé combien la réalisation de ce projet rapporterait ou ferait économiser au budget de l’entreprise.

La note de rentabilité est directement calculée en fonction du ROI :

#figure(
  [#figure(
      align(center)[#table(
        columns: (3fr, 2fr, 1fr),
        align: (center, center, center),

        [#strong[Paliers de rentabilité]], [#strong[Borne inférieure du ROI]], [#strong[Score]],

        [ROI négatif], [aucune], [1],

        [ROI de 0 à 25 %], [0 %], [2],

        [ROI de 25 à 50 %], [25 %], [3],

        [ROI de 50 à 100 %], [50 %], [4],

        [ROI >= 100 %], [100 %], [5],
      )],
      kind: table,
    )
  ],
  caption: [
    Calcul du score de rentabilité.
  ],
)

Le détail du tableau de rentabilité est abordé dans la partie suivante 2.@calcul-de-la-rentabilite[] Calcul de la rentabilité.


#hidden-heading(level: 3, numbering: none)[Maîtrise des risques]

Nous avons construit la note de maîtrise des risques à partir d’une matrice de risques simplifiée, basée sur 5 critères génériques et applicables à des projets IT :
- la complexité technique
- la dépendance fournisseur / prestataire
- l’impact sur la continuité de service
- la sensibilité des données (RGPD, confidentiel)
- la maturité de l’équipe sur le sujet

Nous attribuons à chaque projet une note de 1 (= risque faible) à 3 (= risque fort) sur chaque critère de risque. Les critères de risques sont ensuite pondérés de manière égale (20% par critère). Pour finir avec une note /5 où 5 représente une maîtrise absolue (aucun risque non maîtrisé), nous avons décidé de normaliser l’indice de [1;3] vers [0;1], puis de le multiplier par 4 (étendue de l’échelle cible, qui va de 1 à 5). On soustrait ensuite le résultat à 5 :
```5 - <risque normalisé>```.

Chaque risque noté à 3 dans ce tableau étant non maîtrisé, il devra faire l’objet d’un plan de réponse qui sera détaillé dans une matrice AMDEC réalisée par projet.

La matrice des risques projets est disponible en annexe @matrice-risques-projets[] Matrice des risques projets. Elle est également disponible de manière interactive en suivant #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], dans l’onglet « Risques ».

~

Le tableau disponible sur la page suivante résume les 4 critères qui seront attribués à chaque projet de Kelbrion, et précise leur méthode de calcul.

#figure(
  [#figure(
      align(center)[#table(
        columns: (0.7fr, 2.5fr, 3.5fr, 5fr),
        align: (center, left, left, left),

        [#strong[N°]], [#strong[Critère]], [#strong[Finalité]], [#strong[Méthode / outil d'analyse]],

        [1],
        [#strong[Alignement stratégique]],
        [Contribution aux 5 \ orientations stratégiques de Kelbrion.],
        [
          #strong[Tableau d’analyse stratégique :] \
          1 note / projet et / orientation stratégique \ de l’entreprise : \
          - 0 = aucune contribution (du projet à l’axe stratégique) \
          - 1 = contribution indirecte ou marginale \
          - 2 = contribution directe et mesurable \
          - 3 = l’orientation est la raison d’être du projet
        ],

        [2],
        [#strong[Urgence \ (inclut respect \ timing et \ effet levier)]],
        [Importance du \ projet pour respecter \ l’ouverture du bâtiment dans les 12 mois.],
        [
          #strong[Tableau d’analyse de l’urgence :] \
          3 sous-critères : \
          - effet de levier (50 %) \
          - chaîne aval (30 %) \
          - bloquant pour ouverture bâtiment (20 %)
        ],

        [3],
        [#strong[Rentabilité]],
        [Rapport entre les \ ressources investies et les gains attendus.],
        [
          #strong[Tableau de calcul de rentabilité :] \
          paliers ROI : \
          - moins de 0% : 1 \
          - 0 à 25% : 2 \
          - 25 à 50% : 3 \
          - 50 à 100% : 4 \
          - 100% et plus : 5
        ],

        [4],
        [#strong[Maîtrise des \ risques]],
        [Les risques \ (incertitudes...) \ sont-ils maîtrisés ?],
        [
          #strong[Tableau d’analyse des risques :] \
          5 facteurs cotés de 1 à 3, score inversé : \
          - 1 = risque faible \
          - 2 = risque moyen \
          - 3 = risque fort
        ],
      )],
      kind: table,
    )
  ],
  caption: [
    Critères de priorisation des projets du portefeuille.
  ],
)
