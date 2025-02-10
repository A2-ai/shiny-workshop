library(mrgsolve)
library(shiny)
library(ggplot2)

model_list <- list.files(modlib(), pattern = "^pk.*\\.cpp$")
model_list <- gsub("\\.cpp$", "", model_list)

ui <- fluidPage(
  titlePanel("mrgsolve Simulation - Model Selection"),
  sidebarLayout(
    sidebarPanel(
      numericInput("cl_choice", "Choose clearance", value = 10, min =1, max =100),
      sliderInput("sim_end", "Choose simulation end time", value = 100, min= 100, max =1000),
      numericInput("dose_choice", "Choose dose amount", value = 10, min =1, max =100)
      
      # Add widget to adjust the clearance (CL) of model
      # Add widget to adjust the simulation end time
    ),
    mainPanel(
      plotOutput("sim_plot"),
      tableOutput("sim_table")
    )
  )
)

server <- function(input, output) {

  sim_data <- reactive({
    mod <- mread("pk1", modlib())

    # Add input to adjust the clearance (CL) of model
    updated_mod <- param(mod, CL = input$cl_choice)

    # Add input to adjust the simulation end time
    sim_data <- updated_mod %>%
      ev(amt = 100, ii = 24, addl = 9) %>%
      mrgsim_df(end = input$sim_end, delta = 0.1)
  })

  output$sim_plot <- renderPlot({
    ggplot(sim_data(), aes(x = time, y = CP)) +
      geom_line() +
      labs(x = "Time (hours)", y = "Concentration (mg/L)", title = "Simulation Results")
  })

  output$sim_table <- renderTable({
    sim_data()
    # Add the sim_data() reactive expression
  })
}

shinyApp(ui = ui, server = server)

