library("shiny")

fluidPage(
  titlePanel("Model building"), #title
  ## Sidebar with a slider input for no. of points
  sidebarLayout(
    sidebarPanel(
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
