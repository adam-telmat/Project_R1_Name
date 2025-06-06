# Project_R1_Name
# Analyse du jeu de données *iris* en R

Ce projet explore le célèbre jeu de données `iris` en utilisant le langage R. Il inclut des analyses statistiques de base, des visualisations, une ANOVA, une analyse en composantes principales (PCA) et un modèle prédictif.

## 📂 Contenu de l'analyse

- **Exploration initiale** : `summary()`, `describe()`, visualisation des distributions
- **Statistiques descriptives par espèce** : moyennes, écart-types
- **Test ANOVA** : comparaison des longueurs de sépales selon l'espèce
- **Test de Tukey post-hoc** : paires d'espèces significativement différentes
- **Visualisations avancées** : boxplots, heatmap de corrélation, scatter plots colorés
- **Analyse en composantes principales (PCA)** : réduction de dimension pour observer la structure du dataset
- **Modèle prédictif (KNN)** : classification supervisée avec `caret`

## 📊 Résultats principaux

- L'ANOVA montre que la longueur du sépale varie significativement selon l'espèce.
- La PCA permet de visualiser les 3 espèces sous forme de groupes bien distincts en 2D.
- Le modèle prédictif KNN atteint une précision de **96-100%**.

## 📁 Fichiers

- `iris_analysis.R` : code principal
- `iris_pca_plot.png` : graphique PCA
- `README.md` : ce fichier

## 🧠 Technologies utilisées

- R
- Packages : `ggplot2`, `psych`, `dplyr`, `caret`, `corrplot`, `ggpubr`, `plotly`

## 📌 À venir (améliorations possibles)

- Implémentation de modèles plus complexes (SVM, random forest)
- Interface interactive avec `shiny`
- Rapport HTML via `rmarkdown`

---

*Projet pédagogique dans le cadre de l’apprentissage du langage R et de la data science.*
