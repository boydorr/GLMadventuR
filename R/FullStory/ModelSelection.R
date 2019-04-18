mod_select_tab = tabItem("ModelSelection", sidebarLayout(
  sidebarPanel(
    radioButtons("distroRadio", "Here are two distributions and their qualities, which do you think will be the best fit for your data? ",
                 choices = list("Normal" = 1, "Poisson" = 2),
                 selected = 1)
  ),
  mainPanel(htmlOutput("model_family_selection"),
            plotOutput(outputId = "plot2"), textOutput("distribution_choice"))
))
