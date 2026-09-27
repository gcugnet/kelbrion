#import "../../helpers.typ": hidden-heading

== Plan de management projet
// ~1 page

Le plan de management projet nous renseigne sur la manière de conduire le projet dans le temps.

#hidden-heading(level: 3, numbering: none)[Matrice RACI]

Il comporte une matrice RACI précisant le rôle des principales parties prenantes dans les différentes phases et actions à mener. @raci

On y voit notamment que le Chef de projet DSI est un élément central dans l’organisation du projet en amont puis en aval de sa réalisation : c’est lui qui va rédiger l’ensemble des documents projets demandés par la cellule PMO (de la fiche de projet jusqu’au bilan final). Il interviendra également dans le choix du prestataire. Durant la phase de réalisation, c’est lui qui validera les différentes étapes : déploiement, paramétrage, reprise des données et formation.

Les parties prenantes les plus actives durant l’étape de réalisation sont sans surprise l’équipe DSI, conjointement avec l’éditeur du logiciel MES sélectionné. Les référents métiers sont consultés en amont, puis interviennent surtout sur les dernières phases : la reprise des données, la formation et la validation en situation réelle à l’étape du PV de recette.

#let raci(cell) = {
  let color = if cell == "R" {
    rgb("#C6E0B4") // Vert : Réalise
  } else if cell == "A" {
    rgb("#FFD966") // Jaune : Approuve
  } else if cell == "C" {
    rgb("#9DC3E6") // Bleu : Consulté
  } else if cell == "I" {
    rgb("#D9D9D9") // Gris : Informé
  } else {
    white
  }

  table.cell(
    fill: color,
    align: center + horizon,
    inset: 5pt,
    [#strong(cell)],
  )
}

#figure(
  [#figure(
      align(center)[#table(
        columns: (2.8fr, 0.9fr, 1fr, 0.9fr, 1.1fr, 0.7fr, 1fr),
        stroke: 0.5pt + rgb("#BFBFBF"),
        inset: 5pt,
        align: center + horizon,

        // En-têtes
        table.cell(
          fill: rgb("#404040"),
          align: center + horizon,
          text(fill: white, weight: "bold")[Mission],
        ),
        table.cell(
          fill: rgb("#404040"),
          text(fill: white, weight: "bold")[Dir. prod.],
        ),
        table.cell(
          fill: rgb("#404040"),
          text(fill: white, weight: "bold")[CP DSI],
        ),
        table.cell(
          fill: rgb("#404040"),
          text(fill: white, weight: "bold")[Équipe DSI],
        ),
        table.cell(
          fill: rgb("#404040"),
          text(fill: white, weight: "bold")[Référent \ métiers],
        ),
        table.cell(
          fill: rgb("#404040"),
          text(fill: white, weight: "bold")[PMO],
        ),
        table.cell(
          fill: rgb("#404040"),
          text(fill: white, weight: "bold")[Éditeur MES],
        ),

        // Fiche projet (D1)
        [Fiche projet (D1)],
        raci("A"),
        raci("R"),
        raci(""),
        raci("C"),
        raci("C"),
        raci(""),

        // Cahier des charges (D2)
        [Cahier des charges (D2)],
        raci("A"),
        raci("R"),
        raci("C"),
        raci("R"),
        raci("I"),
        raci("C"),

        // Plan de management (D3)
        [Plan de management (D3)],
        raci("A"),
        raci("R"),
        raci("C"),
        raci("C"),
        raci("C"),
        raci("I"),

        // Planning et budget (D4, D5)
        [Planning et budget (D4, D5)],
        raci("I"),
        raci("R"),
        raci("C"),
        raci("I"),
        raci("A"),
        raci("C"),

        // Tableau de bord (D6)
        [Tableau de bord (D6)],
        raci("I"),
        // Dir. prod.
        raci("R"),
        // Chef de projet
        raci("C"),
        // Équipe DSI
        raci("I"),
        // Référent métiers
        raci("A"),
        // PMO
        raci(""),
        // Éditeur MES

        // Registre des risques (D7)
        [Registre des risques (D7)],
        raci("I"),
        raci("R"),
        raci("C"),
        raci("C"),
        raci("A"),
        raci("C"),

        // Choix du prestataire
        [Choix du prestataire],
        raci("A"),
        // Dir. prod.
        raci("R"),
        // Chef de projet
        raci("R"),
        // Équipe DSI
        raci("C"),
        // Référent métiers
        raci("C"),
        // PMO
        raci(""),
        // Éditeur MES

        // Déploiement sur site
        [Déploiement sur site],
        raci("I"),
        // Dir. prod.
        raci("A"),
        // Chef de projet
        raci("R"),
        // Équipe DSI
        raci("C"),
        // Référent métiers
        raci("C"),
        // PMO
        raci("R"),
        // Éditeur MES

        // Paramétrage et interfaces
        [Paramétrage et interfaces],
        raci("I"),
        raci("A"),
        raci("R"),
        raci("C"),
        raci("I"),
        raci("R"),

        // Reprise des données
        [Reprise des données],
        raci("I"),
        raci("A"),
        raci("R"),
        raci("R"),
        raci("I"),
        raci("C"),

        // Formation des opérateurs
        [Formation des opérateurs],
        raci("I"),
        raci("A"),
        raci("C"),
        raci("R"),
        raci("I"),
        raci("R"),

        // Recette et PV (D10)
        [Recette et PV (D10)],
        raci("A"),
        raci("R"),
        raci("C"),
        raci("R"),
        raci("I"),
        raci("C"),

        // Bilan de projet (D11)
        [Bilan de projet (D11)],
        raci("A"),
        raci("R"),
        raci("C"),
        raci("C"),
        raci("C"),
        raci("I"),
      )],
      kind: table,
    )
  ],
  caption: [
    Matrice RACI indiquant les responsabilités des principaux acteurs dans les grandes missions du projet.
  ],
)

