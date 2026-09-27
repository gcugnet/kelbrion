#import "../../helpers.typ": hidden-heading

== Plan de recette
<plan-recette>
// ~2 pages

La recette doit permettre de vérifie que le MES répond bien au cahier des charges, avant son utilisation en production. Elle bloque le franchissement du dernier jalon du projet (mise en service approuvée par le Directeur de la production) ainsi que le paiement des 30 % restants au fournisseur.

La phase de recette se déroule en 2 temps, pour couvrir tous les éléments du cahier des charges :
1. une recette technique pour vérifier les exigences non fonctionnelles
2. une recette fonctionnelle, avec les futurs utilisateurs

#hidden-heading(level: 3, numbering: none)[Organisation]

Le cahier de recette compte 62 cas de test : 14 cas techniques et 48 cas fonctionnels. Chaque test est relié à une exigence du cahier des charges. Les rôles sont répartis de la manière suivante :
- l’ingénieur DevOps pilote la recette technique, avec les aministrateurs systèmes
- le responsable de l’atelier pilote la recette fonctionnelle, avec l’ordonnanceur, le responsable qualité, deux chefs d’équipe et le référent ERP du groupe
- le fournisseur du MES et les développeurs de la DSI corrigent les anomalies et livrent les correctifs
- le chef de projet DSI coordonne l’ensemble et consigne dans un l’exécution des tests dans un journal
- le Directeur de la production prend connaissance des résultats et signe le PV de recette

Les tests sont menés sur un environnement calqué sur la production (mais bien séparé). Il est constitué des données de l’ERP et des fichiers du service production.

Le planning prévoit la recette technique du 31/05 au 09/06/2027, la formation des opérateurs du 07/06 au 18/06, puis la recette fonctionnelle du 14/06 au 23/06. Les derniers jours, du 21/06 au 25/06, sont réservés à la correction des anomalies et à la levée des réserves, avant le jalon G4 (25/06) et la bascule en production le 28/06.

#hidden-heading(level: 3, numbering: none)[Recette technique]

La recette technique vérifie les 7 exigences non fonctionnelles du cahier des charges, au moyen de 14 cas de test (CT-T01 à CT-T14). La charge de l’atelier est simulée par autant de terminaux mobiles que pourra en accueillir l’atelier, pour mesurer les temps de réponse et le comportement du réseau. Elle comprend aussi une revue de sécurité, un test de restauration (sauvegardes), et un test de bascule complet, qui inclut le retour arrière des interfaces avec l’ERP. Aucune mise en production n’est autorisée tant que le retour en arrière n’a pas été validé. La recette technique donne lieu à un PV distinct, préalable à la recette fonctionnelle.

Le tableau suivant présente le plan des tests techniques. Aucune exigence ne peut être écartée pour que la recette soit validée.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 10pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (0.8fr, 2fr, 1fr, 3.9fr),
          align: (center + horizon, left + horizon, center + horizon, left + horizon),
          inset: 4pt,

          [#strong[ID]], [#strong[Exigence]], [#strong[Cas de test]], [#strong[Résultat attendu]],

          [ENF-01],
          [Performance],
          [CT-T01 à T03],
          [Écran opérateur en moins de 2 secondes et échange avec l’ERP en moins de 15 minutes, avec 45 terminaux simulés],

          [ENF-02],
          [Disponibilité et continuité],
          [CT-T04 et T05],
          [Mode hors ligne des terminaux pendant 30 minutes ; bascule et retour arrière des interfaces réussis],

          [ENF-03],
          [Sécurité et habilitations],
          [CT-T06 et T07],
          [Revue de sécurité du RSSI et test d’intrusion interne sans faille critique],

          [ENF-04],
          [Protection des données],
          [CT-T08],
          [Indicateurs pseudonymisés et durée de conservation de 13 mois appliquée],

          [ENF-05], [Traçabilité], [CT-T09 et T10], [Export complet d’un lot ; toute tentative de modification rejetée],
          [ENF-06],
          [Ergonomie],
          [CT-T11 et T12],
          [Parcours opérateur en 3 écrans au maximum, utilisable avec des gants (test avec 6 opérateurs)],

          [ENF-07],
          [Exploitabilité],
          [CT-T13 et T14],
          [Restauration en moins de 4 heures ; supervision (P10) opérationnelle],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Plan des tests techniques de la recette du projet P4.
  ],
)

