== Présentation du projet
// ~0,5 page

Le projet de déploiement d’un logiciel de gestion et de pilotage de la production (MES) nous intéresse particulièrement, car il s’agit d’un outil au cœur du métier.

Il doit couvrir l’ordonancement, le suivi des ordres de fablication et la traçabilité, tout en étant interfacé avec l’ERP du groupe.

#figure(
  rotate(image("../../assets/schema-mes.png", width: 90%)),
  caption: "Schéma montrant la place du futur MES dans l’entreprise",
)

L’ERP pourra ainsi transmettre des ordres de fabrication au logiciel de pilotage de la production, qui sera ensuite capable de gérer les plannings et relayer les instructions aux opérateurs et aux machines.

Les opérateurs et les machines de l’atelier pourront ensuite remonter des informmations sur les temps de productions, quantités et qualité au MES, qui les transmettra à l’ERP.

C’est le projet qui est le plus aligné avec les objectifs de l’entreprise : sa raison d’être est d’améliorer la capacité de production et de réduire les délais clients.

Ce logiciel doit également permettre de réaliser des économies, en adaptant les cadences de production sur-mesure par rapport à la demande renseignée. C’est le projet du portefeuille avec le plus gros ROI attendu.

Il permet également d’améliorer la conformité, grâce à une  traçabilité complète du processus de production.

Pour être démarré, le déploiement du MES dépend de 2 autres projets bloquants :
- le déploiement du réseau sur le nouveau site
- la conception de l’architecture applicative cible

Nous prévoyons le début de ce projet à M+4 à partir du lancement de l’audit du parc applicatif et déploiement du réseau.
