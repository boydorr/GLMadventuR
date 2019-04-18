library(shiny)
library(shinydashboard)
library(shinyjs)
library(tableHTML)

source("Intro.R")
source("ExperimentalDesign.R")
source("WeightVsCount.R")
source("VisualiseData.R")
source("ModelSelection.R")
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
                         icon =icon("dragon")),
                menuItem("Select your model", tabName = "ModelSelection",
                         icon =icon("dragon"))
    )
  ),

  dashboardBody(
    tags$style(".fa-dragon {color:#E87722}", make_css(list('body',
                             c('font-size', 'font-family', 'color'),
                             c('14px', 'fantasy', 'black')))),
    actionButton(inputId ="Previous", label = icon("arrow-left")),
    actionButton(inputId ="Next", label = icon("arrow-right")),
    tabItems(intro_tab, exp_des_tab, weight_v_count_tab,vis_data_tab, mod_select_tab)
  )
)
