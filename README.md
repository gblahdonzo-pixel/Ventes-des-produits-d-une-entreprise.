# Ventes des produits d'une entreprise

## Description du Projet
Ce projet consiste en l'analyse multidimensionnelle des ventes d'une entreprise à partir d'un entrepôt de données (Data Warehouse). L'objectif est d'extraire des indicateurs clés et des sous-totaux par pays, par année, par mois et par produit en utilisant des requêtes SQL avancées (fonctions d'agrégation et ROLLUP).

## Schéma de l'Entrepôt de Données
La base comprend 4 tables principales :
- *CLIENT* : idcli, ville, région, pays
- *PRODUIT* : idproduct, nom, catégorie, cost_price, sale_price, fournisseur
- *DATE* : idDate, mois, moisNom, trimestre, année
- *VENTES* : idproduct, idDate, idcli, delivery_date, quantité

## Compétences Mises en Œuvre
- Exploitation d'un modèle en étoile / entrepôt de données.
- Utilisation de jointures multi-tables.
- Agrégations et calculs de chiffres d'affaires et de volumes.
- Utilisation des extensions de regroupement (ROLLUP) pour les sous-totaux et totaux généraux.
