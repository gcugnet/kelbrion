#import "../../helpers.typ": hidden-heading

== Gestion des risques
<gestion-risques>
// ~1 page

Dans la partie 2, nous avons évalué la maîtrise des risques de chaque projet à l’aide d’une matrice simplifiée, en précisant que chaque risque noté à 3 devrait faire l’objet d’une évaluation plus poussée, et surtout d’une proposition de réponse, via une matrice AMDEC par projet. Concernant la maîtrise des risques, projet P4 a obtenu la note de 1,8/5. Il s’agit du projet avec les risques les moins maîtrisés du portefeuille, à égalité avec la migration des applications métiers. Cela justifie un suivi particulièrement poussé.

#hidden-heading(level: 3, numbering: none)[Méthode de cotation]

Nous utilisons la méthode AMDEC (analyse des modes de défaillance, de leurs effets et de leur criticité), largement répandue dans l’industrie, pour évaluer les risques. Cette méthode évalue non seulement la probabilité et l’impact de chaque risque identifié, mais également la capacité de l’organisation à le détecter avant qu’il ne survienne.

Ce troisième critère vient du fait que plus un risque est découvert tard, plus il a le temps d’avoir un impact fort, car étiré dans le temps, et plus il sera difficile de palier à ses conséquences réelles.

Chaque risque est évalué de 1 à 4 selon les 3 critères que nous venons d’évoquer :
- la gravité = l’impact sur le projet si le risque survient
- la fréquence = sa probabilité de survenir
- la non-détection = la difficulté à le repérer avant qu’il ne survienne

#hidden-heading(level: 4, numbering: none)[Échelle de gravité]

L’échelle de gravité est (la note de 1 à 4) est corrélée aux seuils d’alerte du plan de management :
- 1 = faible gravité, impact absorbé dans les tolérances (par exemple une journée de retard sur une tâche hors chemin critique)
- 2 = gravité modérée, l’impact équivaut à un seuil d’alerte, soit une semaine de retard sur un jalon ou 5 % de surcoût
- 3 = gravité majeure, les tolérances sont dépassées et le COPIL doit être saisi
- 4 = critique, compromet l’ouverture du site à temps, la continuité de service ou la conformité

#hidden-heading(level: 4, numbering: none)[Échelle de fréquence]

Le critère de fréquence note une probabilité de survenance du risque : rare (moins de 10 %), possible (10 à 30 %, le risque s’est déjà produit par le passé sur des projets similaires), probable (30 à 60 %, toutes les conditions sont favorables au risque), et très probable (plus de 60 %, des signes avant-coureurs existent déjà).

#hidden-heading(level: 4, numbering: none)[Échelle de non-détection]

Nous définissions la non-détection d’après les mécanismes en place qui pourraient permettre de détecter le risque :
- 1 = les tests automatisés
- 2 = la revue COPIL hebdomadaire
- 3 = une réunion de fin de jalon
- 4 = aucun des mécanismes prévus ne garantiraient une détection du risque avant qu’il ne survienne en production

#hidden-heading(level: 4, numbering: none)[Criticité]

La criticité d’un risque est calculée en réalisant le produit des 3 notes qui lui ont été attribuées : `gravité x fréquence x non-détection = criticité`.

Le score de criticité maximal est donc `4 x 4 x 4 = 64`.à chaque le produit des 3 notes, et varie donc de 1 à 64. De cette manière, une note très basse sur un seul critère suffit à fortement baisser la criticité d’un risque, alors que 3 notes moyennes indiquent une criticité importante.

Nous avons ensuite séparé les résultats en 3 catégories, en fonction du score de criticité calculé :
- score <= 9 : risque faible, surveillance à chaque jalon
- 9 < score <= 26 : risque modérée, nécessite de formuler une réponse + un suivi hebdomadaire
- score > 26 : risque fort, nécessite de formuler un plan de réponse et un suivi accru par les équipes et le COPIL

