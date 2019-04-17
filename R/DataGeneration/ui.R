library("shiny")

fluidPage(
  titlePanel("Data collection"), #title
  
  sidebarLayout(
    sidebarPanel(
      
      # asks user which response variable they want to use
      selectInput(inputId = "response_variable",
                  label = "Do you want to look at mass or count of dragons?",
                  choices = c("mass", "count")),
      
      # asks user how many areas (?) they want to sample 
      sliderInput(inputId = "sample_size",
                  label = "How many areas do you want to sample?",
                  min = 10,
                  max = 100,
                  value = 55,
                  step = 1)
    ),
    
    # shows generated data frame
    mainPanel(fluidRow(
      column(5,
             dataTableOutput('table')
      )
    )
    )
  )
)
