#import "../../helpers.typ": hidden-heading

== PV de recette
// ~1,5 page

Le procès-verbal de recette (D10) est le document contractuel qui acte le résultat d’une session de recette. Il reprend les critères fixés dans le cahier des charges et vérifie s’ils sont correctement implémentés. Il est signé par le commanditaire (le Directeur de la production, dans le cas du P4). Nous en proposons un #link("https://docs.google.com/document/d/1SwyzXxv0gxoDMkyuJv8F5YanuGGhVTvk/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[modèle générique], utilisable par tous les projets du portefeuille, ainsi qu’une #link("https://docs.google.com/document/d/1TbfD0-NSYJPnUSniFZCOM2YdLh9_ZoMR/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ébauche préparée pour le projet P4].

#hidden-heading(level: 3, numbering: none)[Modèle générique]

Le modèle générique applicable à tous les projets du portefeuille, quelle que soit leur nature : un PV est rédigé pour chaque lot de recette, qu’il s’agisse d’une recette en usine chez le fournisseur, d’une recette technique, d’une recette fonctionnelle ou de la vérification de service régulier après la mise en production. Il est rédigé par le chef de projet avec le référent métier, et signé par le commanditaire.

Les exigences sont toujours reliées au cahier des charges, et les cas de test toujours reliés au cahier de recette, ce qui permet de corréler chaque résultat à une exigence précise. Les réserves sont classées selon leur gravité (bloquante |  majeure | mineure). Une action corrective est précisiée pour chaque réserve, ainsi qu’un responsable et une échéance pour les résoudre. Une réserve bloquante interdit la validation.

#hidden-heading(level: 3, numbering: none)[Ébauche du projet P4]

Pour le projet P4, la recette donne lieu à deux procès-verbaux. Le premier clôture la recette technique, tandis que le second, dont nous présentons l’ébauche, porte sur la recette fonctionnelle, réalisée dans l’atelier sur le nouveau site de production. L’ébauche est préparée à partir du cahier des charges et de la stratégie de recette.

L’objet, le périmètre, les participants, les documents de référence et les critères de validation y sont renseignés. Chaque exigence est indiquée comme « non testée », jusqu’au jour de la recette. Les résultats, les réserves seront complétés à l’issue de la session, avant la signature du Directeur de production.

La décision a des conséquences directes sur la suite du projet : une recette prononcée sans réserve permet de franchir le jalon G4 à temps (par rapport au planning prévisionnel) et de payer le restant-dû au fournisseur.

Une recette prononcée avec réserves autorise la bascule du 28/06, à condition que ces réserves soient levées d’ici là. Le paiement du fournisseur est reporté jusqu’à la levée de toutes les réserves.

Un refus entraîne une nouvelle session de recette, et menace directement la mise en production, et potentiellement l’ouverture du site, comme P4 est critique pour l’ouverture.

Le tableau suivant présente les rubriques du modèle de PV de recette et la manière dont elles sont renseignées dans l’ébauche du projet P4.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 10pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (1.3fr, 2.6fr, 3.1fr),
          align: (left + horizon, left + horizon, left + horizon),
          inset: 4pt,

          [#strong[Rubrique]], [#strong[Contenu du modèle générique]], [#strong[Ébauche du projet P4]],

          [#strong[1. Objet et périmètre]],
          [Livrables soumis à la recette, version livrée, périmètre couvert et éléments exclus de la session],
          [MES paramétré en version 1, interfaces avec l’ERP, données reprises et 45 terminaux ; exigences EF-01 à EF-11. Hors session : recette technique, formation, exigence EF-12],

          [#strong[2. Participants]],
          [Nom, rôle, entité et présence de chaque participant],
          [Chef de projet DSI, responsable de l’atelier, ordonnanceur, responsable qualité, deux chefs d’équipe, référent ERP, chef de projet de l’éditeur, Responsable PMO en observateur],

          [#strong[3. Documents de référence]],
          [Cahier des charges, cahier de recette, journal d’exécution, contrat, livrables avec leur version],
          [Cahier des charges v1.0 du 29/01/2027, cahier de recette v1.1 (48 cas), contrat au forfait du 05/02/2027, PV de recette technique],

          [#strong[4. Synthèse des résultats]],
          [Cas de test prévus, exécutés, conformes, non conformes et non exécutés ; anomalies ouvertes par gravité],
          [48 cas prévus ; résultats renseignés à l’issue de la session],

          [#strong[5. Critères de validation]],
          [Pour chaque exigence : critère d’acceptation, cas de test associés, résultat (conforme, non conforme ou non testé)],
          [EF-01 à EF-11, rattachées aux cas CT-01 à CT-48 du plan de tests],

          [#strong[6. Réserves]],
          [Description, gravité, action corrective, responsable et échéance de levée],
          [Renseignées à l’issue de la session],

          [#strong[7. Décision]],
          [Sans réserve, avec réserves ou refus ; motivation, conditions et prochaine étape],
          [Réserves à lever avant la bascule du 28/06/2027 ; solde de 30 % retenu jusqu’à leur levée ; jalon G4 le 25/06/2027],

          [#strong[8. Signatures]],
          [Chef de projet, référent métier, commanditaire et fournisseur],
          [Chef de projet DSI, responsable de l’atelier, Directeur de production, éditeur du MES],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Rubriques du procès-verbal de recette : modèle générique et ébauche du projet P4.
  ],
)
