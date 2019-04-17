library("shiny")

fluidPage(
  titlePanel("Model selection"), #title
  ## Sidebar with variable selection and model selection method
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("variable_selection",
                         label = "Choose your model selection method",
                         choiceNames = c("Null Hypothesis Significance Testing (HHST)",
                                         "Akaike's Information Criterion (AIC)",
                                         "Elastic Net"))
      checkboxGroupInput("variable_selection",
                         label = "Choose the most complex model",
                         choiceValues = c("sheep", "hunting",
                                          "unicorn", "vegetation_height"),
                         choiceNames = c("Sheep", "Hunting",
                                          "Unicorn", "Vegetation Height"))
    ),
    ## Show a plot of the generated distribution
    mainPanel(textOutput("modelcommand"))
  )
)

