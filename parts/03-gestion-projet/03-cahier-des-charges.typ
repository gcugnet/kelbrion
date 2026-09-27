#import "../../helpers.typ": hidden-heading

== Cahier des charges fonctionnel
// ~1 page

Le cahier des charges fonctionnel décrit en détail les fonctionnalités du MES et de son intégration.

Le document complet est consultable en suivant #link("https://docs.google.com/document/d/1_5XFqgkKJ0YyGJbmMH3VkhOW8pIuRGYb/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien].

#hidden-heading(level: 3, numbering: none)[Utilisateurs]

Le MES sera utilisé par des profils variés :
- 3 exploitants de la DSI en charge des sauvegardes et de la supervision (garants du bon fonctionnement)
- 2 ordonnanceurs, qui planifient les ordres de fabrication et gèrent la nomenclature des produits
- 6 chefs d’équipe qui lancent les ordres de fabrication et suivent les cadences
- 40 opérateurs répartis en 3 équipes (3x8), qui suivent les fabrications, déclarent les quantités, les rebuts, et gèrent le déplacement des lots produits
- 3 personnes de la qualité qui effectuent des contrôles sur la conformité et s’assurent de la bonne traçabilité
- 4 techniciens de maintenance qui consultent les erreurs et prennent les actions nécessaires
- le référent ERP de Kelbrion qui gère l’interfaçage avec l’ERP et établit les nomenclatures conjointement avec les ordonnanceurs

Les utilisateurs les plus nombreux sont les opérateurs. Ce sont également eux qui ont le moins de temps à consacrer à l’outil. Ils ont été consultés pour la partie liée à l’ergonomie des interfaces sur les terminaux mobiles. Les chefs d’équipes et ordonnanceurs ont émis leurs souhaits sur l’interface du logiciel via ordinateur, et dans l’ERP.

#hidden-heading(level: 3, numbering: none)[Exigences fonctionnelles]

Les exigences fonctionnelles ont été recueillies lors d’ateliers organisés avec chaque métier, en janvier 2027. Elles sont rédigées sous forme de user stories pour refléter l’expérience réelle d’un utilisateur : « En tant qu’opérateur, je veux ... ». @user-stories Elles sont ensuite priorisées selon la méthode MoSCoW : Must (doit absolument être implémenté), Should (devrait être implémenté), Could (pourrait être implémenté) et Won’t (ne fera pas partie des fonctionnalités). @methode-moscow

