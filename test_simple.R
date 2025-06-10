# 🧪 TEST SIMPLE SHINY - Pour déboguer
# Si ça marche, on pourra lancer la grosse app !

library(shiny)
library(ggplot2)

# Interface ultra-simple
ui <- fluidPage(
  titlePanel("🌺 TEST SHINY - Dataset Iris"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Contrôles"),
      selectInput("variable", 
                  "Choisir une variable:",
                  choices = c("Sepal.Length", "Sepal.Width", 
                             "Petal.Length", "Petal.Width"),
                  selected = "Sepal.Length"),
      
      checkboxGroupInput("species", 
                        "Espèces:",
                        choices = unique(iris$Species),
                        selected = unique(iris$Species))
    ),
    
    mainPanel(
      h3("📊 Graphique"),
      plotOutput("plot1"),
      
      h3("📋 Données"),
      tableOutput("table1")
    )
  )
)

# Serveur simple
server <- function(input, output) {
  
  # Données filtrées
  filtered_data <- reactive({
    iris[iris$Species %in% input$species, ]
  })
  
  # Graphique
  output$plot1 <- renderPlot({
    ggplot(filtered_data(), aes_string(x = "Species", y = input$variable, fill = "Species")) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = paste("Distribution de", input$variable))
  })
  
  # Tableau
  output$table1 <- renderTable({
    head(filtered_data(), 10)
  })
}

# Lancer l'app
cat("🚀 Lancement de l'app test...\n")
shinyApp(ui = ui, server = server) 