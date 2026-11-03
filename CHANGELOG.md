# Changelog

## Unreleased

### Security

* Export PDF asynchrone d'un propriétaire (script `standalone/export.py` du plugin) : les paramètres de la commande
  sont échappés et l'identifiant de parcelle est validé, ils permettaient une injection de commande

### Changed

* Exports CSV des locaux et des parcelles avec leurs propriétaires : ils sont produits par le plugin QGIS
  cadastre de QGIS Server (requête `GetExport`) lorsqu'il la propose, pour les parcelles que l'utilisateur
  peut voir. Sinon, les requêtes SQL du module sont utilisées, avec le même résultat
* Les dates et lieux de naissance sont masqués (`XX/XX/XXXX`, `XXX`) sans le droit de les voir, au lieu de
  retirer les colonnes, comme dans la fiche parcellaire

* Nouveaux droits, à la place de « Accéder aux données de propriétaires avancées » :
  * données sensibles, comme dans le plugin QGIS : dates et lieux de naissance, revenus, exonérations fiscales
  * fonctions : relevé parcellaire, relevé de propriété, onglets d'informations détaillées dans la popup
* Le droit « Accéder aux données de propriétaires simplifiées » devient « Accéder aux données des propriétaires
  (noms et adresses) »
* Migration lors de la mise à jour : les groupes qui avaient le droit avancé reçoivent tous les nouveaux droits,
  rien ne change pour les utilisateurs. Avec le seul droit simplifié, toujours pas de relevés PDF ni d'onglets
  sous la popup
* Exports CSV : un seul bouton « Parcelles et propriétaires » et un seul « Locaux et propriétaires ». Ils contiennent
  les données sensibles autorisées par les droits de l'utilisateur, sauf si la case « Exporter pour un tiers »,
  décochée par défaut, est cochée. La case n'est affichée qu'avec au moins un droit sur les données sensibles
* Popup : le bouton « Relevé parcellaire pour un tiers » est supprimé. Avec au moins un droit sur les données
  sensibles, un clic sur un bouton de relevé propose de le produire « Avec les données que je peux voir » ou
  « Pour un tiers (sans données sensibles) ». Sans droit sur les données sensibles, le relevé est produit
  directement, pour un tiers

### Fixed

* Export CSV des locaux : l'adresse du local n'est plus vide pour une voie sans nature (RUE, CHE...),
  le numéro de voirie n'est plus vide sans indice de répétition, et les lignes de l'adresse
  du propriétaire sont séparées par des espaces

## 2.2.0 - 2026-11-02

Version corrective de sécurité, compatible avec Lizmap Web Client 3.8 à 3.10 uniquement.

### Security

* Exports CSV des locaux et des parcelles avec leurs propriétaires : les identifiants de parcelles et
  des objets de la recherche spatiale sont validés avant d'être utilisés dans la requête SQL, une
  requête avec un identifiant invalide est refusée. Ils permettaient une injection SQL à tout
  utilisateur ayant un droit d'accès aux données de propriété.

### Fixed

* Compatibilité avec Lizmap Web Client 3.10 : la fiche parcellaire et les relevés de propriété
  utilisent les classes `Lizmap\Request\OGCRequest` et `Lizmap\Request\Proxy`, les anciennes classes
  `lizmapOGCRequest` et `lizmapProxy` n'existant plus

### Removed

* Fin de la compatibilité avec Lizmap Web Client 3.6 et 3.7 : le module nécessite Lizmap Web Client 3.8
  à 3.10
* Suppression du code pour QGIS Server 2

### Tests

* La stack docker de tests utilise le plugin QGIS cadastre depuis son dépôt git (branche `master` par
  défaut, ou un clone local), importe ses données fictives et lance des tests automatisés des exports
  (`make import-test-data`, `make test`)
* Les plugins QGIS Server sont installés depuis le dépôt officiel plugins.qgis.org
* CI GitHub : tests automatisés avec Lizmap Web Client 3.8, 3.9 et 3.10 (`make ci`), des exports, de la fiche
  parcellaire, des relevés de propriété et de la page de la carte

## 2.1.6 - 2025-06-20

