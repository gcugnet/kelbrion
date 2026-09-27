#import "../../helpers.typ": hidden-heading

== Définition des KPI
// ~0,5 page

Les indicateurs clés de performance (KPI) condensent en quelques chiffres les informations du planning, du budget, du registre des risques et de la recette. Ils doivent permettre de répondre rapidement à une question simple : le projet est-il en bonne voie ?

#hidden-heading(level: 3, numbering: none)[Choix des indicateurs]

Nous avons retenu 10 indicateurs, répartis sur les 6 domaines pour lesquels le plan de management fixe un seuil d’alerte : les délais, les coûts, le périmètre, la qualité, les risques et les ressources. Chaque indicateur est calculé à partir d’un document déjà tenu à jour par l’équipe projet, ce qui évite toute saisie supplémentaire.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 9pt, hyphenate: false)
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
          [#strong[Avancement] : avancement réel moins avancement planifié à la date de situation, en points],
          [Planning],
          [0],
          [5 points de retard],
          [10 points de retard],

          [#strong[Date de fin] : date de fin prévue actuellement moins date de fin validée au jalon G1],
          [Planning],
          [0],
          [1 semaine],
          [4 semaines],

          [#strong[Respect des jalons] : jalons franchis à la date prévue, divisés par les jalons échus],
          [Planning],
          [100 %],
          [80 %],
          [60 %],

          table.cell(rowspan: 2)[Coûts],
          [#strong[Écart budgétaire] : prévision à fin moins coût prévisionnel, divisé par le coût prévisionnel],
          [Budget],
          [0 %],
          [5 %],
          [10 %],

          [#strong[Charge consommée] : jours homme internes consommés, divisés par les jours homme prévus à date],
          [Budget],
          [100 %],
          [105 %],
          [115 %],

          table.cell(rowspan: 2)[Périmètre],
          [#strong[Exigences validées] : exigences Must conformes en recette, divisées par les exigences Must du cahier des charges],
          [Cahier de recette],
          [100 %],
          [95 %],
          [90 %],

          [#strong[Demandes de changement] : demandes non instruites dans le délai prévu],
          [Registre des décisions],
          [0],
          [2],
          [4],

          [Qualité],
          [#strong[Anomalies bloquantes] : anomalies bloquantes non corrigées, tous environnements confondus],
          [Cahier de recette],
          [0],
          [1],
          [2],

          [Risques],
          [#strong[Risques non traités] : risques de niveau fort sans plan de réponse],
          [Registre des risques],
          [0],
          [1],
          [2],

          [Ressources],
          [#strong[Occupation] : charge affectée divisée par la capacité du profil le plus sollicité],
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
    Indicateurs clés du projet P4, avec leurs cibles et leurs seuils.
  ],
)

Les seuils d’alerte reprennent ceux du plan de management : une semaine de retard, 5 % de dépassement budgétaire, 95 % du périmètre livré, une anomalie, un risque sans plan de réponse et une occupation des développeurs supérieure à 100 %. Nous leur avons ajouté un seuil critique, qui signale une dérive trop importante pour être traitée au niveau du seul projet.

Nous n’avons pas retenu d’indicateur de satisfaction des parties prenantes : il ne peut être mesuré de manière fiable qu’après la mise en service, et il est donc traité dans le bilan de projet.

#hidden-heading(level: 3, numbering: none)[Lecture des indicateurs]

Les indicateurs sont mis à jour chaque semaine par le chef de projet DSI, à l’exception de ceux qui portent sur la recette, qui ne sont mesurés qu’à partir de juin 2027. Chacun reçoit un statut :
- vert : l’indicateur reste dans les tolérances du plan de management
- orange : le seuil d’alerte est atteint, le chef de projet DSI le signale sous 48 heures au commanditaire et au DSI, puis une réunion du COPIL est organisée
- rouge : le seuil critique est atteint, la trajectoire du projet ou du portefeuille est en jeu et le CODIR est saisi

Chaque indicateur est aussi comparé à sa valeur de la semaine précédente, pour savoir s’il s’améliore, se dégrade ou reste stable. Le statut d’un domaine correspond au plus mauvais statut de ses indicateurs, et le statut global du projet au plus mauvais statut de ses domaines.