#hidden-heading(level: 3, numbering: none)[Recette fonctionnelle]

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 8.5pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (0.8fr, 2.1fr, 1fr, 3.1fr, 0.8fr),
          align: (center + horizon, left + horizon, center + horizon, left + horizon, center + horizon),
          inset: 4pt,

          [#strong[ID]], [#strong[Exigence]], [#strong[Cas de test]], [#strong[Résultat attendu]], [#strong[Priorité]],

          [EF-01],
          [Réception des OF],
          [CT-01 à 03],
          [Un OF libéré apparaît dans le MES en moins de 15 minutes, avec toutes ses données],
          [Must],

          [EF-02],
          [Planification par poste],
          [CT-04 à 08],
          [Le plan d’un poste se réordonne et la date de fin se recalcule],
          [Must],

          [EF-03],
          [Suivi des opérations],
          [CT-09 à 13],
          [Chaque changement d’état est horodaté et visible en moins d’une minute],
          [Must],

          [EF-04],
          [Déclaration des quantités],
          [CT-14 à 17],
          [L’avancement de l’OF et l’en-cours du poste suivant sont mis à jour],
          [Must],

          [EF-05],
          [Traçabilité des lots],
          [CT-18 à 23],
          [La généalogie d’un numéro de série s’affiche en moins de 10 secondes],
          [Must],

          [EF-06], [Contrôles qualité], [CT-24 à 28], [Un contrôle non conforme bloque l’opération suivante], [Must],
          [EF-07],
          [Instructions au poste],
          [CT-29 à 31],
          [Seule la version approuvée de l’instruction est affichée],
          [Should],

          [EF-08],
          [Déclarations vers l’ERP],
          [CT-32 à 38],
          [Déclaration comptabilisée dans l’ERP en moins de 15 minutes ; rejets rejouables],
          [Must],

          [EF-09],
          [Suivi du TRS],
          [CT-39 à 42],
          [Le TRS de l’équipe précédente est disponible au début de l’équipe suivante],
          [Should],

          [EF-10],
          [Identification par badge],
          [CT-43 à 46],
          [Un opérateur non habilité ne peut pas lancer une opération],
          [Should],

          [EF-11],
          [Alertes de maintenance],
          [CT-47 et 48],
          [Une alerte est envoyée au troisième arrêt du même motif en 24 heures],
          [Could],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Plan des tests fonctionnels de la recette du projet P4.
  ],
)

La recette fonctionnelle vérifie les exigences fonctionnelles du cahier des charges, au moyen de 48 cas de test métiers. L’exigence EF-12 (classée Won’t) est hors périmètre et donc non incluse. Les tests sont réalisés sur les 45 terminaux de l’atelier, dans le nouveau site, par des « key users » sélectionnés parmi les futurs utilisateurs. Les scénarios suivent le workflow complet : de la libération d’un ordre de fabrication, depuis l’ERP jusqu’à sa déclaration de production, qui revient à l’ERP.

Le tableau précédent présente le plan des tests fonctionnels, avec la priorité de chaque exigence. Comme pour la recette technique, les résultats obtenus feront l’objet d’un PV dédié, qui sera ensuite repris dans le PV de recette.


#hidden-heading(level: 3, numbering: none)[Gestion des anomalies]

Chaque anomalie constatée est enregistrée dans l’outil de suivi de la DSI, puis classée selon sa gravité.

Le plan de management fixe les délais de correction :
- avant la mise en service pour une anomalie mineure
- 2 jours pour une anomalie bloquante
- 5 jours pour une anomalie majeure

Chaque correctif livré par l’éditeur est accompagné d’un test de non-régression sur les cas de test déjà validés.

La recette est également suivie dans le tableau de bord du projet : le nombre d’anomalies bloquantes est relevé chaque semaine. La part des fonctionnalités « Must » déjà testés et validées alimente l’indicateur « Spécifications implémentées ».

#hidden-heading(level: 3, numbering: none)[Critères de prononcé]

La recette est validée lorsque les critères d’acceptation du cahier des charges sont satisfaits :
- toutes les exigences « Must » conformes
- aucune réserve bloquante n’est ouverte
- au moins 90 % des cas de test « Should » et « Could » sont conformes
- le PV de recette techniques est lui aussi validé (exigences non fonnctionnelles)
- la documentation d’exploitation ainsi et les supports de formation sont livrés

Trois décisions sont alors possibles :
- une recette prononcée sans réserve, qui permet de franchir le jalon G4 et de payer le fournisseur
- une recette prononcée avec réserves, à lever impérativement avant la mise en production, et qui décale le paiement du fournisseur au plus tôt à la levée de toutes les réserves
- un refus, qui entraîne une nouvelle session de recette.

#hidden-heading(level: 3, numbering: none)[Mise à l’épreuve par les scénarios]

Les scénarios du tableau de bord mettent ce plan à l’épreuve.

Dans les scénarios « favorable » et « intermédiaire », la recette est prononcée à la date prévue, avec au plus des réserves mineures (97 % des cas « Must » conformes dans le scénario intermédiaire).

Dans le scénario défavorable, la recette technique est resserrée et les tests de charge supprimés pour tenir la date : trois anomalies bloquantes apparaissent alors en recette fonctionnelle, et le jalon G4 est prononcé avec réserves et seulement 93 % des cas « Must » conformes.

Le scénario de tensions est encore plus parlant : la bascule des interfaces échoue le 09/07, et elle ne peut être annulée proprement en l’absence de procédure de retour arrière. C’est pour cette raison nous demandons un plan de retour en arrière fonctionnel avant toute bascule. Il faut retenir que la recette technique ne doit jamais servir de variable d’ajustement du planning.