### Changed

* The cadastre atlas print listener is enough specific
* Cadastre config uses the Lizmap project object to get custom variables instead of request to QGIS Server

## 2.1.5 - 2025-03-07

### Added

* Compatibilité avec Lizmap Web Client 3.9 maximum

## 2.1.4 - 2024-08-27

### Changed

* correction de la recherche sur adresse avec des codes voies n'ayant pas l'identifiant majic (ccovoi)

## 2.1.3 - 2024-07-18

### Changed

* Tests - Update to default Lizmap Web Client 3.7
* Remove including jFormsDatasource.class.php
* Compatibility with Lizmap Web Client 3.8

## 2.1.2 - 2024-06-11

### Fixed

* Affichage des données complémentaires des parcelles avec le droit de consultation avancée

### Funded

* Conseil Département du Calvados https://www.calvados.fr/


## 2.1.1 - 2023-12-19

### Changed

* Recherche spatiale - Amélioration des performances pour des couches de croisement
  de type lignes ou polygones avec des géométries complexes

### Fixed

* Recherche spatiale - On affiche maintenant seulement les couches qui sont sélectionnables
  dans la liste déroulante de choix de la couche de croisement


## 2.1.0 - 2023-12-18

### Added

* Panneau de recherche : ajout d'un onglet "Recherche spatiale" qui permet de sélectionner
  les parcelles par croisement avec les objets sélectionnés d'une autre couche.
  * Choix de la couche PostgreSQL de croisement (elle doit être dans la même base que la couche des Parcelles)
  * Choix du tampon (en mètres) à utiliser pour rechercher les parcelles à partir des objets
  * Choix optionnel du champ à ajouter à l'export CSV
* Ajout de 2 boutons qui permettent d'exporter la liste des propriétaires des parcelles sélectionnées
  avec ce nouvel outil ou avec les autres outils (sélection graphique, via la popup, via le panneau de recherche)

### Fixed

* Correction de l'affichage inutile de la barre d'outil cadastre sur la popup des parcelles
  lorsque les droits n'étaient pas suffisants

### Funded

* Département du Gard https://www.gard.fr

## 2.0.5 - 2023-10-31

### Fixed

* Correction de la liste de communes
* Correction de la liste de sections

### Funded

* Communauté de Communes du Pays de Revigny https://www.copary.fr/

## 2.0.4 - 2023-10-20

### Fixed

* Amélioration de la recherche des parcelles
* Utilisation du cache handler de projet
* Amélioration des recherches par autocomplétion
* Amélioration de la recherche par section
* Amélioration du zoom lors de la recherche

### Funded

* Conseil Département du Calvados https://www.calvados.fr/

## 2.0.3 - 2023-04-03

### Fixed

* Pour le relevé de propriété, l'URL de contrôle doit-être relative

### Funded

* Le Grand Narbonne Communauté d'Agglomération https://www.legrandnarbonne.com

## 2.0.2 - 2023-01-26

### Fixed

* Un propriétaire peut avoir plusieurs comptes communaux

### Funded

* Terre de Provence Agglomération https://www.terredeprovence-agglo.com/

## 2.0.1 - 2023-01-18

### Fixed

* Les DAOs ne contenaient pas asse d'attributs pour pouvoir appliquer des filtres par utilisateur
* Dao adresse: mise à jour du champs name

## 2.0.0 - 2023-01-13

### Fixed

* Disparition des icônes avec Lizmap Web Client 3.6

### Added

* Compatibilité avec Lizmap Web Client 3.6 minimum

### Funded

* Le Grand Narbonne Communauté d'Agglomération https://www.legrandnarbonne.com

## 1.9.1 - 2023-01-10

### Fixed

* Return null for layer SQL when it it is empty
* Application du filtre géographique dans autocomplete

## 1.9.0 - 2023-01-10

### Added

* Compatibilité avec Lizmap Web Client 3.5 minimum
* Application du filtre géographique des données en fonction de l'utilisateur

## 1.8.7 - 2023-01-09

### Fixed

