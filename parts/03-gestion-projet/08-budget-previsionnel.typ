#import "../../helpers.typ": hidden-heading

== Budget prévisionnel
// ~0,5 page

Le budget prévisionnel est le pendant financier du planning. Il détaille les dépenses du projet, les compare à l’enveloppe allouée, et permet de suivre l’absence ou la présence de dérives dans le temps. C’est un document crucial pour repérer les fuites financières et prendre des décisions rapidement, puisqu’il est revu chaque semaine, lors de la revue du vendredi.

#hidden-heading(level: 3, numbering: none)[Hypothèses]

Nous reprenons les hypothèses déjà utilisées pour le calcul de rentabilité du portefeuille : les ressources internes sont valorisées à un TJM moyen de 450 € (charges comprises), et les prestataires à 850 €.

Une provision pour risques de 5 % du coût prévisionnel est ajoutée.

Comme nous l’avons évoqué dans le plan de management, nous ne comptabilisons pas ici le temps de travail des référents métiers, qui dépendent de la direction de la production (le commanditaire). Il s’agit d’une limite de notre calcul des coûts, mais nous ne voulons volontairement pas charger le budget de la DSI avec ces salaires.

#hidden-heading(level: 3, numbering: none)[Répartition par poste]

Le tableau ci-dessous propose une répartition par poste, qui est détaillée dans le budget interactif disponible via #link("https://docs.google.com/spreadsheets/d/1HMJTLISfOsUEBWV0AjLmMulTh9DcOsT1/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien].

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 11pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (1.3fr, 3.6fr, 1.1fr, 0.7fr),
          align: (left + horizon, left + horizon, right + horizon, right + horizon),

          [#strong[Poste]], [#strong[Détail]], [#strong[Estimation]], [#strong[Part]],

          [Ressources internes],
          [
            - CP DSI (40 j.h) \
            - développeurs (150 j.h) \
            - administrateurs systèmes et réseaux (30 j.h)
            - ingénieur DevOps (30 j.h) \
              \= 250 jours homme à 450 €
          ],
          [112 500 €],
          [26,4 %],

          [Prestataires],
          [
            - paramétrage et intégration avec l’ERP
              \ = 120 jours homme à 850 €
          ],
          [102 000 €],
          [24,0 %],

          [Licences et logiciels],
          [
            - 45 licences MES (30 terminaux mobiles et 15 postes fixes) \
            - maintenance de la première année incluse
          ],
          [110 000 €],
          [25,9 %],

          [Matériel],
          [
            - 30 terminaux d’atelier durcis + lecteurs de codes-barres + imprimantes d’étiquettes (35 000 €)
            - serveurs de prod. et sauvegardes (15 000 €)
          ],
          [50 000 €],
          [11,8 %],

          [Formation],
          [
            - formation des opérateurs et accompagnement au démarrage
              \ = 60 jours homme à 850 €
          ],
          [51 000 €],
          [12,0 %],

          table.cell(colspan: 2)[#strong[Coût prévisionnel]],
          [#strong[425 500 €]],
          [#strong[100 %]],

          [Provision risques],
          [5 % du coût prévisionnel],
          [21 275 €],
          [],

          table.cell(colspan: 2)[#strong[Total]],
          [#strong[446 775 €]],
          [],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Budget prévisionnel du projet P4, par poste de dépense.
  ],
)

Près des trois quarts du coût prévisionnel (313 000 €) correspondent à des dépenses externes : licences, prestations de l’éditeur, formation et matériel.

Pour limiter le risque lié à l’éditeur, sa prestation de paramétrage est payée en 3 fois. Chaque versement est rattaché à un jalon projet, et donc soumis à validation du COPIL :
- 30 % à la commande
- 40 % à la phase de réalisation (G3)
- 30 % à la signature du PV de recette

#hidden-heading(level: 3, numbering: none)[Cohérence avec le portefeuille]

Le coût prévisionnel de 425 500 € est celui qui a été retenu lors de la priorisation du portefeuille, et repris dans la partie 3.@cadrage[] Cadrage. Le déploiement d’un MES est le projet le plus coûteux du portefeuille, puisqu’il en représente 21,7 % (sur 1 957 500 €). C’est également le plus rentable, avec 300 000 € de gains annuels attendus, soit un ROI de 111,5 % sur 3 ans.

Avec sa provision, le budget du projet atteint l’enveloppe de 446 775 € validée par le CODIR. En comptant une provision pour risques de 5% par projets, le portefeuille total dépasse déjà de 2,8 % l’enveloppe globale de 2 M€.

Par conséquent, il n’est pas raisonnable d’anticiper des rallonges financières au cours du projet. Ainsi, la provision reste réservée en priorité aux interfaces avec l’ERP (risque R12 de dépassement budgétaire en cas de prestations complémentaires de l’éditeur).

#hidden-heading(level: 3, numbering: none)[Suivi]

Le chef de projet DSI met à jour chaque semaine le montant engagé (réel) pour chaque poste. Au-delà de 5 % d’écart, le seuil d’alerte du plan de management est franchi et le chef de projet DSI prévient le Directeur de la production (commanditaire) et le DSI. Une réunion COPIL évaluera les conséquences et validera les mesures à prendre.
