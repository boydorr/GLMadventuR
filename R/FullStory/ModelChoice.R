mod_choice_tab = tabItem("ModelChoice", sidebarLayout(
  sidebarPanel(
    radioButtons("distroRadio", "Here are two distributions and their qualities, which do you think will be the best fit for your data? ",
                 choices = list("Normal" = "gaussian", "Poisson" = "poisson"),
                 selected = "gaussian"),
    div(htmlOutput("warning_message"), style="color: red;")
  ),
  mainPanel(htmlOutput("model_family_selection"),
            plotOutput(outputId = "plot2"), textOutput("distribution_choice"))
))
