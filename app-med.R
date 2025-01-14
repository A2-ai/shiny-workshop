library(mrgsolve)
library(shiny)
library(ggplot2)

model_list <- list.files(modlib(), pattern = "^pk.*\\.cpp$")
model_list <- gsub("\\.cpp$", "", model_list)

ui <- fluidPage(
  titlePanel("mrgsolve Simulation - Model Selection"),
  sidebarLayout(
    sidebarPanel(
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
    updated_mod <- param(mod, CL = 10)

    # Add input to adjust the simulation end time
    sim_data <- updated_mod %>%
      ev(amt = 100, ii = 24, addl = 9) %>%
      mrgsim_df(end = 300, delta = 0.1)
  })

  output$sim_plot <- renderPlot({
    ggplot(sim_data(), aes(x = time, y = CP)) +
      geom_line() +
      labs(x = "Time (hours)", y = "Concentration (mg/L)", title = "Simulation Results")
  })

  output$sim_table <- renderTable({
    # Add the sim_data() reactive expression
  })
}

shinyApp(ui = ui, server = server)

