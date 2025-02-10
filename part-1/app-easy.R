library(mrgsolve)
library(shiny)
library(ggplot2)

model_list <- list.files(modlib(), pattern = "^pk.*\\.cpp$")
model_list <- gsub("\\.cpp$", "", model_list)

ui <- fluidPage(
  titlePanel("mrgsolve Simulation - Model Selection"),
  sidebarLayout(
    sidebarPanel(
      numericInput("cl_choice", "Select a Clearance:", value = 10, min = 1, max = 100),
      sliderInput("sim_end", "Select a Simulation End Time:", value = 100, min = 1, max = 1000),
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

    # Adjust input$cl_choice for selected model
    updated_mod <- param(mod, CL = input$cl_choice)

    # Adjust input$sim_end for simulation end time
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

