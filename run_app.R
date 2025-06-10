# 🚀 LANCEUR SHINY OPTIMISÉ POUR VSCODE
# Configuration spéciale pour VSCode + Shiny

cat("🔧 Configuration Shiny pour VSCode...\n")

# Configuration optimale pour VSCode
options(
  shiny.launch.browser = TRUE,        # Ouvrir navigateur automatiquement  
  shiny.host = "127.0.0.1",          # Host local
  shiny.port = 3838,                 # Port fixe
  shiny.autoreload = TRUE,           # Rechargement auto
  shiny.trace = TRUE,                # Debug mode
  shiny.error = browser              # Debugger sur erreur
)

# Vérifier que tous les packages sont là
required_packages <- c("shiny", "shinydashboard", "shinyWidgets", 
                      "DT", "plotly", "ggplot2", "ggpubr", 
                      "corrplot", "psych", "caret", "dplyr", "htmlwidgets")

cat("📦 Vérification des packages...\n")
for(pkg in required_packages) {
  if(!require(pkg, character.only = TRUE, quietly = TRUE)) {
    stop(paste("❌ Package manquant:", pkg))
  }
}
cat("✅ Tous les packages sont installés !\n")

# Nettoyer l'environnement
rm(list = ls()[!ls() %in% c("required_packages")])

cat("🧹 Environnement nettoyé\n")

# Messages informatifs
cat("\n" , "="*50, "\n")
cat("🌺 LANCEMENT DE L'APP IRIS ANALYTICS\n") 
cat("🌐 URL: http://127.0.0.1:3838\n")
cat("🛑 Pour arrêter: Ctrl + C\n")
cat("🔄 Auto-reload activé (modifications en temps réel)\n")
cat("="*50, "\n\n")

# Source de l'app principale avec gestion d'erreurs
tryCatch({
  cat("📂 Chargement de app.R...\n")
  source("app.R", local = TRUE)
}, error = function(e) {
  cat("❌ ERREUR lors du chargement:\n")
  cat(conditionMessage(e), "\n")
  cat("\n💡 Solutions possibles:\n")
  cat("1. Vérifier que app.R existe\n")
  cat("2. Vérifier la syntaxe du code\n")
  cat("3. Redémarrer la session R\n")
}) 