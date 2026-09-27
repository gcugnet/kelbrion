#import "../../helpers.typ": hidden-heading

== Plan de communication
// ~0,5 page

Le plan de communication répond à une question simple : qui communique quoi, à qui, à quelle fréquence et par quel moyen ?

#hidden-heading(level: 3, numbering: none)[Objectifs et parties prenantes]

La communication autour du projet poursuit 4 objectifs :

- donner au Directeur de la production et au CODIR une visibilité régulière sur l’avancement des développements, l’évolution du budget et des risques
- coordonner les parties prenantes responsables du développement du projet (équipes DSI, référents métiers et fournisseur du MES)
- préparer les métiers (conduite du changement @adkar-prosci) et les informer sur l’usage de leurs données
- encadrer la relation avec les fournisseurs

Les parties prenantes ont été classées selon leur intérêt pour le projet et leur influence sur celui-ci, en accord avec la matrice RACI déjà présentée. Le Directeur de la production et le DSI prennent les décisions. Le responsable PMO, les référents métiers, le référent ERP, les responsables de la sécurité et de la protection des données ainsi que l’éditeur sont consultés. Enfin, les opérateurs et les représentants du personnel sont informés.

#hidden-heading(level: 3, numbering: none)[Matrice de communication]

Le tableau ci-dessous précise, pour chaque public, l’information transmise, le canal utilisé, la fréquence et le responsable de la communication.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 10pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (1.6fr, 2fr, 1.9fr, 1.4fr, 1.2fr),
          align: (
            left + horizon,
            left + horizon,
            left + horizon,
            left + horizon,
            left + horizon,
          ),

          [#strong[Public]], [#strong[Information]], [#strong[Canal]], [#strong[Fréquence]], [#strong[Responsable]],

          [Équipe projet DSI \ + éditeur],
          [Avancement, actions, points bloquants],
          [Réunion COPIL de 30 min \ + compte rendu dans l’outil collaboratif],
          [Chaque lundi],
          [CP DSI],

          [PMO + DSI], [Tableau de bord du projet], [Courriel \ + revue PMO 20 min], [Chaque vendredi], [CP DSI],

          [COPIL],
          [Rapport de situation : indicateurs, budget, risques],
          [Courriel],
          [Mensuelle, le premier vendredi],
          [CP DSI],

          [COPIL + CODIR],
          [Bilan de phase et décision de passage à la suivante],
          [Réunion et procès-verbal de jalon],
          [À chaque jalon (G0 -> clôture)],
          [CP DSI],

          [Directeur production \ + DSI + PMO],
          [Alerte en cas de dépassement d’un seuil],
          [Téléphone + courriel],
          [Sous 48 heures],
          [CP DSI],

          [Éditeur MES],
          [Livrables, planning, réserves, facturation],
          [Comité contractuel d’une heure],
          [Toutes les 2 semaines],
          [CP DSI],

          [Opérateurs et chefs d’équipe],
          [Lettre d’information du projet],
          [Affichage en atelier et intranet],
          [Mensuelle],
          [Resp. atelier],

          [Chefs d’équipe, ordonnanceur, qualité],
          [Démonstration du MES sur des cas réels],
          [Réunion en salle, puis en atelier],
          [Aux jalons G2 et G3],
          [CP DSI],

          [Opérateurs et représentants du personnel],
          [Usage de leurs données personnelles (RGPD)],
          [Réunion et note écrite],
          [En mai 2027, avant la formation],
          [Délégué à la protection des données],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Matrice de communication du projet P4.
  ],
)

Le chef de projet DSI est responsable de la plupart des communications, comme il l’est dans l’organisation du projet. L’information des chefs d’équipes de la production sont déléguées au responsable d’atelier, qui connait mieux ces interlocuteurs. La partie liée aux données personnelles est également confiée au délégué à la protection des données, qui maîtrise bien la partie juridique.

Le plan de communication complet est disponible en suivant #link("https://docs.google.com/document/d/1Dcf04AeJCWGLe6d5UtBP5RSqoswkR9jd/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien].
