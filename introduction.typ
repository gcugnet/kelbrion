#import "helpers.typ": hidden-heading

#heading(
  level: 1,
  numbering: none,
)[Introduction]
// ~1 page

Ce document apporte une vision sur la possible structuration de la gestion de projets au sein du SI #footnote()[*SI (système d’information)* : ensemble organisé de ressources qui permet de collecter, stocker, traiter et distribuer de l'information, en général grâce à un réseau d'ordinateurs. @systeme-d-information] d’une entreprise. Bien que l’étude de cas utilise une entreprise fictive, la logique de ce document serait transposable à un contexte réel.

#hidden-heading(level: 2)[Présentation du contexte]

Kelbrion est une entreprise française de 350 salariés, qui fabrique des équipements électroniques. Ses clients sont d’autres entreprises, principalement dans le secteur de l’industrie.

Pour accompagner sa croissance, l’entreprise Kelbrion a récemment acquis un nouveau bâtiment industriel. L’objectif de la DSI est de transformer ce nouveau bâtiment pour pleinement l’intégrer au SI de Kelbrion et le rendre opérationnel.

La modernisation du bâtiment s’articule autour de 10 projets, numérotés de P1 à P10, répartis dans 5 axes :

#hidden-heading(level: 3, numbering: none)[Audit et décomissionnement de l’existant]

- P1 : Audit du parc applicatif et décommisionnement de l’existant.

#hidden-heading(level: 3, numbering: none)[Déploiement d’un nouveau réseau informatique]

- P2 : Déploiement du réseau LAN et Wi-Fi du bâtiment

#hidden-heading(level: 3, numbering: none)[Conception et déploiement des applications métiers]

- P3 : Conception de l’architecture applicative cible et urbanisation du SI
- P4 : Déploiement d’un système MES #footnote()[*MES (manufacturing executive system)* : en français logiciel de pilotage de la production, logiciel collectant en temps réel les données de production d'une usine ou d'un atelier, données qui sont analysées quant à la traçabilité, le contrôle de la qualité, le suivi de production, l'ordonnancement et la maintenance préventive et curative. @logiciel-pilotage-production] pour la nouvelle unité de production
- P5 : Déploiement d’un outil PLM #footnote[*PLM (product lifecycle management)* : en français gestion du cycle de vie du produit, est un ensemble de concepts, de méthodes et d'outils logiciels permettant de créer et d'entretenir les produits industriels tout au long de leur cycle de vie, depuis l'établissement du cahier des charges et des services associés jusqu'à la fin de vie, en passant par le maintien en condition opérationnelle. @gestion-cycle-de-vie-produit] pour les équipes d’ingénierie et de R&D
- P6 : Migration des applications métier, reprise des données et intégration

#hidden-heading(level: 3, numbering: none)[Outils collaboratifs et déploiement continu des applications]

- P7 : Développement d’un portail collaboratif pour les nouvelles équipes
- P8 : Mise en place d’une chaîne d’intégration et de déploiement continu

#hidden-heading(level: 3, numbering: none)[Sécurisation, supervision et documentation]

- P9 : Gestion des identités et des accès applicatifs (IAM / SSO)
- P10 : Supervision applicative, procédures d’exploitation et documentation

L’échéance est de 12 mois, elle est contractuellement fixée et correspond à l’arrivée prévue des collaborateurs dans le nouveau bâtiment. Le budget total est de 2 000 000 €. La DSI est composée de 36 salariés, qui seront mobilisables sur ces projets à hauteur d’environ 50% de leur temps de travail.

#hidden-heading(level: 2)[Positionnement]

Tout au long de ce document, nous nous plaçons en tant que responsable de l’animation de la nouvelle cellule PMO de l’entreprise Kelbrion. La cellule PMO a 3 objectifs principaux autour du portefeuille projets :

- structuration
- propositions argumentées d’arbitrages
- organisation du suivi

#hidden-heading(level: 2)[Méthodologie]

Le plan de ce document découle naturellement de ces 3 objectifs.

Dans un premier temps nous allons proposer une méthode unifiée, permettant de structurer chaque projet du portefeuille.

Nous identifierons ensuite des critères applicables à ces différents projets, qui seront utiles pour effectuer des arbitrages et prioriser.

Après ces deux premières parties, nous appliquerons la méthode de gestion retenue à un projet spécifique. Cela nous permettra de proposer des exemples plus fournis des documents à rédiger, du cadrage au budget prévisionnel.

Nous continuerons avec une partie dédiée au pilotage projet, puis nous étudierons la phase de recette, la clôture d’un projet, et pour finir, nous aborderons la phase de retour d’expérience avant de conclure.