Le risque ayant été identifié comme le plus critique sur le projet est la complexité de l’interfaçage entre le MES et l’ERP (R01). Nous lui avons attribué un score de 4 en ce qui concerne gravité, car des données incohérentes entre les 2 systèmes pourrait causer des problèmes dans la chaîne de production, donc impacter directement la création de valeur de l’entreprise, en même tempps que sa réputation (si elle venait à ne pas honorer ses commandes en temps et en heure, ou que des produits étaient défectueux du fait de mauvaises valeurs transmises aux machines). Nous lui avons attribué une note de 3 en ce qui concerne la fréquence, car l’ERP du groupe est préexistant et ancien, et que l’éditeur ne fournit pas une documentation claire sur les API. Pour finir, nous lui avons attribué un score de 3 en ce qui concerne la non-détection, car il est difficile de tester tous les scénarios de communication entre les systèmes, et que les tests automatisés n’interviendront dans tous les cas qu’à la fin du jalon G3, et laisseront peu de temps pour apporter d’éventuelles corrections. Sa criticité atteint donc un score cumulé de `4 x 3 x 3 = 36`, ce qui correspond à un risque « fort ».

En parallèle, la comparaison des risques « Retard sur le réseau du bâtiment » R06 et « Segmentation réseau insuffisante » R11 montre l’intérêt du critère de non-détection. Ces deux risques ont une gravité maximale (4) et une fréquence moyenne (2), mais un retard du réseau serait visible immédiatement en amont même du projet P4 (P2 étant une dépendance) d’où uu critère de non-détection évalué à 1, et une criticité totale qui plafonne alors à 8. Une segmentation réseau insuffisante entre les machines de l’atelier et le reste du SI peut en revanche rester invisible jusqu’à une attaque, à moins d’un audit de sécurité assez poussé. Nous avons donc attribué un score de 3 au critère de non-détection sur le risque R11, ce qui augmente sa criticité à 24 (risque moyen).

#hidden-heading(level: 3, numbering: none)[Registre des risques]

Au total, 12 risques ont été identifiés. Le tableau suivant présente leur cotation initiale, la stratégie de réponse retenue, le responsable de sa mise en œuvre, et la criticité résiduelle une fois les actions menées.

#let vert = rgb("#C6E0B4")
#let jaune = rgb("#FFD966")
#let rouge = rgb("#FF9B9B")

