#import "../../helpers.typ": hidden-heading

== Cadrage
// ~1,5 page

Cette sous-partie est dédiée au cadrage du projet MES. La plupart de ces informations sont également disponibles dans la fiche projet, disponible via #link("https://docs.google.com/document/d/1IvHjzKAY22Y-gvHSMOLsYFlj-VZOt0XF/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien], et vous en trouverez un apperçu en annexe @apperçu-fiche-projet[] Apperçu de la fiche projet.

#hidden-heading(level: 3, numbering: none)[Contexte]

Kelbrion est une entreprise qui fabrique des équipements électroniques. Le rôle de son SI est avant tout de faciliter l’activité principale, qui est une activité industrielle. L’entreprise dispose de machine outils sophistiquées, capables de recevoir des commandes via des appels réseau.

#hidden-heading(level: 3, numbering: none)[Problématique]

L’ouverture d’un nouveau site de production nécessite l’installation de nouvelles machines. Néanmoins, chaque machine possède une interface bien spécifique.

#hidden-heading(level: 3, numbering: none)[Enjeux]

La cellule production a besoin de pouvoir piloter les machines à distance, et d’avoir des statistiques en temps réel sur les cadences de production, le nombre d’unités réalisées, l’utilisation des intrants etc...

#hidden-heading(level: 3, numbering: none)[Objectifs]

Un logiciel spécifique est nécessaire pour faire le lien entre l’ERP et les machines.

Le logiciel attendu est un MES, capable de recevoir des instructions de production depuis l’ERP, puis de les inclure dans un planning, et de les transformer en séquence d’actions pour les machines et en fiches pour les opérateurs humains.

#hidden-heading(level: 3, numbering: none)[Parties prenantes]

Le commanditaire du projet est le Directeur de Production. C’est lui qui a exprimé le besoin de pouvoir piloter les machines outils sur le nouveau site de production, de manière à automatiser chaque action au maximum, et posséder des indicateurs précis sur toute la chaîne de production.

Ce projet est géré par l’un des 5 chefs de projets de la DSI. Une équipe projet sera constituée de développeurs, d’administrateurs systèmes et d’ingénieurs DevOps.

Des référents métiers seront également nécessaires pour valider les différents jalons du projet et fournir des informations à l’étape du paramétrage de l’outil.

Des fournisseurs seront sélectinonnés pour la partie logicielle (licences et formation des équipes internes sur l’outil) et matérielle (achat de terminaux mobiles connectés comme des PDA, douchettes et imprimantes mobiles).

Les utilisateurs du MES sont les salariés de l’entreprise Kelbrion, et plus spécifiquement ceux rattachés à la cellule Production (ordonanceur depuis l’ERP, chefs d’ateliers, gestionnaire des stocks, opérateurs, etc.).

#hidden-heading(level: 3, numbering: none)[Périmètre inclus]

Le MES doit être déployé et fonctionnel, c’est-à-dire paramétré pour connaître les produits de Kelbrion et toutes les étapes nécessaires à leur fabrication (matières premières et toutes les étapes de transformation, assemblage, contrôle qualité).

Il doit s’interfacer avec l’ERP de manière à permettre une communication bidirectionnelle (lecture dans un sens, écriture dans l’autre), car c’est lui qui va mettre à jour les stocks de matières premières et les stocks de produits fabriqués.

Le MES doit également être connecté aux différents terminaux mobiles utilisés par les agents sur le site de production, afin de communiquer les ordres de mission : besoin d’approvisionnent, besoin d’une intervention pour débloquer la chaîne de production, besoin d’emballer et déplacer les produits finis vers l’entrepôt de stockage, etc... La fourniture des terminaux figure également dans le périmètre de ce projet.

Le projet de déploiement inclut également la formation de tous les salariés qui seront amenés à utiliser l’outil, quelque soit leur interface (commandes via l’ERP, directement via le MES, ou encore via les terminaux mobiles).

Enfin, la mise en service et vérification de conformité en situation réelle sont les derniers attendus pour valider la livraison complète du projet.

#hidden-heading(level: 3, numbering: none)[Périmètre exclus]

La gestion du cycle de vie et la connaissance du processus de fabrication d’équipments électroniques ne sont pas inclus au périmètre : ce sont des connaissances préalables de l’entreprise, qui constituent son savoir-faire industriel. Le MES n’est là que pour faciliter et automatiser l’exécution.

Les périmètres d’autres projets du portefeuille pouvant avoir un impact sur le MES sont également exclus de ce projet précis : le déploiement réseau (prérequis au déploiement du MES), l’authentification unique, et la supervision.

Le déploiement du MES sur d’autres sites de l’entreprise est également exclus, ainsi que la maintenance préventive des machines, pour lesquels Kelbrion dispose déjà de solutions.

#hidden-heading(level: 3, numbering: none)[Contraintes]

Le projet doit absolument être livré avant l’ouverture du nouveau site de production, prévu en septembre 2027. Comme nous l’avons déjà évoqué, il est contraint par le projet de déploiement du réseau. Lui-même contraint le projet de supervision applicative. Il est donc souhaitable que son développement prenne fin au plus tard en juillet 2027.

Au sein du portefeuille, le projet a été évalué à 425 500 €. Il est important de ne pas dépasser ce montant pour éviter une situation financière délicate.

Les resources disponibles de la DSI (50% de la capacité totale des effectifs) sont à partager entre tous les projets du portefeuille.

Le projet doit également être aligné avec les exigences réglementaires (RGPD). Enfin, son intégration avec l’ERP ne doit pas causer d’interruption de service pour les utilisateurs.

#hidden-heading(level: 3, numbering: none)[Critères de réussite]

Les commandes doivent pouvoir être passées directement depuis l’ERP, et le MES doit déclencher la production à distance au niveau des machines-outils.

Le MES doit être en mesure de prioriser les commandes de production. Il doit remonter au chef d’équipe et au gestionnaire des stocks les commandes à passer auprès des fournisseurs de matières premières et composants lorsque des seuils sont atteints (ou vont être atteints à l’issue des ordres en attente).

Les équipes de l’atelier doivent être informés en temps réel des actions à mener sur la chaîne de production. Les informations transmises aux terminaux mobiles sont suffisamment explicites.

Les permissions sont claires et les actions gardées par des permissions ne sont pas disponibles aux personnes non autorisées (par exemple, un opérateur d’atelier ne peut pas passer une commande sans validation par le chef d’atelier et le gestionnaire des stocks).

Les tests en situation réelle doivent tous être positifs.
