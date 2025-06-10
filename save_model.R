# 🤖 CRÉATION ET SAUVEGARDE DU MODÈLE ML
# Lance ce script pour créer ton fichier modèle !

library(caret)
library(dplyr)

cat("🧠 ENTRAÎNEMENT DU MODÈLE MACHINE LEARNING...\n")

# Préparation des données
data(iris)
set.seed(123)

# Division train/test (80/20)
training.samples <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
train.data <- iris[training.samples, ]
test.data <- iris[-training.samples, ]

cat("📊 Données d'entraînement:", nrow(train.data), "observations\n")
cat("📊 Données de test:", nrow(test.data), "observations\n")

# Entraînement du modèle KNN
cat("⚙️ Entraînement en cours...\n")
iris_model <- train(Species ~ ., 
                   data = train.data, 
                   method = "knn",
                   tuneLength = 10,
                   trControl = trainControl(method = "cv", number = 5))

cat("✅ Modèle entraîné avec succès !\n")

# Test de performance
predictions <- predict(iris_model, newdata = test.data)
accuracy <- confusionMatrix(predictions, test.data$Species)

cat("🎯 PERFORMANCE DU MODÈLE:\n")
print(accuracy$overall['Accuracy'])

# SAUVEGARDER LE MODÈLE
saveRDS(iris_model, "iris_ml_model.rds")
cat("💾 Modèle sauvegardé dans: iris_ml_model.rds\n")

# Sauvegarder aussi les infos du modèle
model_info <- list(
  model = iris_model,
  accuracy = accuracy$overall['Accuracy'],
  training_size = nrow(train.data),
  test_size = nrow(test.data),
  date_created = Sys.time(),
  variables = colnames(train.data)[1:4],
  classes = levels(iris$Species)
)

saveRDS(model_info, "iris_model_complete.rds")
cat("📋 Informations complètes sauvegardées dans: iris_model_complete.rds\n")

cat("\n🎉 SUCCÈS ! Tu as maintenant tes fichiers modèles !\n")
cat("📁 Vérifie ton dossier - tu verras les fichiers .rds\n")
cat("🔄 Pour recharger ton modèle: model <- readRDS('iris_ml_model.rds')\n") 