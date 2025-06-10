install.packages("shiny")
install.packages("psych")
install.packages("ggpubr")
install.packages("plotly")
install.packages("caret")
library(caret)
library(plotly)
library(psych)
library("ggpubr")

View(iris)
summary(iris)
describe(iris$Sepal.Length) #psych

# la commande describe(iris$Species) ne fonctionne pas car "Species" n'est pas une variable numérique
x<-table(iris$Species)
prop.table(x)

# Créer un dossier pour les graphiques
if (!dir.exists("graphiques")) {
  dir.create("graphiques")
}

# correlation entre "Sepal.Length" et "Petal.Length"
cor(iris$Sepal.Length,iris$Petal.Length) # valeur de la correlation

# Graphique 1: nuage de points
png("graphiques/01_nuage_points_correlation.png", width = 800, height = 600)
plot(iris$Sepal.Length,iris$Petal.Length, 
     main = "Corrélation Sepal.Length vs Petal.Length") # nuage de points
dev.off()
cat("✅ Graphique 1 sauvegardé: graphiques/01_nuage_points_correlation.png\n")

# Graphique 2: boxplot coloré
png("graphiques/02_boxplot_ggpubr.png", width = 800, height = 600)
print(ggboxplot(iris, x = "Species", y = "Sepal.Length", 
          color = "Species", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("setosa", "versicolor", "virginica"),
          ylab = "Longueur sépale", xlab = "Espèce"))
dev.off()
cat("✅ Graphique 2 sauvegardé: graphiques/02_boxplot_ggpubr.png\n")

## ANOVA à un facteur (one-way ANOVA)

# VI = espèce
# VD = longueur du sépale

# commande ANOVA
fit <- aov(Sepal.Length ~ Species, data = iris)
summary(fit)

tukey <- TukeyHSD(fit)
print(tukey)

# Graphique 3: Visualisation Tukey
png("graphiques/03_tukey_test.png", width = 800, height = 600)
plot(tukey, las = 1)
dev.off()
cat("✅ Graphique 3 sauvegardé: graphiques/03_tukey_test.png\n")

# Exemple de subset avec condition - gardons seulement les valeurs > 5
df2<-subset(iris, Sepal.Length > 5)

s<-sqrt(iris$Sepal.Length[5])

# -------------------------------------------
#  1. PRISE EN MAIN DE BASE
# -------------------------------------------

2 + 2                       # Opérations mathématiques simples
sqrt(16)                   # Racine carrée
log(10)                    # Logarithme népérien
exp(1)                     # Exponentielle

# Créer des vecteurs
x <- c(1, 2, 3, 4, 5)
mean(x)                    # Moyenne
median(x)                  # Médiane
sd(x)                      # Écart-type
summary(x)                 # Statistiques générales

# -------------------------------------------
#  2. DÉCOUVERTE DU DATASET IRIS
# -------------------------------------------

data(iris)                 # Chargement du jeu de données intégré
head(iris)                 # Afficher les premières lignes
str(iris)                  # Structure des données
summary(iris)              # Résumé statistique
# View(iris)                 # Vue Excel-like (interactif) - commenté pour VSCode

# Colonnes disponibles
names(iris)
unique(iris$Species)

# -------------------------------------------
#  3. FILTRER & MANIPULER LES DONNÉES (Base R)
# -------------------------------------------

# Sélectionner une colonne
iris$Sepal.Length

# Filtrer des lignes (ex : que les Setosa)
iris[iris$Species == "setosa", ]

# Créer une nouvelle variable
iris$Ratio <- iris$Petal.Length / iris$Petal.Width

# -------------------------------------------
#  4. VISUALISATION RAPIDE (Base R)
# -------------------------------------------

# Graphique 4: Scatter plot
png("graphiques/04_scatter_plot_base.png", width = 800, height = 600)
plot(iris$Sepal.Length, iris$Sepal.Width,
     col = iris$Species,
     main = "Sepal Length vs Width")
legend("topright", legend = levels(iris$Species), col = 1:3, pch = 1)
dev.off()
cat("✅ Graphique 4 sauvegardé: graphiques/04_scatter_plot_base.png\n")

# Graphique 5: Boxplot
png("graphiques/05_boxplot_base.png", width = 800, height = 600)
boxplot(Sepal.Length ~ Species, data = iris,
        main = "Longueur des sépales selon l'espèce")
dev.off()
cat("✅ Graphique 5 sauvegardé: graphiques/05_boxplot_base.png\n")

