#import "../../helpers.typ": hidden-heading

== Tableau de bord
<tableau-de-bord>
// ~2,5 pages

Le tableau de bord condense les indicateurs issus de plusieurs documents PMO sur une seule page. Sa version interactive est consultable en ligne à l’adresse suivante : #link("https://gcugnet.github.io/kelbrion/")[https://gcugnet.github.io/kelbrion/]. Toutes les données qu’elle affiche sont directement récupérées depuis le fichier source, accessible et modifiable sur #link("https://docs.google.com/spreadsheets/d/17EzyZrrci5NL7l5BvhtKIF3yEpbwtrha/edit")[Google Drive].

#hidden-heading(level: 3, numbering: none)[Conception]

Le document « 2026-09-27 - MES - D06 - Tableau de bord » centralise l’information. Ce document est tenu à jour de manière hebdomadaire par le chef de projet DSI, qui renseigne toutes les nouvelles informations relatives au projet, et met à jour les indicateurs. Chaque ligne du relevé contient : date, contexte de communication (COPIL hebdomadaire, mensuel pour le planning, validation des jalons, réunion de crise), l’indicateur concerné, sa valeur, sa source ainsi qu’un commentaire.

Ce registre permet ensuite d’obtenir pour chaque indicateur :
- sa dernière valeur connue
- son évolution (stable, hausse, ou baisse) par rapport à la valeur précédente
- sa situation, au regard des bornes définies dans la section précédente

Nous proposons également une vision d’ensemble, avec encore moins d’information, pour avoir accès aux tendance en un coup d’œil : le statut des domaines, qui sont limités à 6 : délais, coûts, périmètre, qualité, risques et ressources. Le statut d’un domaine correspond au statut du plus mauvais indicateur qu’il contient.

Les indicateurs sont produits en fonction des évènements suivants :
- lors du COPIL hebdomadaire (chaque vendredi) pour le budget, les risques > 26, le périmètre, la qualité et les ressources
- lors du COPIL mensuel pour le planning
  - \+ lors de la revue qui précède le COPIL
  - \+ à chaque jalon
  - \+ de manière exceptionnelle dès qu’une tâche du chemin critique dérape

Le dashboard interactif que nous avons construit est une page web qui lit en direct les données du fichier « Tableau de bord » (Google Sheet). En haute de la page, un curseur permet de se déplacer dans le temps pour choisir n’importe quelle période et ainsi de « rejouer » le projet.

Ce tableau interactif présente la « météo » des 6 domaines, de manière très claire, avec des cards colorées en fonction du statut des domaines. Viennent ensuite les courbes d’avancement du projet, et d’évolution des coûts, qui affichent à la fois les données actuelles et la prévision initiale, pour avoir un indicateur visuel de la tendance (est-elle parallèle à ce qui est attendue, ou dévie-t-elle dans une bonne ou mauvaise direction).

Une frise chronologique montre également l’évolution du statut de chaque domaine, semaine après semaine, sur une période de temps unifiée (52 semaines).

#figure(
  image("../../assets/tdb-situation.png", width: 100%),
  caption: "Vue « Situation » du tableau de bord au 16/04/2027 (semaine 15), scénario intermédiaire.",
)

Nous avons volontairement posé un point de référence au 16/04/2027, approximativement à la moitié du projet, lors de la phase de réalisation, pour jouer avec les indicateurs et observer l’évolution.

#hidden-heading(level: 3, numbering: none)[Scénarios]

Pour « faire vivre » le projet de différentes manières, nous proposons plusieurs scénarios, chacun constitué de valeurs imaginaires mais crédibles. Nous mettons à votre disposition 4 jeux de données :
- scénario de tensions
- scénario favorable
- scénario intermédiaire
- scénario favorable

Cette méthode est souvent employée pour estimer les pertes en fonction des degrés de risques dans la finance. @test-de-resistance-finance Cela peut également permettre à des inverstisseurs de tester les réponses et la résilience d’une organisation en cas de scénarios où rien ne se passe comme prévu. Il nous a semblé intéressant de transposer cette pratique à la gestion de projet, surtout dans les scénarios favorables et de tensions, pour éprouver l’organisation.

Tous les scénarios partent du même planning et budgets de référence, et utilisent les mêmes seuils.

#figure(
  image("../../assets/évolution-financiere-scenarios.png", width: 100%),
  caption: "Évolution financière des différents scénariors dans le temps.",
)

