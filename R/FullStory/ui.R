library(shiny)
library(shinydashboard)
library(shinyjs)
library(tableHTML)

source("Intro.R")
source("ExperimentalDesign.R")
source("WeightVsCount.R")
source("VisualiseData.R")
source("ModelChoice.R")
source("ModelSelection.R")
dashboardPage(
  skin = "purple",
  dashboardHeader(title = span("How to train your model",
                                    style = "font-family: fantasy"), titleWidth = 260), #title
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
                menuItem("Choose your model", tabName = "ModelChoice",
                         icon =icon("dragon")),
                menuItem("Model selection", tabName = "ModelSelection",
                         icon =icon("dragon"))
    )
  ),

  dashboardBody(
    tags$head(tags$style(HTML('/* main sidebar */
        .skin-purple .main-sidebar {
                              background-color: #2E8B57;
                              }
         /* active selected tab in the sidebarmenu */
        .skin-purple .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #3CB371;
                              }
                              .logo {
                                background-color: #4B0082 !important;
                              }
                              .navbar {
                                background-color: #4B0082 !important;
                              }
                              '))),
    tags$style(make_css(list('body',
                             c('font-size', 'font-family', 'color'),
                             c('14px', 'fantasy', 'black')))),
    actionButton(inputId ="Previous", label = icon("arrow-left")),
    actionButton(inputId ="Next", label = icon("arrow-right")),
    tabItems(intro_tab, exp_des_tab, weight_v_count_tab,vis_data_tab,
             mod_choice_tab, mod_select_tab)
  )
)
