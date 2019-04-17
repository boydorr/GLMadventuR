library("shiny")

fluidPage(
  titlePanel("Data collection"), #title
  ## Sidebar with a slider input for no. of points
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "response_variable",
                    label = "Do you want to look at mass or count of dragons?",
                    choices = c("mass", "count")),
      sliderInput(inputId = "sample_size",
                  label = "How many areas do you want to sample?",
                  min = 10,
                  max = 100,
                  value = 55,
                  step = 1)
    ),
    ## Show a plot of the generated distribution
    mainPanel(textOutput("response"))
  )
)