Ils permettent de voir émerger les principaux critères de comparaison. On les distingue d’abord nettement grâce aux couleurs dominantes à l’écran, preuve que l’outil de visualisation est utile. Puis les détails plus techniques sautent aux yeux : date de fin opérationnelle, coût final, nombre de semaines passées dans le rouge, pics de tension (nombre de domaines au rouge en même temps). Ils permettent également de mettre en lumière la résilience de l’organisation, à savoir le délai et les capacités de réaction(leviers engagés).

#figure(
  image("../../assets/tdb-scenarios.png", width: 100%),
  caption: "Vue « Scénarios » du tableau de bord : issues comparées, trajectoires et indice de tension.",
)

#hidden-heading(level: 4, numbering: none)[Scénario favorable]

Ce scénario est l’idéal pour tout chef de projet : les fournisseurs tiennent leurs engagements, les développeurs tiennent les délais, dès qu’un risque devient fort, une solution permet de le réduire.

Dès que le risque R01 (interfaçage MES - ERP) passe en criticité forte (le 12/02), un prototype d’interface sur un ordre de fabrication réel est lancé, ce qui permet de livrer les spécifications à l’heure et de franchir en temps et en heure. Le plan de charge du 12/03 annonce ensuite un pic des développeurs à 105 % début avril : un renfort prestataire est engagé par anticipation (17 000 €), compensé par une remise de 9 500 € négociée sur les licences. Les ressources ne restent que deux semaines en orange, et la seule anomalie bloquante de la recette est corrigée en 48 heures. Le projet se termine le 08/07/2027 comme prévu, pour 418 400 € (1,7 % sous le budget), sans une seule semaine au rouge et sans toucher à la provision.

#figure(
  image("../../assets/occupation-dev-scenario-favorable.png", width: 100%),
  caption: "L’un des seuls indicateurs à avoir passé le seuil d’alerte (orange) dans le scénario favorable : l’occupation des développeurs qui a dépassé les 100 % lors du pic de la  phase de réalisation, durant 2 semaines.",
)

#hidden-heading(level: 4, numbering: none)[Scénario intermédiaire]

Ce scénario est plus probable que le scénario favorable, et il met en lumière quelques difficultés, mais qui sont finalement bien surmontées grâce à un bon suivi de projet et une activation des leviers au bon moment.

Le scénario standard prévoit une occupation du profil des développeurs à 135 % de sa capacité, alors que 4 projets du portefeuille se déroulent en parallèle (P4, P5, P6 et P7). Du fait d’une livraison en retard des spécifications des interfaces par le fournisseur du MES, les délais sont également en orange depuis la semaine 7 (G2 franchi avec une semaine de retard). Les coûts passent en orange à la semaine 14 : la prévision à fin atteint 435 250 € (+2,3 %), et les ressources consommées (108 % des jours homme prévus, et surtout un seuil d’occupation à 135 %) franchissent le seuil d’alerte. Le CODIR valide le renfort d’un développeur prestataire le 23/04 (17 000 €, pris sur la provision).

#figure(
  image("../../assets/kpi-intermédiaire.png", width: 80%),
  caption: "KPI du projet intermédiare après livraison du dernier jalon.",
)

La surcharge accumulée oblige à retarder la recette technique d’une semaine, mais les leviers activés produisent leurs effets en mai : l’occupation redescend sous 100 %, les jalons G3 et G4 sont franchis à la date prévue, et la mise en service est finalement assurée seulement une semaine après la date initiale du 15/07. Le coût final n’excède que de 3,4 % le coût prévisionnel, ce qui reste dans l’enveloppe avec les provisions pour risques.

#hidden-heading(level: 4, numbering: none)[Scénario défavorable]

Ce scénario permet de tester les réponses de l’organisation lorsque plusieurs épines surviennent durant la réalisation du projet. Malgré les problèmes qui s’accumulent, le projet n’est finalement livré qu’avec 1 mois de retard et un écart budgétaire consolidé en zone orange (+8,5%).

Aucun choc majeur ne survient, mais chaque retard est absorbé par l’équipe interne au lieu d’être arbitré. Les spécifications arrivent avec trois semaines de retard et G2 n’est franchi que le 12/03. Au 26/03, la revue du planning annonce déjà une fin de projet décalée de 3 semaines, sans plan de rattrapage. L’avancement accuse déjà 10 points de retard. les délais passent au rouge et n’en sortiront plus. Le CODIR du 23/04 refuse le renfort, faute de provision suffisante, alors que les développeurs sont occupés à 140 %. Les heures supplémentaires ne suffisent pas.

