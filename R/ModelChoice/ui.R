library("shiny")

fluidPage(
  titlePanel("Model selection"), #title
  sidebarLayout(
    sidebarPanel(
      ##choose model selection method
      radioButtons("model_selection",
                   label = "Choose your model selection method",
                   choiceNames = c("Null Hypothesis Significance Testing (NHST)",
                                   "Akaike's Information Criterion (AIC)",
                                   "Elastic Net"),
                   choiceValues = c("NHST","AIC","EN")),
      ##choose variables
      checkboxGroupInput("variable_selection",
                         label = "Choose the most complex model",
                         choiceValues = c("sheep", "hunting",
                                          "unicorn", "vegetation_height"),
                         choiceNames = c("Sheep", "Hunting",
                                         "Unicorn", "Vegetation Height"))
    ),
    ##output table
    mainPanel(tableOutput("modelcommand"))
  )
)


