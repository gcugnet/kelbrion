#import "../../helpers.typ": hidden-heading

== Définition des KPI
// ~0,5 page

Les indicateurs de performance clés (KPI) résument en quelques chiffres les informations les plus pertinentes du diagramme de Gantt, du budget et de la matrice AMDEC. Ils permettent d’évaluer rapidement la bonne direction et évolution du projet. @indicateur-cle-performance

#hidden-heading(level: 3, numbering: none)[Choix des indicateurs]

Nous pensons que la simplicité prévaut sur l’exhaustivité. Pour cette raison, nous avons limité le nombre d’indicateurs à 10. Ces indicateurs couvrent les 6 domaines pour lesquels le plan de management fixe un seuil d’alerte :
- les délais
- les coûts
- le périmètre
- la qualité
- les risques
- les ressources

Chaque indicateur est calculé à partir d’un document tenu à jour par le chef de projet DSI, lors des COPIL hebdomadaires, mensuels, ou encore des livraisons de jalons.

Nous avons également fixé des bornes pour chaque indicateur : elles correspondent aux seuils d’alerte exposés dans le plan de management.

En cas de dépassemement des bornes, deux niveaux de gravité sont fixés pour chaque indicateur. Un dépassement problématique mais qui ne met pas directement en péril le projet est considéré comme le seuil d’alerte. Un dépassement encore significativement au-delà du seuil d’alerte est considéré comme critique. La réponse aux éventuels dépasseemnt des bornes dépend de leur criticité. Le seuil d’alerte nécessite d’informer le Directeur de production et le DSI sous 48h, et de prendre une décision au plus tard au prochain COPIL. Le seuil critique nécessite une information dans les plus brefs délais (maximum 4h) du Directeur de production et du DSI, et de la mise en place d’une cellule de crise avec la PMO et si besoin le CODIR pour valider les décisions.

Nous avons choisi de ne pas retenir d’indicateur de satisfaction utilisateurs, car elle ne pourra être mesurée qu’après la fin du projet (déploiement et mise en service). Néanmoins, cet aspect pourra être traité dans le bilan de projet.

Le tableau en page suivante récapitule les différents indicateurs, leur source, et leurs différentes bornes (cible, alerte et critique).

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 10pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (1fr, 3.4fr, 1.2fr, 0.9fr, 0.9fr, 0.9fr),
          align: (
            left + horizon,
            left + horizon,
            left + horizon,
            center + horizon,
            center + horizon,
            center + horizon,
          ),

          [#strong[Domaine]],
          [#strong[Indicateur et calcul]],
          [#strong[Source]],
          [#strong[Cible]],
          [#strong[Alerte]],
          [#strong[Critique]],

          table.cell(rowspan: 3)[Délais],
          [#strong[Avancement] = réel - planifié à la date de situation (en points)],
          [Gantt],
          [0],
          [-5 pts],
          [-10 pts],

          [#strong[Date de fin] = date de fin actuelle - date de fin initialement validée (G1)],
          [Gantt],
          [0],
          [1 sem.],
          [4 sem.],

          [#strong[Respect des jalons] = jalons validés à la date prévue / jalons échus],
          [Gantt],
          [100 %],
          [80 %],
          [60 %],

          table.cell(rowspan: 2)[Coûts],
          [#strong[Écart budgétaire] = (prévision ajustée - prévision initiale) / prévision initiale],
          [Budget],
          [0 %],
          [5 %],
          [10 %],

          [#strong[Ressources consommées] : j.h internes consommés / j.h prévus à date],
          [Budget],
          [100 %],
          [105 %],
          [115 %],

          table.cell(rowspan: 2)[Périmètre],
          [#strong[Spécifications implémentées] : exigences Must recettées / exigences Must du cahier des charges],
          [Cahier de recette],
          [100 %],
          [95 %],
          [90 %],

          [#strong[Demandes de changement] : demandes non respectées dans le délai imparti],
          [Registre des décisions],
          [0],
          [2],
          [4],

          [Qualité],
          [#strong[Anomalies bloquantes] : anomalies bloquantes non corrigées],
          [Cahier de recette],
          [0],
          [1],
          [2],

          [Risques],
          [#strong[Risques sans réponse] : risques de niveau fort (> 26 AMDEC) sans plan de réponse],
          [AMDEC],
          [0],
          [1],
          [2],

          [Ressources],
          [#strong[Occupation] : charge affectée / capacité du profil le plus demandé],
          [Plan de charge],
          [80 %],
          [100 %],
          [120 %],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Présentation des indicateurs clés du projet P4 avec source et différentes bornes.
  ],
)
