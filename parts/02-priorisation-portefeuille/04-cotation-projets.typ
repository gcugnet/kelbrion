#import "../../helpers.typ": hidden-heading

== Cotation des projets
<cotation-projets>
// ~2,5 pages

Dans cette partie, nous allons combiner les 4 critères précédemment présentés pour attribuer une note finale à chaque projet, qui sera utile pour les prioriser.

Nous avons retenu la pondération suivante :
- alignement stratégique : 30 %
- urgence pour l’ouverture : 30 %
- rentabilité : 20 %
- maîtrise des risques : 20 %

L’alignement stratégique nous semble très important pour répondre aux attentes de la direction sur les 3 prochaines années. Néanmoins, il nous semble pareillement important de respecter l’échéance de 12 mois fixée pour l’ouverture du nouveau site, sans quoi l’entreprise perdra en capacité de production et en salaires par rapport à ce qui a été planifié. Pour cette raison, ces 2 premiers critères constituent un peu plus de la moitié du score total.

Nous avons placé le critère de la rentabilité et de la maîtrise des riques au même niveau : il nous semble aussi important de privilégier les projets rentables que les projets dont le risque est déjà maîtrisé. Cela encourage également à gérer le risque des projets en amont pour les faire remonter dans la hiérarchie du portefeuille.

Le score de priorité correspond au total des 4 notes, multipliées par leur pondération. Nous en déduisons un niveau de priorité :
- priorité 1 à partir de 3,5 : à lancer immédiatement
- priorité 2 à partir de 2,8 : à lancer dès que les prérequis le permettent
- priorité 3 en dessous de 2,8 : différable en cas d’arbitrage budgétaire ou de charge

