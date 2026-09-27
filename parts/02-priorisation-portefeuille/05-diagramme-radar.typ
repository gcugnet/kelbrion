#import "../../helpers.typ": hidden-heading

== Diagramme radar
<diagramme-radar>

L’intérêt d’un diagramme radar est de pouvoir comparer visuellement, en un instant, le score d’un projet dans différents domaines grâce à sa « forme ». @diagramme-de-kiviat

À des fins de visualisation graphique du classement de chaque projet, nous proposons 2 diagrammes radars différents :
- un diagramme comparant le projet sélectionné à la moyenne du portefeuille, selon les 4 « méta-critères » qui servent la priorisation
- un diagramme comparant deux projets sélectionnés entre eux, selon les critères plus bas niveau

#hidden-heading(level: 3, numbering: none)[Diagramme 1 : un projet face à la moyenne du portefeuille]

#figure(
  rotate(image("../../assets/diagramme-radar-projet-moyenne.png", width: 100%)),
  caption: "Diagramme radar comparant un projet (en bleu) à la moyenne du portefeuille (en rouge) sur les 4 « méta-critères » attribués.",
)

~

Le diagramme ci-dessus nous montre que le projet P4 « Déploiement d’un MES » est très rentable par rapport à la moyenne du portefeuille. En revanche, il montre qu’il n’est pas spécialement urgent pour l’ouverture, et que l’équipe projet ne maîtrise pas bien les risques liés.

Cette vue graphique permet au CODIR de voir en un coup d’œil s’il veut changer la priorité d’un projet en fonction des 4 critères majeurs utilisés dans la cotation projets.

~

#hidden-heading(level: 3, numbering: none)[Diagramme 2 : un projet face à un autre]

~

#figure(
  rotate(image("../../assets/diagramme-radar-projet-projet.png", width: 100%)),
  caption: "Diagramme radar comparant deux projets entre eux, selon 6 critères plus bas niveau",
)

~

Ce second diagramme propose une approche différente : il compare directement un projet à un autre, et d’après 6 critères au lieu de 4. Le détail est notamment porté sur les composantes du méta-critère « Urgence pour l’ouverture », qui est ici divisé en :
- Effet de levier
- Chaîne aval
- Bloquant au jour 1

Pour l’exemple, nous avons décidé de comparer le projet de Déploiement d’un MES (P4) avec l’audit du parc applicatif et décommissionnement de l’existant (P1).

Ce diagramme met en évidence les différences fondamentales entre ces 2 projets. Alors que le projet MES (en bleu) est particulièrement rentable et que son déploiement est absolument nécessaire pour les équipes dès le premier jour d’activité sur le nouveau site, on voit qu’il ne provoque pas d’effet levier pour le développement d’autres projets, et que peu de projets en dépendent.

De l’autre côté, on voit que l’audit du parc n’est pas bloquant en soi pour ouvrir le nouveau site, mais que la plupart des autres projets en dépendent, et qu’il a un effet levier majeur. Dans l’organisation du portefeuille, il semble donc intéressant de prioriser ce projet par rapport au déploiement du MES.

Vous pouvez consulter les 2 diagrammes et interagir avec de manière dynamique en suivant #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], dans l’onglet « Radar ».