#figure(
  align(center)[
    #table(
      columns: (1fr, 3fr),
      stroke: none,
      inset: 3pt,

      raci("R"), [Responsable],

      raci("A"), [Approbateur],

      raci("C"), [Consulté],

      raci("I"), [Informé],
    )
  ],
  caption: [
    Légende de la matrice RACI.
  ],
)

Le directeur de la production approuve quant à lui les principaux documents de cadrage global, ainsi que le choix du prestataire et valide la fin du projet. La cellule PMO approuve la bonne tenue des documents plus techniques : le planning, le budget, le tableau de bord et la matrice des risques.

#hidden-heading(level: 3, numbering: none)[Organigramme]

Le plan de management nous informe également de l’organigramme à l’échelle du projet. On y retrouve le Chef de projet DSI comme élément central, qui traduit le besoin aux équipes techniques, consulte le DSI et informe le commanditaire des choix stratégiques, et rend des comptes à la PMO sur l’organisation du projet.

#figure(
  rotate(
    0deg,
    reflow: true,
    image("../../assets/organigramme-p4.png", width: 94%),
  ),
  caption: "Organigramme à l’échelle du projet P4.",
)

#hidden-heading(level: 3, numbering: none)[Pilotage]

La méthodologie projet est également décrite dans le plan de management. C’est le cycle en V qui a été retenu, car les contraintes sont connues à l’avance, et l’attendu final lui aussi est bien défini. @cycle-en-v

Au total, 5 phases sont clairement définies :
- le cadrage
- la conception (inclut le choix du prestataire)
- la réalisation
- la recette et déploiement
- la clôture

Pour éviter les allers-retours à chaque changement mineur dans l’organisation du projet, nous préférons adopter une méthode de management prédictif par phases, avec gestion des exceptions. @prince2-project-management

Plus clairement, cela signifie que des réunions du COPIL (comité de pilotage projet), incluant le Directeur de production, le DSI, le responsable PMO et le chef de projet DSI, ont lieu après chaque jalon, pour valider ce qui a été fait et confirmer ce qui sera fait ensuite. Entre ces réunions de COPIL, le chef de projet DSI dispose d’une liberté de manœuvre pour faire avancer le projet dans la bonne direction.

En revanche, des seuils d’alerte sont fixés (les exceptions) et leur dépassement doit faire l’objet de nouvelles réunions COPIL pour évaluer les conséquences et éventuellement modifier la trajectoire du projet voire du portefeuille.


#hidden-heading(level: 3, numbering: none)[Seuils d’alerte]

Ces seuils d’alerte sont définis dans le tableau ci-dessous.

#figure(
  [#figure(
      align(center)[#table(
        columns: (1.2fr, 3fr),
        align: (left, left),

        [#strong[Indicateur]], [#strong[Seuil d’alerte]],

        [Délais], [1 semaine de retard sur le planning],
        [Coûts], [5 % de dépassement],
        [Périmètre], [95 % du périmètre livré (au lieu de 100 %)],
        [Qualité], [1 anomalie],
        [Risques], [1 risque sans plan de réponse],
        [Ressources], [taux d’occupation des développeurs supérieur à 100 %],
      )],
      kind: table,
    )
  ],
  caption: [
    Seuils d’alerte des indicateurs de pilotage.
  ],
)

#hidden-heading(level: 3, numbering: none)[Allocation des ressources]

Les ressources allouées au projet sont également précisées dans le plan de management. On y retrouve le chef de projet DSI, accompagné par une équipe DSI composée de 2 développeurs (150 jours homme) pour assurer l’intégration, les interfaçages et la reprise des données, 2 administrateurs systèmes et réseaux (30 jours homme) pour gérer et adapter l’infrastructure, 1 ingénieur DevOps pour assurer la mise en place des environnements (30 jours homme), ainsi que 3 référents métiers pour 40 jours homme cumulés, mais dont la charge n’est pas comptabilisée dans le budget DSI. Vous trouverez en annexe @tableau-ressources-p4[] « Tableau des ressources du projet P4 » le détail de cette répartition, avec la période d’occupation.

Deux fournisseurs sont également nécessaires à la réalisation de ce projet : l’un pour les licences du MES, une partie de l’intégration et la formation des équipes Kelbrion. L’autre pour les terminaux mobiles nécessaires sur le nouveau site de production, et qui seront directement reliés au MES. Vous trouverez en annexe @tableau-fournisseurs-p4[] « Tableau des fournisseurs du projet P4 » le détail de cette répartition, avec les coûts et mode de pilotage des contrats.

#hidden-heading(level: 3, numbering: none)[Clôture]
<clo>

Le plan de management projet fixe la date de clôture du projet au 23/07/2027, ce qui est cohérent avec la contrainte de date fixée dans la partie 3.@cadrage[] Cadrage (section « Contraintes »). Vous pouvez retrouver l’ensemble de ce document en suivant #link("https://docs.google.com/document/d/1JWMBCmfpd55fSXqBE7fkEMX5NTvgN-I7/edit?usp=sharing&ouid=107621784256337600525&rtpof=true&sd=true")[ce lien].