#figure(
  image("../../assets/occupation-dev-defavorable.png", width: 100%),
  caption: "Seuil d’occupation des développeurs dans le scénario défavorable : on voit que le seuil critique (120 %) a été dépassé et que ce dépassement s’est inscrit dans la durée (2 mois), ce qui a logiquement impacté la date du dernier jalon (+ 4 semaines).",
)

Le 28/05, la fin opérationnelle est encore décalée, pour atteindre cette fois-ci 4 semaines de retard, soit le seuil critique.

La recette est alors resserrée et les tests de charge supprimés. Le report du portail collaboratif (P7) est finalement acté le 04/06, six semaines après le refus du renfort.

La mise en service n’intervient que le 29/07, pour un coût final de 461 700 € (+8,5 %) qui dépasse l’enveloppe (avec provisions pour risques) de 14 925 €.

Ce scénario aurait pu être moins problématique en changeant 3 leviers :
- ne pas attendre avant d’envoyer du renfort @loi-de-brooks
- une augmentation de la provision pour risques, sur un projet avec la maîtrise des risques la plus faible du portefeuille
- ne pas sacrifier de tests pour tenir une date

#hidden-heading(level: 4, numbering: none)[Scénario de tensions]

Ce scénario est clairement un stress test : les chocs s’enchaînent sur un planning initialement construit sans marge (ce qui est le cas sur tous les scénarios).

Chaque choc révèle une vulnérabilité de l’organisation. Tout est vert jusqu’au G1, puis le connecteur ERP non éprouvé fait passer R01 en criticité forte le 12/02, sans plan de réponse car aucun prototype n’était prévu. Les spécifications arrivent incomplètes, G2 est manqué le 26/02 et le seul spécialiste des interfaces de l’éditeur quitte son entreprise le 05/03 : les interfaces sont à l’arrêt pendant trois semaines.

Le 19/03, un audit de l’avancement révèle que les tâches déclarées « à 90 % » ne l’étaient pas : l’avancement réel recule de 21 à 19 %, et la fin re-prévue franchit le seuil critique. Viennent ensuite un incident sur l’ERP du groupe qui mobilise son unique référent (26/03), l’arrêt d’un développeur clé pour six semaines, qui porte l’occupation du profil à 170 % (09/04), le blocage de la formation par les représentants du personnel, faute d’information RGPD des opérateurs (R07, 14/05), et des données reprises incohérentes pour 30 % des gammes (R04, 21/05).

#figure(
  image("../../assets/avancement-tensions.png", width: 100%),
  caption: "Dans le scénario de tensions, on voit clairement l’avancement du projet stagner à partir du mois de février, et décrocher de plus en plus par rapport au planning prévisionnel.",
)

Les leviers engagés évitent le pire, mais leur coût est élevé : escalade au CODIR et pénalités dès le 26/02, second prestataire engagé le 16/04 mais arrivé seulement le 10/05 faute de contrat-cadre, gel de P7, bascule des exigences Should en version 2, puis périmètre figé par un COPIL extraordinaire le 28/05. Pour tenir l’ouverture du site, le COPIL décide le 18/06 une mise en service partielle. Le 09/07, la bascule échoue pourtant : les déclarations sont rejetées par l’ERP, et la procédure de retour arrière (R10), en retard depuis avril, n’a jamais été rédigée. Les 6 domaines sont au rouge simultanément. Une cellule de crise quotidienne et la ressaisie manuelle des déclarations permettent une seconde bascule réussie le 23/07, puis la mise en service complète le 03/09. La fin opérationnelle intervient le 09/09/2027, avec 9 semaines de retard, pour un coût final de 514 200 € (+20,8 %), et le projet aura passé 31 semaines sur 37 au rouge.

#figure(
  image("../../assets/coûts-tensions.png", width: 100%),
  caption: "C’est l’attribution d’une enveloppe exceptionnel qui permet finalement de sauver le projet, qui sera malgré tout livré avec 9 semaines de retard et un dépassement de + de 20% par rapport au budget prévisionnel.",
)

Ce scénario met en lumière les tensions pouvant survenir plusieurs niveaux, et qui révèlent des fragilités à anticiper :
- absence de marge au planning
- des ressources uniques (absence de back-up)
- un avancement uniquement déclaratif (manque de recettes intermédiaires)
- l’absence de politique de conduite du changement
- l’absence de procédure de retour arrière
