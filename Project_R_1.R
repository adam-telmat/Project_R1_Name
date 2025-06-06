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

# correlation entre "Sepal.Length" et "Petal.Length"
cor(iris$Sepal.Length,iris$Petal.Length) # valeur de la correlation

plot(iris$Sepal.Length,iris$Petal.Length) # nuage de points


ggboxplot(iris, x = "Species", y = "Sepal.Length", 
          color = "Species", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("setosa", "versicolor", "virginica"),
          ylab = "Longueur sépale", xlab = "Espèce")

## ANOVA à un facteur (one-way ANOVA)

# VI = espèce
# VD = longueur du sépale

# commande ANOVA
fit <- aov(Sepal.Length ~ Species, data = iris)
summary(fit)

tukey <- TukeyHSD(fit)
print(tukey)

# Visualisation
plot(tukey, las = 1)

df2<-subset(iris$Sepal.Length)

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
View(iris)                 # Vue Excel-like (interactif)

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

# Scatter plot
plot(iris$Sepal.Length, iris$Sepal.Width,
     col = iris$Species,
     main = "Sepal Length vs Width")

# Boxplot
boxplot(Sepal.Length ~ Species, data = iris,
        main = "Longueur des sépales selon l'espèce")

# Histogramme
hist(iris$Petal.Length, breaks = 10, col = "lightblue")

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

# Scatter plot avec ggplot2
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  theme_minimal()

# Boxplot
ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot() +
  theme_classic()

# Heatmap de corrélation
library(corrplot)
cor_matrix <- cor(iris[, 1:4])
corrplot::corrplot(cor_matrix, method = "color")

#Visualisation interactive
p <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point(size = 2) +
  theme_minimal()

ggplotly(p)

#PCA - Analyse en composantes principales 
iris_pca <- prcomp(iris[,1:4], scale. = TRUE)
summary(iris_pca)

# Biplot
biplot(iris_pca, col = c("gray", "red"))

# PCA ggplot (plus clean)
pca_df <- as.data.frame(iris_pca$x)
pca_df$Species <- iris$Species

ggplot(pca_df, aes(x = PC1, y = PC2, color = Species)) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(title = "PCA - iris dataset")

#regression linéaire
model <- lm(Petal.Length ~ Sepal.Length, data = iris)
summary(model)

# Visualiser la régression
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(color = "darkblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_minimal()

#Modèle prédictif (tentative)
data <- iris
set.seed(123)
training.samples <- createDataPartition(data$Species, p = 0.8, list = FALSE)
train.data <- data[training.samples, ]
test.data <- data[-training.samples, ]

model <- train(Species ~ ., data = train.data, method = "knn")
predictions <- predict(model, newdata = test.data)

confusionMatrix(predictions, test.data$Species)
