# 🚀 INSTALLATION COMPLÈTE POUR SHINY APP
# Sélectionne tout ce fichier et exécute avec Ctrl+Shift+P > "R: Run Selection"

cat("🔧 Installation des packages Shiny...\n")

# Liste des packages nécessaires
packages <- c("shiny", "shinydashboard", "shinyWidgets", "DT", "plotly", "htmlwidgets")

# Installation automatique
for(pkg in packages) {
  if(!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat("📦 Installation de", pkg, "...\n")
    install.packages(pkg, quiet = TRUE)
    library(pkg, character.only = TRUE)
    cat("✅", pkg, "installé avec succès !\n")
  } else {
    cat("✅", pkg, "déjà installé\n")
  }
}

cat("\n🎉 TOUS LES PACKAGES SONT PRÊTS !\n")
cat("🚀 Tu peux maintenant lancer l'app Shiny !\n")

# Test basique pour vérifier que tout marche
cat("\n🧪 Test des packages...\n")
library(shiny)
library(shinydashboard)
library(plotly)

cat("✅ Test réussi ! Shiny est opérationnel !\n")
cat("\n💡 PROCHAINE ÉTAPE : Ouvre app.R et lance l'application !\n") 