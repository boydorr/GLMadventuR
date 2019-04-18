mod_choice_tab = tabItem("ModelChoice", sidebarLayout(
  sidebarPanel(
    radioButtons("distroRadio", "You know of two distributions and their qualities, which do you think will be the best fit for your
data?",
                 choices = list("Normal" = "gaussian", "Poisson" = "poisson"),
                 selected = "gaussian"),
    sliderInput("n", "Number of samples", 1, 5000, 100),
    uiOutput("moreControls"),
    uiOutput("moreControls2"),
    div(htmlOutput("warning_message"), style="color: red;"),
    div(img(src='dragon.png', width = 100), style="text-align: center;")
  ),
  mainPanel(htmlOutput("model_family_selection"),
            plotOutput(outputId = "plot2"), textOutput("distribution_choice"))
))
