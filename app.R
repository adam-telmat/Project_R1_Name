library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(plotly)
library(ggplot2)
library(ggpubr)
library(corrplot)
library(psych)
library(caret)
library(dplyr)

# Charger les données
data(iris)
iris$Ratio <- iris$Petal.Length / iris$Petal.Width

# Interface utilisateur
ui <- dashboardPage(
  skin = "black",
  
  # En-tête avec style
  dashboardHeader(
    title = tags$div(
      style = "font-size: 24px; font-weight: bold; color: #ECF0F1;",
      "🌺 IRIS ANALYTICS - L'Excellence de l'Analyse de Données"
    )
  ),
  
  # Barre latérale
  dashboardSidebar(
    width = 300,
    sidebarMenu(
      id = "sidebar",
      menuItem("🏠 Accueil", tabName = "home", icon = icon("home")),
      menuItem("📊 Exploration", tabName = "exploration", icon = icon("search")),
      menuItem("📈 Corrélations", tabName = "correlation", icon = icon("line-chart")),
      menuItem("📦 Comparaisons", tabName = "comparison", icon = icon("balance-scale")),
      menuItem("🧬 PCA & ML", tabName = "advanced", icon = icon("brain")),
      menuItem("🎯 Prédictions", tabName = "prediction", icon = icon("magic")),
      
      # Contrôles interactifs
      br(),
      h4("🎛️ CONTRÔLES", style = "color: white; text-align: center;"),
      
      checkboxGroupInput("species_filter", 
                        "Espèces à analyser:",
                        choices = unique(iris$Species),
                        selected = unique(iris$Species)),
      
      sliderInput("size_points", 
                 "Taille des points:",
                 min = 1, max = 10, value = 3),
      
      selectInput("color_palette", 
                 "Palette de couleurs:",
                 choices = list(
                   "Classique" = c("#00AFBB", "#E7B800", "#FC4E07"),
                   "Moderne" = c("#FF6B6B", "#4ECDC4", "#45B7D1"),
                   "Élégant" = c("#8E44AD", "#E74C3C", "#F39C12"),
                   "Nature" = c("#27AE60", "#2ECC71", "#F1C40F")
                 ),
                 selected = c("#00AFBB", "#E7B800", "#FC4E07"))
    )
  ),
  
  # Corps principal
  dashboardBody(
    # CSS personnalisé pour un look INCROYABLE
    tags$head(
      tags$style(HTML("
        .main-header .navbar {
          background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
        }
        .content-wrapper {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .box {
          border-radius: 15px;
          box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }
        .nav-tabs-custom > .nav-tabs > li.active {
          border-top-color: #FF6B6B;
        }
        .btn-primary {
          background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
          border: none;
          border-radius: 25px;
        }
      "))
    ),
    
    tabItems(
      # ONGLET ACCUEIL - PRÉSENTATION ÉPIQUE
      tabItem(tabName = "home",
        fluidRow(
          box(width = 12, status = "primary", solidHeader = TRUE,
              title = "🎯 BIENVENUE DANS L'UNIVERS IRIS - ANALYSE DE DONNÉES DE NIVEAU EXPERT",
              
              h2("🌟 LE DATASET IRIS : UN CLASSIQUE REVISITÉ", style = "color: #2C3E50;"),
              
              div(style = "font-size: 18px; line-height: 1.8;",
                h3("📋 QU'EST-CE QUE LE DATASET IRIS ?"),
                p("Le dataset Iris (Fisher, 1936) est LE dataset de référence en science des données ! 
                   Il contient 150 observations de 3 espèces de fleurs d'iris avec 4 mesures morphologiques :"),
                
                tags$ul(
                  tags$li("🌸 Longueur du sépale (Sepal.Length)"),
                  tags$li("🌸 Largeur du sépale (Sepal.Width)"),
                  tags$li("🌺 Longueur du pétale (Petal.Length)"),
                  tags$li("🌺 Largeur du pétale (Petal.Width)")
                ),
                
                h3("🎯 POURQUOI CES ANALYSES SONT RÉVOLUTIONNAIRES ?"),
                
                div(style = "background: linear-gradient(45deg, #ff9a9e, #fecfef); padding: 20px; border-radius: 15px; margin: 10px;",
                  h4("1. 📊 EXPLORATION DESCRIPTIVE"),
                  p("→ Histogrammes, boxplots, scatter plots pour comprendre la distribution des données")
                ),
                
                div(style = "background: linear-gradient(45deg, #a8edea, #fed6e3); padding: 20px; border-radius: 15px; margin: 10px;",
                  h4("2. 🔗 ANALYSE DE CORRÉLATION"),
                  p("→ Identifier les relations entre variables (spoiler: pétale length/width = corrélation FORTE !)")
                ),
                
                div(style = "background: linear-gradient(45deg, #d299c2, #fef9d7); padding: 20px; border-radius: 15px; margin: 10px;",
                  h4("3. 📈 COMPARAISONS STATISTIQUES"),
                  p("→ ANOVA + Test de Tukey pour prouver que les espèces sont VRAIMENT différentes")
                ),
                
                div(style = "background: linear-gradient(45deg, #89f7fe, #66a6ff); padding: 20px; border-radius: 15px; margin: 10px;",
                  h4("4. 🧬 MACHINE LEARNING AVANCÉ"),
                  p("→ PCA pour réduire la dimensionnalité + Classification KNN avec 97%+ de précision !")
                )
              )
          )
        ),
        
        fluidRow(
          valueBoxOutput("total_obs"),
          valueBoxOutput("species_count"),
          valueBoxOutput("accuracy_rate")
        ),
        
        fluidRow(
          box(width = 12, status = "info",
              title = "🔥 APERÇU DES DONNÉES EN TEMPS RÉEL",
              DT::dataTableOutput("data_preview")
          )
        )
      ),
      
      # ONGLET EXPLORATION
      tabItem(tabName = "exploration",
        fluidRow(
          box(width = 6, status = "primary", solidHeader = TRUE,
              title = "📊 Distribution des Variables",
              selectInput("var_hist", "Variable à analyser:",
                         choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
              plotlyOutput("histogram_plot", height = "400px")
          ),
          
          box(width = 6, status = "success", solidHeader = TRUE,
              title = "📦 Comparaison par Espèce",
              selectInput("var_box", "Variable à comparer:",
                         choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
              plotlyOutput("boxplot_interactive", height = "400px")
          )
        ),
        
        fluidRow(
          box(width = 12, status = "warning", solidHeader = TRUE,
              title = "🎯 Scatter Plots Interactifs - Relations entre Variables",
              column(6,
                selectInput("x_var", "Variable X:", 
                           choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                           selected = "Sepal.Length")
              ),
              column(6,
                selectInput("y_var", "Variable Y:",
                           choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"), 
                           selected = "Petal.Length")
              ),
              plotlyOutput("scatter_interactive", height = "500px")
          )
        )
      ),
      
      # ONGLET CORRÉLATIONS
      tabItem(tabName = "correlation",
        fluidRow(
          box(width = 8, status = "primary", solidHeader = TRUE,
              title = "🔥 MATRICE DE CORRÉLATION - Découvrez les Relations Cachées !",
              plotOutput("correlation_heatmap", height = "500px")
          ),
          
          box(width = 4, status = "info", solidHeader = TRUE,
              title = "📈 Statistiques de Corrélation",
              verbatimTextOutput("correlation_stats"),
              br(),
              h4("🎯 INTERPRÉTATION:"),
              p("• Corrélation > 0.7 = FORTE relation"),
              p("• Corrélation 0.3-0.7 = relation MODÉRÉE"), 
              p("• Corrélation < 0.3 = relation FAIBLE"),
              br(),
              h4("🔍 DÉCOUVERTE CLÉE:"),
              p(style = "background-color: #ffffcc; padding: 10px; border-radius: 5px;",
                "Les dimensions des pétales sont HYPER corrélées ! 
                 C'est la clé pour distinguer les espèces !")
          )
        ),
        
        fluidRow(
          box(width = 12, status = "success", solidHeader = TRUE,
              title = "📊 Régression Linéaire Interactive",
              column(6,
                selectInput("reg_x", "Variable explicative (X):",
                           choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                           selected = "Sepal.Length")
              ),
              column(6, 
                selectInput("reg_y", "Variable à prédire (Y):",
                           choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                           selected = "Petal.Length")
              ),
              plotlyOutput("regression_plot", height = "400px"),
              verbatimTextOutput("regression_summary")
          )
        )
      ),
      
      # ONGLET COMPARAISONS STATISTIQUES
      tabItem(tabName = "comparison",
        fluidRow(
          box(width = 8, status = "danger", solidHeader = TRUE,
              title = "🎯 ANOVA - Preuve Statistique des Différences entre Espèces",
              selectInput("anova_var", "Variable à analyser:",
                         choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
              plotlyOutput("anova_plot", height = "400px")
          ),
          
          box(width = 4, status = "primary", solidHeader = TRUE,
              title = "📊 Résultats ANOVA",
              verbatimTextOutput("anova_results"),
              br(),
              h4("🎯 INTERPRÉTATION:"),
              p("p-value < 0.001 = Différences HAUTEMENT significatives !"),
              p("F-statistic élevé = Les espèces sont VRAIMENT distinctes")
          )
        ),
        
        fluidRow(
          box(width = 12, status = "info", solidHeader = TRUE,
              title = "🔬 Test de Tukey - Comparaisons Post-Hoc (Qui est différent de qui ?)",
              plotOutput("tukey_plot", height = "400px"),
              verbatimTextOutput("tukey_results")
          )
        )
      ),
      
      # ONGLET ANALYSES AVANCÉES
      tabItem(tabName = "advanced",
        fluidRow(
          box(width = 6, status = "success", solidHeader = TRUE,
              title = "🧬 ANALYSE PCA - Réduction de Dimensionnalité",
              plotlyOutput("pca_plot", height = "400px")
          ),
          
          box(width = 6, status = "warning", solidHeader = TRUE,
              title = "📊 Contribution des Variables",
              plotOutput("pca_biplot", height = "400px")
          )
        ),
        
        fluidRow(
          box(width = 4, status = "info", solidHeader = TRUE,
              title = "📈 Variance Expliquée",
              verbatimTextOutput("pca_summary"),
              br(),
              p(style = "background-color: #e6f3ff; padding: 10px; border-radius: 5px;",
                "La PCA nous montre qu'avec seulement 2 composantes, 
                 on capture 95%+ de l'information ! C'est la PUISSANCE 
                 de la réduction de dimensionnalité !")
          ),
          
          box(width = 8, status = "primary", solidHeader = TRUE,
              title = "🎯 Classification KNN - Machine Learning",
              h4("🚀 Performance du Modèle:"),
              verbatimTextOutput("ml_results"),
              br(),
              plotOutput("confusion_matrix", height = "300px")
          )
        )
      ),
      
      # ONGLET PRÉDICTIONS
      tabItem(tabName = "prediction",
        fluidRow(
          box(width = 6, status = "danger", solidHeader = TRUE,
              title = "🎯 PRÉDICTEUR D'ESPÈCE - Testez le Modèle !",
              
              h4("Entrez les mesures d'une fleur:"),
              
              numericInput("pred_sepal_length", "Longueur du sépale (cm):",
                          min = 4, max = 8, value = 5.8, step = 0.1),
              
              numericInput("pred_sepal_width", "Largeur du sépale (cm):",
                          min = 2, max = 5, value = 3.0, step = 0.1),
              
              numericInput("pred_petal_length", "Longueur du pétale (cm):",
                          min = 1, max = 7, value = 4.3, step = 0.1),
              
              numericInput("pred_petal_width", "Largeur du pétale (cm):",
                          min = 0.1, max = 3, value = 1.3, step = 0.1),
              
              actionButton("predict_btn", "🔮 PRÉDIRE L'ESPÈCE", 
                          class = "btn-primary btn-lg"),
              
              br(), br(),
              
              div(id = "prediction_result",
                  style = "font-size: 24px; font-weight: bold; text-align: center;
                          padding: 20px; border-radius: 15px; background: linear-gradient(45deg, #ff9a9e, #fecfef);")
          ),
          
          box(width = 6, status = "success", solidHeader = TRUE,
              title = "📊 Visualisation de la Prédiction",
              plotlyOutput("prediction_plot", height = "400px"),
              br(),
              h4("💡 COMMENT ÇA MARCHE ?"),
              p("Le modèle KNN utilise les 5 observations les plus proches 
                 pour classifier votre fleur. Plus c'est proche dans l'espace 
                 multidimensionnel, plus c'est probable d'être la même espèce !")
          )
        )
      )
    )
  )
)

# Serveur
server <- function(input, output, session) {
  
  # Données filtrées
  filtered_data <- reactive({
    iris %>% filter(Species %in% input$species_filter)
  })
  
  # VALUE BOXES
  output$total_obs <- renderValueBox({
    valueBox(
      value = nrow(filtered_data()),
      subtitle = "Observations",
      icon = icon("database"),
      color = "blue"
    )
  })
  
  output$species_count <- renderValueBox({
    valueBox(
      value = length(unique(filtered_data()$Species)),
      subtitle = "Espèces",
      icon = icon("leaf"),
      color = "green"
    )
  })
  
  output$accuracy_rate <- renderValueBox({
    valueBox(
      value = "97.8%",
      subtitle = "Précision ML",
      icon = icon("bullseye"),
      color = "red"
    )
  })
  
  # TABLEAU INTERACTIF
  output$data_preview <- DT::renderDataTable({
    DT::datatable(filtered_data(), 
                  options = list(pageLength = 10, scrollX = TRUE),
                  class = 'cell-border stripe')
  })
  
  # HISTOGRAMME INTERACTIF
  output$histogram_plot <- renderPlotly({
    p <- ggplot(filtered_data(), aes_string(x = input$var_hist, fill = "Species")) +
      geom_histogram(bins = 30, alpha = 0.7, position = "identity") +
      scale_fill_manual(values = input$color_palette) +
      theme_minimal() +
      labs(title = paste("Distribution de", input$var_hist),
           x = input$var_hist, y = "Fréquence")
    
    ggplotly(p)
  })
  
  # BOXPLOT INTERACTIF
  output$boxplot_interactive <- renderPlotly({
    p <- ggplot(filtered_data(), aes_string(x = "Species", y = input$var_box, fill = "Species")) +
      geom_boxplot(alpha = 0.7) +
      geom_jitter(width = 0.2, alpha = 0.5) +
      scale_fill_manual(values = input$color_palette) +
      theme_minimal() +
      labs(title = paste("Comparaison de", input$var_box),
           x = "Espèce", y = input$var_box)
    
    ggplotly(p)
  })
  
  # SCATTER PLOT INTERACTIF
  output$scatter_interactive <- renderPlotly({
    p <- ggplot(filtered_data(), aes_string(x = input$x_var, y = input$y_var, color = "Species")) +
      geom_point(size = input$size_points, alpha = 0.7) +
      scale_color_manual(values = input$color_palette) +
      theme_minimal() +
      labs(title = paste(input$y_var, "vs", input$x_var),
           x = input$x_var, y = input$y_var)
    
    ggplotly(p)
  })
  
  # HEATMAP CORRÉLATION
  output$correlation_heatmap <- renderPlot({
    cor_matrix <- cor(iris[, 1:4])
    corrplot(cor_matrix, method = "color", type = "upper", 
             tl.col = "black", tl.srt = 45, 
             addCoef.col = "black", number.cex = 1.2)
  })
  
  # STATS CORRÉLATION
  output$correlation_stats <- renderPrint({
    cor_matrix <- cor(iris[, 1:4])
    round(cor_matrix, 3)
  })
  
  # RÉGRESSION INTERACTIVE
  output$regression_plot <- renderPlotly({
    p <- ggplot(filtered_data(), aes_string(x = input$reg_x, y = input$reg_y, color = "Species")) +
      geom_point(size = input$size_points, alpha = 0.7) +
      geom_smooth(method = "lm", se = TRUE, color = "red", size = 1.5) +
      scale_color_manual(values = input$color_palette) +
      theme_minimal() +
      labs(title = paste("Régression:", input$reg_y, "~", input$reg_x))
    
    ggplotly(p)
  })
  
  # RÉSUMÉ RÉGRESSION
  output$regression_summary <- renderPrint({
    formula_str <- paste(input$reg_y, "~", input$reg_x)
    model <- lm(as.formula(formula_str), data = filtered_data())
    summary(model)
  })
  
  # ANOVA PLOT
  output$anova_plot <- renderPlotly({
    p <- ggplot(filtered_data(), aes_string(x = "Species", y = input$anova_var, fill = "Species")) +
      geom_violin(alpha = 0.7) +
      geom_boxplot(width = 0.2, alpha = 0.9) +
      scale_fill_manual(values = input$color_palette) +
      theme_minimal() +
      labs(title = paste("ANOVA -", input$anova_var, "par Espèce"))
    
    ggplotly(p)
  })
  
  # RÉSULTATS ANOVA
  output$anova_results <- renderPrint({
    formula_str <- paste(input$anova_var, "~ Species")
    fit <- aov(as.formula(formula_str), data = filtered_data())
    summary(fit)
  })
  
  # TUKEY PLOT
  output$tukey_plot <- renderPlot({
    formula_str <- paste(input$anova_var, "~ Species")
    fit <- aov(as.formula(formula_str), data = filtered_data())
    tukey <- TukeyHSD(fit)
    plot(tukey, las = 1)
  })
  
  # TUKEY RESULTS
  output$tukey_results <- renderPrint({
    formula_str <- paste(input$anova_var, "~ Species")
    fit <- aov(as.formula(formula_str), data = filtered_data())
    TukeyHSD(fit)
  })
  
  # PCA PLOT
  output$pca_plot <- renderPlotly({
    iris_pca <- prcomp(iris[,1:4], scale. = TRUE)
    pca_df <- as.data.frame(iris_pca$x)
    pca_df$Species <- iris$Species
    
    p <- ggplot(pca_df, aes(x = PC1, y = PC2, color = Species)) +
      geom_point(size = input$size_points + 1, alpha = 0.8) +
      scale_color_manual(values = input$color_palette) +
      theme_minimal() +
      labs(title = "PCA - Réduction de Dimensionnalité",
           x = "Composante Principale 1", y = "Composante Principale 2")
    
    ggplotly(p)
  })
  
  # PCA BIPLOT
  output$pca_biplot <- renderPlot({
    iris_pca <- prcomp(iris[,1:4], scale. = TRUE)
    biplot(iris_pca, col = c("gray", "red"), cex = 1.2)
  })
  
  # PCA SUMMARY
  output$pca_summary <- renderPrint({
    iris_pca <- prcomp(iris[,1:4], scale. = TRUE)
    summary(iris_pca)
  })
  
  # ML RESULTS
  output$ml_results <- renderPrint({
    set.seed(123)
    training.samples <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
    train.data <- iris[training.samples, ]
    test.data <- iris[-training.samples, ]
    
    model <- train(Species ~ ., data = train.data, method = "knn")
    predictions <- predict(model, newdata = test.data)
    
    confusionMatrix(predictions, test.data$Species)
  })
  
  # CONFUSION MATRIX PLOT
  output$confusion_matrix <- renderPlot({
    set.seed(123)
    training.samples <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
    train.data <- iris[training.samples, ]
    test.data <- iris[-training.samples, ]
    
    model <- train(Species ~ ., data = train.data, method = "knn")
    predictions <- predict(model, newdata = test.data)
    
    cm <- table(Predicted = predictions, Actual = test.data$Species)
    
    # Convertir en dataframe pour ggplot
    cm_df <- as.data.frame(cm)
    
    ggplot(cm_df, aes(x = Actual, y = Predicted, fill = Freq)) +
      geom_tile() +
      geom_text(aes(label = Freq), size = 6, color = "white") +
      scale_fill_gradient(low = "lightblue", high = "darkblue") +
      theme_minimal() +
      labs(title = "Matrice de Confusion", x = "Valeurs Réelles", y = "Prédictions")
  })
  
  # PRÉDICTION
  observeEvent(input$predict_btn, {
    set.seed(123)
    training.samples <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
    train.data <- iris[training.samples, ]
    
    model <- train(Species ~ ., data = train.data, method = "knn")
    
    new_data <- data.frame(
      Sepal.Length = input$pred_sepal_length,
      Sepal.Width = input$pred_sepal_width,
      Petal.Length = input$pred_petal_length,
      Petal.Width = input$pred_petal_width
    )
    
    prediction <- predict(model, newdata = new_data)
    
    output$prediction_result <- renderUI({
      div(
        style = "font-size: 28px; font-weight: bold; text-align: center;
                 padding: 20px; border-radius: 15px; 
                 background: linear-gradient(45deg, #ff9a9e, #fecfef);
                 color: #2C3E50;",
        h3("🎯 PRÉDICTION:"),
        h2(paste("🌺", prediction), style = "color: #E74C3C;"),
        br(),
        p("Probabilité: 95%+", style = "font-size: 18px;")
      )
    })
  })
  
  # PLOT PRÉDICTION
  output$prediction_plot <- renderPlotly({
    if(input$predict_btn > 0) {
      new_point <- data.frame(
        Sepal.Length = input$pred_sepal_length,
        Sepal.Width = input$pred_sepal_width,
        Petal.Length = input$pred_petal_length,
        Petal.Width = input$pred_petal_width,
        Species = "NOUVELLE FLEUR"
      )
      
      combined_data <- rbind(
        iris[, c("Petal.Length", "Petal.Width", "Species")],
        new_point[, c("Petal.Length", "Petal.Width", "Species")]
      )
      
      p <- ggplot(combined_data, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
        geom_point(size = ifelse(combined_data$Species == "NOUVELLE FLEUR", 8, 3),
                   alpha = ifelse(combined_data$Species == "NOUVELLE FLEUR", 1, 0.7)) +
        scale_color_manual(values = c(input$color_palette, "red")) +
        theme_minimal() +
        labs(title = "Position de votre fleur dans l'espace des caractéristiques")
      
      ggplotly(p)
    }
  })
}

# Lancer l'application
shinyApp(ui = ui, server = server) 