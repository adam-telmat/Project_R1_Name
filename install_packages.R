# Script d'installation des packages pour l'app Shiny ÉPIQUE
# Lance ce script AVANT de démarrer l'app Shiny !

packages_needed <- c(
  "shiny",
  "shinydashboard", 
  "shinyWidgets",
  "DT",
  "plotly",
  "ggplot2",
  "ggpubr", 
  "corrplot",
  "psych",
  "caret",
  "dplyr",
  "htmlwidgets"
)

# Installer les packages manquants
for(pkg in packages_needed) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  } else {
    cat("✅", pkg, "déjà installé\n")
  }
}

cat("\n🎉 TOUS LES PACKAGES SONT INSTALLÉS !\n")
cat("🚀 Tu peux maintenant lancer ton app avec: shiny::runApp('app.R')\n")
cat("🌐 Ou dans VSCode: Ctrl+Shift+P > 'R: Run Shiny App'\n") 