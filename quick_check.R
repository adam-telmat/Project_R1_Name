# 🔍 VÉRIFICATION RAPIDE DE L'ENVIRONNEMENT
# Lance ce script pour vérifier que tout est prêt !

cat("🔍 DIAGNOSTIC DE L'ENVIRONNEMENT...\n\n")

# 1. Vérifier la version de R
cat("📊 VERSION DE R:\n")
print(R.version.string)
cat("\n")

# 2. Vérifier les packages essentiels
packages_required <- c("shiny", "shinydashboard", "shinyWidgets", 
                      "DT", "plotly", "ggplot2", "caret")

cat("📦 VÉRIFICATION DES PACKAGES:\n")
all_good <- TRUE

for(pkg in packages_required) {
  if(require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat("✅", pkg, "- OK\n")
  } else {
    cat("❌", pkg, "- MANQUANT\n")
    all_good <- FALSE
  }
}

cat("\n")

# 3. Test rapide de Shiny
if(all_good) {
  cat("🧪 TEST RAPIDE DE SHINY...\n")
  
  # Test basique
  tryCatch({
    library(shiny)
    cat("✅ Shiny se charge correctement\n")
    
    # Vérifier les données Iris
    data(iris)
    cat("✅ Dataset Iris disponible (", nrow(iris), "observations)\n")
    
    cat("\n🎉 ENVIRONNEMENT PRÊT !\n")
    cat("🚀 Vous pouvez lancer l'application avec: Run Shiny App\n")
    
  }, error = function(e) {
    cat("❌ ERREUR lors du test Shiny:\n")
    cat(conditionMessage(e), "\n")
    all_good <- FALSE
  })
} else {
  cat("❌ PACKAGES MANQUANTS - Lancez setup_shiny.R d'abord\n")
}

if(!all_good) {
  cat("\n🔧 SOLUTIONS:\n")
  cat("1. Vérifiez que R est bien installé\n")
  cat("2. Lancez: source('setup_shiny.R')\n")
  cat("3. Redémarrez VSCode\n")
} 