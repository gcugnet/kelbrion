== Calcul de la rentabilité
<calcul-de-la-rentabilite>
// ~2 pages

Dans cette partie, nous allons détailler le calcul du critère de rentabilité. Nous venons de voir qu’il est réalisé par paliers, en fonction du ROI de chaque projet. La principale difficulté réside dans le calcul même du ROI. Nous avons dû estimer les coûts et les gains attendus.

Le coût total d’un projet correspond à la somme de 3 postes :
- la charge interne, valorisée à un TJM#footnote()[*TJM (taux journalier moyen)* : est utilisé par des sociétés de services en ingénierie informatique (ESN), mais aussi plus largement par les entrepreneurs freelance. Il s'agit du montant qui sera facturé à la société cliente pour une journée de prestation. @taux-journalier-moyen] chargé de 450 €
- la charge externe, valorisée à un TJM prestataire de 850 €
- les licences et le matériel

Nous avons ensuite estimé, projet par projet, ce que sa réalisation ferait gagner ou économiser à l’entreprise chaque année. Ces gains annuels sont valorisés sur un horizon de 3 ans (durée du plan stratégique de l’entreprise).

Le ROI se calcule alors ainsi : ```(gains sur l'horizon - cout total) / cout total```. Nous y ajoutons le délai de retour, c’est-à-dire le nombre de mois nécessaires pour que les gains couvrent le coût du projet. Cet indicateur n’entre pas dans le calcul de la note, mais il rend le classement plus lisible : un projet peut afficher un ROI positif à 3 ans tout en ne commençant réellement à rapporter qu’au bout de 2 ans.

Nous assumons la fragilité de ces estimations. Les coûts reposent sur des charges que nous avons grossièrement estimées, et les gains sur des hypothèses métier que seule la direction et le temps pourront confirmer. C’est d’ailleurs l’une des raisons pour lesquelles la rentabilité ne pèse que 20% dans la note finale, comme nous le verrons dans la partie 2.@cotation-projets[] Cotation des projets. Ces chiffres devront être ajustés au fur et à mesure de l’évolution de la maturité du portefeuille projets.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 10pt, hyphenate: false)
        #table(
          columns: (0.6fr, 2.6fr, 1.3fr, 1.2fr, 1.3fr, 1fr, 1fr, 0.8fr),
          align: (center, left, right, right, right, right, right, center),

          [#strong[Rang]],
          [#strong[Projet]],
          [#strong[Coût total]],
          [#strong[Gains / an]],
          [#strong[Gains 3 ans]],
          [#strong[ROI]],
          [#strong[Retour]],
          [#strong[Note]],

          [1], [P4 : déploiement MES], [425 500 €], [300 000 €], [900 000 €], [111,5%], [17], [5],

          [2], [P5 : déploiement PLM], [283 000 €], [180 000 €], [540 000 €], [90,8%], [18], [4],

          [3], [P7 : portail collaboratif], [95 000 €], [60 000 €], [180 000 €], [89,5%], [19], [4],

          [4], [P8 : chaîne CI/CD], [112 000 €], [70 000 €], [210 000 €], [87,5%], [19], [4],

          [5], [P1 : audit applicatif], [98 000 €], [60 000 €], [180 000 €], [83,7%], [20], [4],

          [6], [P10 : supervision], [131 500 €], [55 000 €], [165 000 €], [25,5%], [29], [3],

          [7], [P3 : architecture cible], [96 000 €], [40 000 €], [120 000 €], [25,0%], [29], [3],

          [8], [P6 : migration applicative], [187 000 €], [50 000 €], [150 000 €], [-19,8%], [45], [1],

          [9], [P9 : IAM / SSO], [180 000 €], [45 000 €], [135 000 €], [-25,0%], [48], [1],

          [10], [P2 : déploiement réseau], [349 500 €], [20 000 €], [60 000 €], [-82,8%], [210], [1],

          [],
          [#strong[Portefeuille]],
          [#strong[1 957 500 €]],
          [#strong[880 000 €]],
          [#strong[2 640 000 €]],
          [#strong[34,9%]],
          [],
          [],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Classement des projets du portefeuille par rentabilité, sur un horizon de 3 ans. Le délai de retour est exprimé en mois.
  ],
)

Le classement fait apparaître 3 familles de projets. En tête, ceux qui produisent une valeur métier directe : le MES (P4) est le seul du portefeuille à dépasser 100 % de ROI sur 3 ans, suivi du PLM (P5), du portail collaboratif (P7), de la chaîne CI/CD (P8) et de l’audit du parc applicatif (P1), tous compris entre 83 et 91 %. Viennent ensuite 2 projets au rendement modeste, la supervision applicative (P10) et l’architecture cible (P3), qui tournent autour de 25 %.

Les 3 derniers ressortent avec un ROI négatif à 3 ans : la migration des applications métier (P6), la gestion des identités (P9) et surtout le déploiement du réseau (P2), qui coûte 349 500 € pour 20 000 € de gains annuels. Il serait pourtant absurde d’en conclure qu’il faut les abandonner. Sans réseau, aucun poste et aucune application ne fonctionne dans le nouveau bâtiment, et sans gestion des identités, aucun accès conforme n’est possible au jour 1. Bien que ces projets ne produisent pas directement de valeur, ils conditionnent celle des autres.

À l’échelle du portefeuille, les 10 projets représentent 1 957 500 € de coût prévisionnel pour 2 640 000 € de gains cumulés sur 3 ans, soit un ROI global de 34,9%.

Le détail des coûts et gains estimés par projet est disponible en annexe @estimation-couts-gains-projets[] Tableau d’estimation des coûts et gains projets, ainsi que via #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien] dans l’onglet « Projets ».  Le tableau du calcul et classement de rentabilité par projet est quant à lui disponible en annexe @tableau-rentabilite-projets[]Tableau de rentabilité par projets, ou en suivant #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], dans l’onglet « Rentabilite ».
