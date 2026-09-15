== Arbitrage stratégique
<arbitrage-strategique>
// ~2,5 pages

Nous avons indiqué dans la partie 2.@critères-pondérés[] Critères pondérés que la note d’alignement stratégique serait construite à partir des 5 orientations du plan stratégique de Kelbrion. Nous allons maintenant expliquer comment nous passons de ces 5 orientations à une note sur 5.

Nous attribuons à chaque projet, et pour chacune des 5 orientations, une note de 0 à 3 :
- 0 : aucune contribution
- 1 : contribution indirecte ou marginale
- 2 : contribution directe et mesurable
- 3 : l’orientation est la raison d’être du projet

Ce que le projet permet aux autres projets n’est pas considéré ici. Le réseau du bâtiment conditionne par exemple la totalité des applications du site, mais il ne réduit pas lui-même les coûts du parc applicatif : nous ne lui attribuons donc aucun point sur cette orientation. Si l’effet levier existe bel et bien, il est valorisé ailleurs, dans le critère d’urgence.

Les 5 orientations sont pondérées de manière égale, à hauteur de 20% chacune. Nous préférons assumer cette égalité plutôt que d’introduire une hiérarchie sans avoir consulté la direction sur ce point au préalable. Ce choix reste un paramètre modifiable : on pourrait par exemple faire peser davantage le critère d’amélioration de la production sur les autres.

Le total pondéré s’étale théoriquement de 0 à 15. Nous ne le ramenons pas directement sur 5, car cela reviendrait à exiger d’un projet qu’il serve pleinement les 5 orientations pour être considéré comme aligné, ce qui n’arrive jamais. Nous plafonnons donc ce total à 9, c’est-à-dire 3 orientations servies pleinement, et nous appliquons la formule ```1 + 4 * min(total, 9) / 9```. Un projet qui atteint 9 ou plus obtient un score normalisé de 5/5, un projet à 0 obtient un score normalisé de 1/5.

Dans le tableau ci-dessous, les 5 colonnes centrales reprennent dans l’ordre les orientations stratégiques Kelbrion : capacité de production et délais client, innovation et mise sur le marché, sécurité et conformité, rationalisation et maîtrise des coûts, productivité et expérience numérique.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 9.5pt, hyphenate: false)
        #table(
          columns: (0.7fr, 3fr, 1.5fr, 1.5fr, 1.3fr, 1fr, 1.6fr, 0.9fr, 0.9fr),
          align: (center, left, center, center, center, center, center, center, center),

          [#strong[Code]],
          [#strong[Intitulé]],
          [#strong[Production]],
          [#strong[Innovation]],
          [#strong[Sécurité]],
          [#strong[Coûts]],
          [#strong[Productivité]],
          [#strong[Total]],
          [#strong[Note]],

          [P1], [Audit applicatif], [0], [0], [1], [3], [0], [4], [2,8],

          [P2], [Déploiement réseau], [0], [0], [2], [0], [1], [3], [2,3],

          [P3], [Architecture cible], [0], [1], [1], [3], [0], [5], [3,2],

          [P4], [Déploiement MES], [3], [0], [2], [0], [1], [6], [3,7],

          [P5], [Déploiement PLM], [1], [3], [0], [1], [2], [7], [4,1],

          [P6], [Migration applicative], [1], [0], [1], [2], [1], [5], [3,2],

          [P7], [Portail collaboratif], [0], [0], [0], [0], [3], [3], [2,3],

          [P8], [Chaîne CI/CD], [0], [2], [1], [1], [2], [6], [3,7],

          [P9], [IAM / SSO], [0], [0], [3], [1], [2], [6], [3,7],

          [P10], [Supervision], [1], [0], [3], [1], [0], [5], [3,2],

          [],
          [#strong[Projets contributeurs]],
          [#strong[4]],
          [#strong[3]],
          [#strong[8]],
          [#strong[7]],
          [#strong[7]],
          [],
          [],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Contribution propre de chaque projet aux 5 orientations stratégiques de Kelbrion. Le total est exprimé sur 15, la note sur 5.
  ],
)

Le PLM (P5) obtient la meilleure note du portefeuille, avec 4,1 sur 5. Il est la raison d’être de l’orientation consacrée à l’innovation et au délai de mise sur le marché, puisqu’il porte la documentation technique, les nomenclatures et la gestion des évolutions de conception, et il contribue par ailleurs à la productivité des équipes d’ingénierie et de R&D.

Le MES (P4) et la gestion des identités (P9) suivent à 3,7. Le premier répond à l’augmentetation de la capacité de production et réduction des délais client. Le second répond à l’objectif de sécurité, conformité et résilience. La chaîne CI/CD (P8) obtient lui aussi 3,7/5, en contribuant de manière diffuse à 4 orientations sur 5.

À l’inverse, le réseau (P2) et le portail collaboratif (P7) ferment la marche à 2,3. Bien que P2 soit le prérequis technique de tout le reste, sa contribution directe au plan stratégique reste modeste. Sa note est le résultat de notre règle de ne prendre en compte que les contributions directes aux objectifs, et nous l’assumons. La valeur de P2 sera révélée par le critère d’urgence, où il obtient la note maximale. Concernant P7, il s’agit d’un point d’entrée unique vers les services numériques, les documents partagés et les indicateurs d’activité. Il répond donc uniquement à l’objectif de la productivité et de l’expérience numérique.

La lecture par colonne est au moins aussi instructive que la lecture par ligne, et c’est elle qui indique l’arbitrage. 8 projets sur 10 contribuent à la sécurité, à la conformité et à la résilience du SI, et 7 à la rationalisation du parc applicatif et à la maîtrise des coûts informatiques. En revanche, 4 projets seulement contribuent à la capacité de production et aux délais client, et 3 à l’innovation.

Le tableau d’alignement stratégique est disponible en annexe @tableau-alignement-strategique[] Tableau reflétant l’alignement stratégique par projet, et de manière interactive en suivant #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], dans l’onglet « Alignement ». Cette note pèse 30% dans le score de priorité, dont nous détaillons le calcul dans la partie suivante 2.@cotation-projets[] Cotation des projets.
