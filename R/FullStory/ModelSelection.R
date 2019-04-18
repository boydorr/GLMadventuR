mod_select_tab = tabItem("ModelSelection", sidebarLayout(
  sidebarPanel(
    radioButtons("distroRadio", "Is it:",
                 choices = list("Normal" = 1, "Poisson" = 2),
                 selected = 1)
  ),
  mainPanel(htmlOutput("model_family_selection"), plotOutput(outputId = "plot2"))
))
