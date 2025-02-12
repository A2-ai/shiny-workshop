library(shiny)
library(ggplot2)
library(mrgsolve)
library(dplyr)

mod <- mread("pk1", modlib())

ui <- fluidPage(
  # Add numeric labels and values for simulation end
  numericInput(),
  # Add labels connecting it to the server
  plotOutput()
)

server <- function(input, output, session) {
  # Add the simulation logic to create the simulation results
  simulation <- reactive({
    
  })
  
  output$plot1 <- renderPlot({
    
  })
}

shinyApp(ui, server)