# Graphique 6: Histogramme
png("graphiques/06_histogramme.png", width = 800, height = 600)
hist(iris$Petal.Length, breaks = 10, col = "lightblue", 
     main = "Distribution de la longueur des pétales")
dev.off()
cat("✅ Graphique 6 sauvegardé: graphiques/06_histogramme.png\n")

# -------------------------------------------
#  5. DPLYR – MANIPULATION AVANCÉE (facultatif mais utile)
# -------------------------------------------

# Installer si besoin : install.packages("dplyr")
library(dplyr)

iris %>%
  group_by(Species) %>%
  summarise(moyenne = mean(Sepal.Length),
            ecart_type = sd(Sepal.Length))

# -------------------------------------------
#  6. GGPLOT2 – GRAPHIQUES AVANCÉS
# -------------------------------------------

# Installer si besoin : install.packages("ggplot2")
library(ggplot2)

# Graphique 7: Scatter plot avec ggplot2
g7 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  theme_minimal() +
  ggtitle("Scatter plot ggplot2")
ggsave("graphiques/07_scatter_ggplot2.png", g7, width = 10, height = 6)
cat("✅ Graphique 7 sauvegardé: graphiques/07_scatter_ggplot2.png\n")

# Graphique 8: Boxplot ggplot2
g8 <- ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot() +
  theme_classic() +
  ggtitle("Boxplot ggplot2")
ggsave("graphiques/08_boxplot_ggplot2.png", g8, width = 10, height = 6)
cat("✅ Graphique 8 sauvegardé: graphiques/08_boxplot_ggplot2.png\n")

# Graphique 9: Heatmap de corrélation
library(corrplot)
png("graphiques/09_heatmap_correlation.png", width = 800, height = 600)
cor_matrix <- cor(iris[, 1:4])
corrplot::corrplot(cor_matrix, method = "color", title = "Matrice de corrélation")
dev.off()
cat("✅ Graphique 9 sauvegardé: graphiques/09_heatmap_correlation.png\n")

# Graphique 10: Visualisation interactive (sauvegardé en HTML)
p <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point(size = 2) +
  theme_minimal() +
  ggtitle("Graphique interactif")

library(htmlwidgets)
plotly_graph <- ggplotly(p)
saveWidget(plotly_graph, "graphiques/10_graphique_interactif.html")
cat("✅ Graphique 10 sauvegardé: graphiques/10_graphique_interactif.html\n")

#PCA - Analyse en composantes principales 
iris_pca <- prcomp(iris[,1:4], scale. = TRUE)
summary(iris_pca)

# Graphique 11: Biplot
png("graphiques/11_biplot_pca.png", width = 800, height = 600)
biplot(iris_pca, col = c("gray", "red"), main = "PCA Biplot")
dev.off()
cat("✅ Graphique 11 sauvegardé: graphiques/11_biplot_pca.png\n")

# Graphique 12: PCA ggplot (plus clean)
pca_df <- as.data.frame(iris_pca$x)
pca_df$Species <- iris$Species

g12 <- ggplot(pca_df, aes(x = PC1, y = PC2, color = Species)) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(title = "PCA - iris dataset")
ggsave("graphiques/12_pca_ggplot2.png", g12, width = 10, height = 6)
cat("✅ Graphique 12 sauvegardé: graphiques/12_pca_ggplot2.png\n")

#regression linéaire
model <- lm(Petal.Length ~ Sepal.Length, data = iris)
summary(model)

# Graphique 13: Visualiser la régression
g13 <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(color = "darkblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_minimal() +
  ggtitle("Régression linéaire")
ggsave("graphiques/13_regression_lineaire.png", g13, width = 10, height = 6)
cat("✅ Graphique 13 sauvegardé: graphiques/13_regression_lineaire.png\n")

#Modèle prédictif (tentative)
data <- iris
set.seed(123)
training.samples <- createDataPartition(data$Species, p = 0.8, list = FALSE)
train.data <- data[training.samples, ]
test.data <- data[-training.samples, ]

model <- train(Species ~ ., data = train.data, method = "knn")
predictions <- predict(model, newdata = test.data)

confusionMatrix(predictions, test.data$Species)

cat("\n🎉 TOUS LES GRAPHIQUES ONT ÉTÉ SAUVEGARDÉS DANS LE DOSSIER 'graphiques/' !\n")
cat("📁 Ouvrez le dossier 'graphiques' pour voir tous vos graphiques.\n")
cat("🌐 Le graphique interactif est disponible en HTML: graphiques/10_graphique_interactif.html\n")