* Ajout du prefixe de section au nom des parcelles si celui est différent de `000`
* Ordre Alphabétique des communes dans le formulaire de recherche
* Amélioration du code de la classe et de la dao `geo_section`
* Amélioration du code des classes et des dao `parcelle_info`

### Funded

* Conseil Départemental du Calvados https://www.calvados.fr

## 1.8.6 - 2022-12-16

### Fixed

* Amélioration de l'export des données Locaux et propriétaires

### Funded

* Conseil Départemental des Pyrénnées Atlantiques https://www.le64.fr/

## 1.8.5 - 2022-12-15

### Fixed

* Correction des accès aux données propriétaires avec le droit simple

### Funded

* Conseil Départemental du Calvados https://www.calvados.fr

## 1.8.4 - 2022-11-29

### Fixed

* Correction des scripts de mises à jour des droits du groupe `cadastre_lizmap``.

## 1.8.3 - 2022-11-22

### Added

* Possibilité de faire une relevé pour un tiers

### Fixed

* Lorsque certains paramètres de récupération des données du "Datasource" d'un champ Jelix sont vides, on renvoie directement une liste vide.

### Funded

* Conseil Départemental du Calvados https://www.calvados.fr

## 1.8.2 - 2022-10-15

### Fixed

* Désactivation du paramètre ALLCITIES pour la génération du relevé de propriété
* Application du paramètre sql du datasource des couches Communes, Sections, Parcelles

## 1.8.1 - 2022-03-29

* Mise à jour **obligatoire** pour Lizmap Web Client 3.4.10 et 3.5.2
* Ajout du paramètre Version pour toutes les requêtes au service `CADASTRE`

## 1.8.0 - 2022-01-19

* Nécessite la version 3.4.8 de Lizmap Web Client minimum

## 1.7.1 - 2021-11-15

* Activation de la fonction de zoom à l'ouverture du formulaire de recherche
* UI - force le margin bottom des éléments p à 10 pixel dans le formulaire de recherche
* Message d'erreur si le plugin cadastre n'est pas correctement installé pour QGIS Server
* Cache navigateur pour les documents PDF de 5 minutes (pour le viewer PDF de Webkit)

## 1.7.0 - 2021-06-21

* Utilisation complète de la configuration du plugin cadastre
  - identification de la couche Parcelles
  - identification de la couche Sections
  - identification de la couche Communes
* Fonctionnalité : recherche par compte de propriété
* Recherche par numéro de personne dans la recherche des propriétaires
* Export du relevé de propriété pour toutes les communes
  - S'il existe un filtre par login à appliquer à la couche Parcelles pour l'utilisateur, l'export est restreint à la commune de la parcelle sélectionnée
  - Sinon l'export se fait sur toutes les communes

## 1.6.2 - 2021-06-03

* Amélioration de l'affichage de la fiche parcellaire dans la popup
  - Ajout d'une hauteur maximale pour les contenus des onglets
  - Modification de la taille des polices
  - Affichage automatique du premier onglet "Parcelle"
* Préparation de la compatibilité pour Lizmap Web Client >= 3.4.4
* Ajout d'un bouton pour imprimer la fiche HTML détaillée de la parcelle
* Correction du bug qui affichait les boutons d'export de relevé PDF pour les utilisateurs sans droit de voir les données de propriété
* Correction du bug dans la popup: boutons sans icônes et erreur "Export en cours..."

## 1.6.1 - 2021-05-25

* Correction d'une régression dans la recherche par propriétaire

## 1.6.0 - 2021-05-18

* Recherche par propriétaire en incluant le champ `comptecommunal`
* Affichage de la fiche parcellaire dans la popup des parcelles

## 1.5.3 - 2021-04-13

* Fix an error in the composer file for PHP

## 1.5.2 - 2021-04-09

* Fix the use of filterPrivate property
* Search: improve comments and some coding style
* Search code: move stop words into a constant
* Search: improve field checking
* Fix an SQL injection into the search
* Fix cadastreProfile: throw an exception if unknown project
* Search: do not search if no terms
* Fix locauxProprios: download CSV
* Export - Add space above information texts
* Configuration to install the module with Composer
* Requête WFS : utilisation du nom de la couche Parcelles
