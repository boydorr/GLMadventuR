library("shiny")

fluidPage(
  titlePanel("Visualise Data"), #title
  ## Sidebar with a slider input for no. of points
  sidebarLayout(
    sidebarPanel(
      selectInput("variable_selection",
                         label = "Explore relationship between dragons and your collected variables:",
                         choices = c("Sheep" = "sheep", "Hunting" = "hunting",
                                     "Unicorn" = "unicorn",
                                     "Vegetation Height" = "vegetation_height"))
    ),
    ## Show a plot of the generated distribution
    mainPanel(plotOutput("plot"))
  )
)
