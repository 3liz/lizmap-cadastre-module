# Changelog

## Unreleased

### Fixed

* Amélioration de la recherche des parcelles
* Utilisation du cache handler de projet 
* Amélioration des recherches par autocomplétion
* Amélioration de la recherche par section

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
