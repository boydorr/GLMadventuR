exp_des_tab =
  tabItem(tabName = "ExperimentalDesign",
        sidebarLayout(
          sidebarPanel(div(img(src='dragon.png', width = 100), style="text-align: center;")),
          # shows generated data frame
          mainPanel(htmlOutput("experimental_design"))
        ))
