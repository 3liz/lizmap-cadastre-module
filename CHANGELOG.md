# Changelog

## Unreleased

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
* Fonctionnalité: recherche par compte de propriété
* Recherche par numéro de persone dans la recherche des propriétaires
* Export du relevé de propriété pour toutes les communes
  - Si il existe un filtre par login à appliquer à la couche Parceles pour l'utilisateur, l'export est restreint à la commune de la parcelle sélectionnée
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
* Requête WFS: utilisation du nom de la couche Parcelles
