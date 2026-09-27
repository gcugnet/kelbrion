#import "../../helpers.typ": hidden-heading

== Retour d’expérience
<retour-experience>
// ~1,5 page

Le retour d’expérience ne se limite pas au bilan de fin de projet. Le plan de management prévoit que des fiches de retour d’expérience (D8) soient rédigées au fur et à mesure de l’exécution du, au minimum à chaque jalon, par le chef de projet DSI, puis revues par le PMO. Chaque fiche décrit le contexte, les faits datés, l’analyse des causes, ce qui a fonctionné, ce qui a posé problème, ainsi que les enseignements. @retour-d-experience

Les fiches REX se terminent par des recommandations, et chacune d’elles se voit attribuer un responsable et une échéance. Le bilan de projet (D11), présenté au CODIR à la clôture, résume de l’ensemble de ces fiches.

Nous pouvons d’ores et déjà tirer des enseignements des vulnérabilités du projet P4 révélées par certains scénarios du tableau de bord, qui permettent d’anticiper les difficultés avant qu’elles ne surviennent.

// TODO liens D8 : remplacer les deux URL par les liens de partage Google Drive
La fiche REX adaptée au projet P4 est consultable via #link("https://TODO-lien-D8-P4")[ce lien].

#hidden-heading(level: 3, numbering: none)[Retard des spécifications de l’éditeur]

La première fiche qui pourrait être rédigée concerne l’éventuel retard de livraison des spécifications par le fournisseur du MES. Si le fournisseur livre ses spécifications avec 2 semaines de retard, c’est autant de retard accumulé sur le chemin critique. La cause de cette dérive possible serait la présence d’une seule personne en mesure d’établir ces spécifications chez le fournisseur. Un bon moyen de s’en prémunir serait alors d’exiger que le fournisseur ait des « back-ups » sur tous les métiers clés, qui ont un travail à rendre à la société Kelbrion dans le cadre du contrat. Prévoir uniquement des pénalités de retard ne pourrait pas empêcher toute dérive dans ce cas précis, et quelque soit la somme de ces pénalités, elle ne permettrait pas de changer de fournisseur suffisamment rapidement.

Plusieurs éléments devraient toutefois bien fonctionner : le risque a déjà été identifié dans le registre (R02), le prototype d’interface est censé permettre de tester le flux descendant dès la livraison partielle, et le COPIL peut toujours décider du report report de G2 sans forcément décaler G3.

#hidden-heading(level: 3, numbering: none)[Choix du fournisseur et provision pour risques]

Choix du prestataire a été restreint du fait d’une planification trop étriquée : le choix du prestataire aurait pu être débuté dès septembre 2026 plutôt qu’attendre la phase de conception fin février 2027. La date très courte de début de réalisation après la signature du contrat a limité les fournisseurs disponibles pour le MES, dans un marché déjà relativement réduit. Des économies auraient être pu réalisées à cet endroit, grâce à une meilleure anticipation.

La provision pour risques a été fixée à hauteur de 5 % du budget prévisionnel. Comme le calendrier était très serré, et que le recours à des prestataires était déjà inévitable au départ, il aurait peut-être été plus prudent d’augmenter la provision pour risques à l’échelle du portefeuille projets, quitte à s’appercevoir que tous les projets ne pourraient pas passer dans l’enveloppe initiale de 2 000 000 €, et d’opérer le choix d’écarter un projet en amont, par prudence. Par ailleurs, tous les projets ont une provision pour risques dans une même proportion de leur montant total (5 %), alors que certains projets sont intrinsèquement plus risqués que d’autres, et c’est d’ailleurs le cas de P4. Nous pourrions donc également imaginer une correlation entre le score de maîtrise des risques d’un projet, et sa proportion de provision pour risques.

#hidden-heading(level: 3, numbering: none)[Enseignements des scénarios]

Les scénarios défavorable et de tensions révèlent d’autres vulnérabilités que l’organisation devrait traiter dans une logique préventive. Par exemple : le profil des développeurs, partagé entre 4 projets, planifié à 100 % de sa capacité et qui ne dispose d’aucune marge de manœuvre (par exemple pour absorber un arrêt maladie). Autre exemple : la mesure de l’avancement des projets, uniquement déclarative, peut masquer un retard pendant plusieurs semaines. Enfin, le scénario défavorable montre qu’une alerte détectée tôt ne sert à rien si la décision est repoussée d’un comité à l’autre : le tableau de bord mesure désormais ce délai de réaction.

Le tableau suivant synthétise ces enseignements et les propositions d’amélioration qui en découlent.

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 8.5pt, hyphenate: false)
        #set par(justify: false)
        #table(
          columns: (1.1fr, 1.7fr, 1.7fr, 1.7fr, 1.9fr),
          align: (left + horizon, left + horizon, left + horizon, left + horizon, left + horizon),
          inset: 4pt,

          [#strong[Thème]],
          [#strong[Ce qui a fonctionné]],
          [#strong[Difficulté]],
          [#strong[Leçon]],
          [#strong[Action d’amélioration]],

          [#strong[Livrables du fournisseur]],
          [Risque R02 identifié, pénalités appliquées, report de G2 décidé en 48 heures],
          [Spécifications livrées avec deux semaines de retard par une ressource unique],
          [Un livrable fournisseur doit être nommé, daté et doté d’un critère d’acceptation],
          [Liste de contrôle des livrables annexée à chaque contrat ; livrables inscrits au planning (D4)],

          [#strong[Choix du fournisseur]],
          [Contrat au forfait avec pénalités de retard],
          [Consultation tardive, peu de fournisseurs disponibles],
          [La consultation doit démarrer dès la validation de la fiche projet],
          [Jalon « consultation lancée » ajouté entre G0 et G1 pour les progiciels],

          [#strong[Provision pour risques]],
          [Provision suffisante dans le scénario intermédiaire],
          [Provision dépassée dans les scénarios défavorable et de tensions],
          [Un taux uniforme de 5 % ne reflète pas l’exposition réelle d’un projet],
          [Provision calculée à partir de la cotation AMDEC et des scénarios, arbitrée à l’échelle du portefeuille],

          [#strong[Ressources partagées]],
          [Saturation repérée chaque semaine par l’indicateur d’occupation],
          [Profil Développeurs planifié à 100 % sur 4 projets],
          [Un profil critique ne doit jamais être planifié sans marge],
          [Plan de charge du portefeuille revu chaque mois par le PMO ; contrat-cadre de prestation pour un renfort rapide],

          [#strong[Pilotage]],
          [Relevés datés et scénarios : alertes visibles tôt],
          [Avancement déclaratif ; arbitrages repoussés],
          [Détecter tôt ne suffit pas, il faut décider vite],
          [Avancement mesuré sur des livrables terminés ; tout statut rouge arbitré au COPIL suivant],

          [#strong[Bascule en production]],
          [Recette technique complète prévue au plan de recette],
          [Procédure de retour arrière (R10) toujours pas rédigée],
          [Aucune bascule sans retour arrière testé],
          [Test de retour arrière rendu obligatoire dans le modèle de plan de recette],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Synthèse du retour d’expérience du projet P4.
  ],
)

Ces actions ne produisent de valeur que si elles modifient durablement les pratiques : la partie suivante décrit comment elles alimentent le référentiel du PMO et les projets suivants.