#let crit(g, f, d) = {
  let c = g * f * d
  let color = if c >= 27 { rouge } else if c >= 9 { jaune } else { vert }
  table.cell(fill: color, [#strong[#c]])
}

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 9pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (0.6fr, 3.1fr, 0.35fr, 0.35fr, 0.35fr, 0.9fr, 1fr, 1.4fr, 1fr),
          align: (
            center + horizon,
            left + horizon,
            center + horizon,
            center + horizon,
            center + horizon,
            center + horizon,
            left + horizon,
            left + horizon,
            center + horizon,
          ),

          [#strong[ID]],
          [#strong[Risque]],
          [#strong[G]],
          [#strong[F]],
          [#strong[D]],
          [#strong[Criticité]],
          [#strong[Stratégie]],
          [#strong[Responsable]],
          [#strong[Résiduelle]],

          [R01],
          [Complexité de l’interface MES-ERP],
          [4],
          [3],
          [3],
          crit(4, 3, 3),
          [Réduire],
          [Chef de projet DSI],
          crit(3, 2, 2),

          [R02],
          [Retard de l’éditeur sur ses livrables],
          [3],
          [3],
          [2],
          crit(3, 3, 2),
          [Transférer],
          [Chef de projet DSI],
          crit(3, 2, 1),

          [R03],
          [Montée en compétence insuffisante de la DSI sur le MES],
          [3],
          [4],
          [2],
          crit(3, 4, 2),
          [Réduire],
          [Chef de projet DSI],
          crit(2, 3, 2),

          [R04],
          [Qualité insuffisante des données reprises],
          [3],
          [3],
          [3],
          crit(3, 3, 3),
          [Réduire],
          [Développeurs],
          crit(3, 2, 2),

          [R05],
          [Saturation des développeurs (P4 à P7 en parallèle)],
          [4],
          [4],
          [2],
          crit(4, 4, 2),
          [Réduire],
          [Responsable PMO],
          crit(3, 2, 2),

          [R06],
          [Retard du réseau (P2) empêchant de déployer les terminaux],
          [4],
          [2],
          [1],
          crit(4, 2, 1),
          [Accepter],
          [Responsable PMO],
          crit(4, 1, 1),

          [R07],
          [Données personnelles des opérateurs traitées sans cadre (RGPD)],
          [3],
          [3],
          [2],
          crit(3, 3, 2),
          [Réduire],
          [Responsable qualité],
          crit(2, 2, 2),

          [R08],
          [Performance insuffisante des remontées d’atelier],
          [3],
          [2],
          [2],
          crit(3, 2, 2),
          [Réduire],
          [DevOps],
          crit(2, 2, 1),

          [R09],
          [Faible adhésion des opérateurs et chefs d’équipe],
          [3],
          [3],
          [2],
          crit(3, 3, 2),
          [Réduire],
          [Responsable de l’atelier],
          crit(2, 2, 2),

          [R10],
          [Interruption de l’ERP lors de la bascule des interfaces],
          [4],
          [2],
          [2],
          crit(4, 2, 2),
          [Éviter],
          [Référent ERP],
          crit(4, 1, 1),

          [R11],
          [Cloisonnement insuffisant entre l’atelier et le SI],
          [4],
          [2],
          [3],
          crit(4, 2, 3),
          [Réduire],
          [Administrateurs systèmes],
          crit(4, 1, 2),

          [R12],
          [Dépassement du budget par des prestations de l’éditeur],
          [2],
          [3],
          [2],
          crit(2, 3, 2),
          [Accepter],
          [Chef de projet DSI],
          crit(2, 2, 2),
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Registre des risques du projet P4. Les criticités sont colorées selon leur niveau : vert pour faible, jaune pour moyen, rouge pour fort.
  ],
)

#hidden-heading(level: 3, numbering: none)[Plans de réponse]

Pour chaque risque moyen ou fort, une stratégie de réponse est choisie parmi 4 possibilités.

#hidden-heading(level: 4, numbering: none)[Réduction de la probabilité ou de l’impact]

Dans la majorité des cas , la réponse proposée vise à éduire la probabilité ou l’impact du risque. Exemple pour R01 : un prototype d’interface est testé sur un vrai OF dès la conception. Le référent ERP est effectue des vérifications 2 jours par semaine Des tests d’intégration ont lieu chaque semaine.

#hidden-heading(level: 4, numbering: none)[Changer la manière de faire]

Il est parfois possible d’éviter un risque en réalisant une tâche d’une autre manière que celle initialement prévue. Exemple pour R10 : la bascule des interfaces se fait le week-end, hors production, plutôt qu’en semaine. On peut également prévoir une sauvegarde des messages en attente, avec rollback possible.

#hidden-heading(level: 4, numbering: none)[Transfert de la responsabilité]

Une autre stratégie vise à transférer la responsabilité d’une misison à un tiers, en incluant des pénalités dans le contrat en cas de survenance du risque (ex : pénalités de retard pour le prestataire, applicables au R2).

#hidden-heading(level: 4, numbering: none)[Assumer le risque]

Il est également possible d’accepter et assumer le risque lorsqu’aucun contournement moins coûteux ne permet de le réduire. C’est notamment le cas du R06 : il est possible de se rabattre sur le réseau du site principal pour vérifier les fonctionnalités du MES et procéder à la recette. Cela peut aussi se traduire par une provision pour risque.

La saturation des développeurs (R05) mérite une attention particulière. Avec un profil chargé à 134 % de sa capacité, il serait irresponsable de ne prévoir aucun renfort. Le plan de réponse prévoit un renfort de 20 jours homme par un prestataire, ou à défaut le report du projet P7 (le portail collaboratif). Le responsable PMO abritrera cette décision qui peut concerner l’évolution du portefeuille.

Après le plan d’action proposé, plus aucun risque n’atteint le niveau élevé (> 26). 4 risques demeurent moyens (R01, R03, R04 et R05). Ils seront suivis chaque semaine. Si l’un d’eux survient, il fera l’objet d’une fiche de retour d’expérience. Le tableau de bord permettra également de suivre le nombre de risques forts sans plan de réponse, car il s’agit d’un seuil d’alerte d’après la définition du plan de management.

La matrice des risques interactive du projet P4 est disponible en suivant #link("https://docs.google.com/spreadsheets/d/1-B1fuuVJ8ee-6Gae759u-DuyaIQe-hqn/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien].
