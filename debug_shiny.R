# 🔧 DÉBOGAGE SHINY - Configuration manuelle
# Lance ce script pour identifier le problème exact

cat("🔍 DIAGNOSTIC SHINY...\n")

# Test 1 : Vérifier que Shiny se charge
library(shiny)
cat("✅ Package Shiny chargé\n")

# Test 2 : Configuration manuelle
cat("🔧 Configuration des options Shiny...\n")
options(shiny.launch.browser = FALSE)  # Pas d'ouverture auto du navigateur
options(shiny.host = "127.0.0.1")     # IP locale explicite
options(shiny.port = 3838)            # Port fixe

cat("✅ Options configurées\n")

# Test 3 : App ultra-minimaliste
cat("🧪 Test d'une app ultra-simple...\n")

ui <- fluidPage(
  h1("🎉 SUCCÈS !"),
  p("Si tu vois ça, Shiny marche !"),
  p("Ouvre ton navigateur et va sur : http://127.0.0.1:3838")
)

server <- function(input, output) {
  # Rien - juste pour tester
}

cat("🚀 Lancement sur http://127.0.0.1:3838\n")
cat("⚠️  OUVRE TON NAVIGATEUR MANUELLEMENT sur cette adresse !\n")
cat("⏹️  Pour arrêter : Ctrl + C\n")

# Lancement avec options explicites
shinyApp(ui = ui, server = server, 
         options = list(host = "127.0.0.1", port = 3838, launch.browser = FALSE)) 