#figure(
  [#figure(
      align(center)[#block[
        #set text(size: 9.5pt, hyphenate: false)
        #table(
          columns: (0.65fr, 0.65fr, 2.9fr, 1.5fr, 1.2fr, 1.5fr, 1.2fr, 0.9fr, 1.4fr),
          align: (center, center, left, center, center, center, center, center, center),

          [#strong[Rang]],
          [#strong[Code]],
          [#strong[Intitulé]],
          [#strong[Alignement]],
          [#strong[Urgence]],
          [#strong[Rentabilité]],
          [#strong[Risques]],
          [#strong[Score]],
          [#strong[Priorité]],

          [1], [P1], [Audit applicatif], [2,8], [4,2], [4,0], [3,8], [#strong[3,66]], [Priorité 1],

          [2], [P3], [Architecture cible], [3,2], [4,2], [3,0], [3,8], [#strong[3,58]], [Priorité 1],

          [3], [P8], [Chaîne CI/CD], [3,7], [2,9], [4,0], [3,8], [#strong[3,54]], [Priorité 1],

          [4], [P4], [Déploiement MES], [3,7], [2,9], [5,0], [1,8], [#strong[3,34]], [Priorité 2],

          [5], [P5], [Déploiement PLM], [4,1], [2,1], [4,0], [2,6], [#strong[3,18]], [Priorité 2],

          [6], [P7], [Portail collaboratif], [2,3], [2,1], [4,0], [5,0], [#strong[3,12]], [Priorité 2],

          [7], [P2], [Déploiement réseau], [2,3], [5,0], [1,0], [3,4], [#strong[3,07]], [Priorité 2],

          [8], [P9], [IAM / SSO], [3,7], [4,2], [1,0], [2,2], [#strong[3,01]], [Priorité 2],

          [9], [P10], [Supervision], [3,2], [1,0], [3,0], [4,2], [#strong[2,70]], [Priorité 3],

          [10], [P6], [Migration applicative], [3,2], [2,9], [1,0], [1,8], [#strong[2,39]], [Priorité 3],
        )
      ]],
      kind: table,
    )
  ],
  caption: [
    Classement par priorité des projets du portefeuille de la DSI.
  ],
)

Trois projets ressortent en priorité 1 : l’audit du parc applicatif (P1), l’architecture applicative cible (P3) et la chaîne CI/CD (P8). Ce classement nous semble cohérent : il s’agit de projets fondateurs pour les autres, qui produisent un cadre et des connaissances (cartographie, conception de l’architecture, processus de livraison automatisé). Il est plutôt logique qu’ils soient réalisés en premier, du moins d’un point de vue des dépendances projets.

Deux projets cumulant un fort alignement stratégique et rentabilité se placent en priorité 2, juste après les projets fondateurs : le déploiement d’un système de gestion de production (MES) et d’un outil de gestion du cycle de vie produit (PLM). Le portail collaboratif leur succède, grâce à une excellente maîtrise des risques, tandis que le déploiement réseau vient après, seulement en 7ème position, même s’il s’agit du projet noté comme le plus urgent. Vient ensuite l’authentification renforcée et centralisée, toujours en priorité 2.

Les projets les moins prioritaires (priorité 3) sont la supervision (jugée très peu urgente) et la migration applicative vers le nouveau site (qui possède une rentabilité minimale et un niveau de risques élevé).

#hidden-heading(level: 3, numbering: none)[Arbitrages budgétaires]

Ce classement permet potentiellement de réaliser des choix budgétaires. Les 10 projets représentent 1 957 500 € de coût prévisionnel. En y ajoutant une provision pour risques de 5%, le budget total engagé atteint 2 055 375 €. Le portefeuille dépasse donc l’enveloppe initiale qui était fixée à 2 000 000€. Ce dépassement reste faible (environ 2,8%), mais s’il venait à empirer, nous disposerons d’éléments tangibles pour prendre des décisions.

Trois leviers permettent de revenir à l’équilibre budgétaire :
- reporter un projet : le seul candidat crédible est le portail collaboratif (P7), qui n’est pas bloquant au jour 1. Son report permettrait d’écomiser 95 000 € mais entraînerait également le report d’une partie de la supervision applicative (P10), qui en dépend
- réduire un périmètre : livrer des projets dans une version réduite
- diminuer le recours aux prestataires : le TJM interne étant plus bas que celui de prestataires, il pourrait être intéressant de recruter en interne, surtout si l’entreprise prévoit une croissance de son SI sur les années à venir (un CDD peut aussi permettre de combler un manque de main d’œuvre plus momentané)


#hidden-heading(level: 3, numbering: none)[Resources disponibles]

La charge interne planifiée représente 1 700 jours homme pour une capacité réelle de 3 580 jours homme sur l’ensemble du programme, soit un taux d’occupation global de 47 %. Néanmoins, le profil « Développeurs » est chargé à 134 % de sa capacité sur le programme, avec un pic à plus de 450 % au mois de mai. Le recours à des prestataires sur ce profil est donc difficilement évitable, à moins de rapidement prévoir des recrutements.

#hidden-heading(level: 3, numbering: none)[Rang de priorité et ordre de lancement]

La priorité calculée à partir du score total pondéré ne peut pas à elle seule déterminer l’ordre de lancement des projets. Nous avons identifié, à travers le calcul des dépendances, que tous les projets se situent sur le chemin critique. D’après les estimations que nous avons retenues, il n’existe pas de marge de manœuvre entre la durée du chemin critique et la date de l’ouverture du nouveau site : les deux sont de 12 mois. Bien que le déploiement du réseau arrive en 7ème position au classement général, il est impératif que ce projet démarre dès le premier mois, sans quoi les autres projets ne pourront pas commencer.

La grille de cotation complète et le tableau de bord du portefeuille sont disponibles en annexe @tableau-priorisation-projets[] Tableau de priorisation des projets, et de manière interactive en suivant #link("https://docs.google.com/spreadsheets/d/1vOuAuyWx9WGl5-ragtGG6HYRPZ480uSp/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], dans les onglets « Cotation » et « Portefeuille ».
