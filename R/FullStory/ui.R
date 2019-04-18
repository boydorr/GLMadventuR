library(shiny)
library(shinydashboard)
library(shinyjs)

dashboardPage(
  dashboardHeader(title = "Dragon story"), #title
  dashboardSidebar(
    useShinyjs(),
    sidebarMenu(id = "tabs",
                menuItem("Intro", tabName = "Intro", icon = icon("dragon")),
                menuItem("Experimental Design", tabName = "ExperimentalDesign",
                         icon =icon("dragon")),
                menuItem("Weight vs Count", tabName = "WeightVsCount",
                        icon =icon("dragon")),
                menuItem("Visualise your Data", tabName = "VisualiseData",
                         icon =icon("dragon"))
    )
  ),

  dashboardBody(
    tags$style(".fa-dragon {color:#E87722}", make_css(list('body',
                             c('font-size', 'font-family', 'color'),
                             c('14px', 'fantasy', 'black')))),
    actionButton(inputId ="Previous", label = icon("arrow-left")),
    actionButton(inputId ="Next", label = icon("arrow-right")),
    tabItems(
      tabItem(tabName = "Intro",
              sidebarLayout(
                sidebarPanel(div(img(src='dragon.png', width = 100), style="text-align: center;")),
                # shows generated data frame
                mainPanel(htmlOutput("setting_up_the_problem"))
      )),
      tabItem(tabName = "ExperimentalDesign",
              sidebarLayout(
                sidebarPanel(div(img(src='dragon.png', width = 100), style="text-align: center;")),
                # shows generated data frame
                mainPanel(htmlOutput("experimental_design"))
              )),
      tabItem(tabName = "WeightVsCount",
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
                              step = 1),
                  div(img(src='dragon.png', width = 100), style="text-align: center;")),

                # shows generated data frame
                mainPanel(fluidRow(
                  column(5,
                         dataTableOutput('table')
                  )
                )
                )
              )
      ),
      tabItem(tabName="VisualiseData", #title
              ## Sidebar with a selection input for different variables to plot against
              ## dragon mass/count
              sidebarLayout(
                sidebarPanel(
                  selectInput("variable_selection",
                              label = "Choose your variable here:",
                              choices = c("Sheep" = "sheep", "Hunting" = "hunting",
                                          "Unicorn" = "unicorn",
                                          "Vegetation Height" = "vegetation_height")),
                  div(img(src='dragon.png', width = 100), style="text-align: center;")
                ),
                ## Show a plot of the generated distribution and story text
                mainPanel(htmlOutput("visualise_your_data"), plotOutput("plot"))
              )
          )
    )
)
)