12 exigences ont finalement été retenues : 7 Must, 3 Should, 1 Could et 1 Won’t. Chacune possède un identifiant, qui sera repris dans le PV de recette. Le tableau ci-dessous en présente un extrait.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 9.5pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (0.8fr, 2.6fr, 0.9fr, 2.8fr),
          align: (center + horizon, left + horizon, center + horizon, left + horizon),

          [#strong[ID]], [#strong[Besoin]], [#strong[Priorité]], [#strong[Critère d’acceptation]],

          [EF-01],
          [Recevoir automatiquement les OF #footnote()[*OF (Ordre de fabrication)* : document essentiel pour organiser et piloter la production industrielle. Il précise les quantités à produire, les opérations à réaliser, les ressources mobilisées et les délais de fabrication. @ordre-de-fabrication] créés dans l’ERP],
          [Must],
          [Un OF libéré apparaît dans le MES en moins de 15 minutes, avec toutes ses données],

          [EF-03],
          [Lancer, suspendre et clôturer une opération depuis le terminal de l’opérateur],
          [Must],
          [Chaque changement d’état est horodaté et visible par le chef d’équipe en moins d’une minute],

          [EF-05],
          [Tracer les lots et numéros de série de chaque unité produite],
          [Must],
          [La généalogie complète d’un numéro de série s’affiche en moins de 10 secondes],

          [EF-08],
          [Remonter les déclarations de production dans l’ERP],
          [Must],
          [Une déclaration validée est comptabilisée dans l’ERP en moins de 15 minutes ; les rejets sont listés et rejouables],

          [EF-09],
          [Suivre le TRS #footnote()[*TRS (taux de rendement synthétique)* : indicateur de productivité qui rapporte le temps passé à produire des pièces conformes au temps d’ouverture du poste, en combinant la disponibilité, la performance et la qualité. @taux-rendement-synthetique] et les arrêts de chaque poste en temps réel],
          [Should],
          [Le TRS de l’équipe précédente est disponible au début de l’équipe suivante],

          [EF-11],
          [Alerter la maintenance en cas d’arrêts machine répétés],
          [Could],
          [Un courriel est envoyé au troisième arrêt du même motif en 24 heures],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Extrait des exigences fonctionnelles du cahier des charges du projet P4.
  ],
)

On retrouve dans les exigences Must le cœur du fonctionnement décrit dans la partie 3.@presentation-projet[] Présentation du projet : l’ERP transmet les ordres de fabrication au MES, qui les planifie puis les relaie aux opérateurs et aux machines outils. Ensuite, les machines ou opérateurs renvoient à l’ERP les quantités produites et les consommations. La seule exigence classée Won’t concerne le déploiement sur les sites existants, ce qui était déjà indiqué dans le périmètre exclu (partie Cadrage).

#hidden-heading(level: 3, numbering: none)[Exigences non fonctionnelles]

Le cahier des charges fixe également 7 exigences non fonctionnelles, qui portent sur la manière de réaliser le service (qualité) plutôt que sur les possibilités qu’offre l’outil. Le tableau ci-dessous récapitule ces exigences.

On y retrouve notamment des chiffres concernant la performance, la disponibilité ou encore la sécurité. Ces indicateurs seront réutilisés pour vérifier la bonne réalisation du projet dans le temps (KPI).

#figure(
  [
    #table(
      columns: (1.6fr, 4.4fr),
      inset: 8pt,
      align: (left, left),
      stroke: 0.5pt + gray,
      table.header(
        table.cell[
          #text(weight: "bold")[Critère]
        ],
        table.cell[
          #text(weight: "bold")[Exigence]
        ],
      ),
      [*Performance*], [Les écrans opérateurs s’affichent en moins de 2 secondes],
      [*Disponibilité*], [99,5 % sur la plage de production (3×8, six jours sur sept)],

      [*Sécurité*],
      [Conformité à la politique de sécurité du groupe : authentification unique (quand projet déployé), réseau atelier dédié, journalisation des accès.],

      [*Protection \ des données*],
      [Indicateurs pseudonymisés et politique de rétention limitée à 13 mois pour les données des opérateurs.],

      [*Traçabilité*], [Traçabilité des lots conservée dix ans, sans modification possible],
      [*Ergonomie*], [Terminaux tactiles utilisables avec des gants, parcours opérateur limité à 3 écrans au maximum.],
      [*Exploitabilité*],
      [Supervision (intégrée à l’outil global prévu par le projet P10), sauvegarde quotidienne, remise en service en moins de 4 heures.],
    )],
  caption: [
    Exigences non fonctionnelles du projet P4 « Déploiement d’un MES ».
  ],
)

#hidden-heading(level: 3, numbering: none)[Interfaces et reprise des données]

Il est prévu que les échanges entre l’ERP et le MES aient lieu toutes les 15 minutes, de façon bidirectionnelle : les OF sont transmis de l’ERP vers le MES, et les déclarations de production du MES vers l’ERP. La nomenclature des produits est quant à elle synchronisée de nuit, lorsqu’aucune modification n’a lieu sur l’ERP.

La nomenclature est déjà présente dans l’ERP, il faudra cependant la synchroniser avec le MES lors du paramétrage de l’outil, et vérifier la concordance des deux systèmes. Cette reprise fera l’objet d’une validation (jalon G3).

#hidden-heading(level: 3, numbering: none)[Critères d’acceptation globaux]

Pour finir, le cahier des charges définit des critères d’acceptation, utilisés pour valider la pleine livraison du MES. On retrouve dans ces critères le fait que toutes les exigences Must doivent être implémentées dans l’outil, et qu’au moins 90 % des autres exigences à implémenter (Should et Could) sont également présentes dans l’outil.

Les exigences non fonctionnelles feront l’objet d’une vérification particulière en recette technique, puis d’un suivi régulier dans le temps.

Toute la documentation nécessaire à l’outil, ainsi que les supports de formation devront également être livrés, en parallèle du déploiement de l’outil, pour valider le projet.

Ces critères seront repris dans le plan de recette et conditionneront la signature du PV nécessaire au paiement final du fournisseur.
