library(shiny)
library(rmarkdown)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Theoph PK Report Generator"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("subject", "Select Subject:", 
                  choices = unique(Theoph$Subject), 
                  selected = unique(Theoph$Subject)[1]),
      downloadButton("downloadReport", "Download Report")
    ),
    
    mainPanel(
      plotOutput("pkPlot"),
      tableOutput("pkTable")
    )
  )
)

server <- function(input, output) {
  
  subject_data <- reactive({
    Theoph %>% filter(Subject == input$subject)
  })
  
  output$pkPlot <- renderPlot({
    ggplot(subject_data(), aes(x = Time, y = conc)) +
      geom_point() +
      geom_line() +
      labs(title = paste("PK Profile for Subject", input$subject),
           x = "Time (h)", y = "Concentration (mg/L)") +
      theme_minimal()
  })
  
  output$pkTable <- renderTable({
    subject_data()
  })
  
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste("PK_Report_Subject_", input$subject, ".pdf" , sep = "")
    },
    content = function(file) {
      params <- list(subject = input$subject)
      
      rmarkdown::render("report.Rmd", 
                        output_file = file,
                        params = params, 
                        envir = new.env(parent = globalenv()),
                        output_format = "all")
    }
  )
}

shinyApp(ui, server)
