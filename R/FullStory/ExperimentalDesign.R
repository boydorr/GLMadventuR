exp_des_tab =
  tabItem(tabName = "ExperimentalDesign",
        sidebarLayout(
          sidebarPanel(div(img(src='dragon.png', width = 100), style="text-align: center;")),
          # shows generated data frame
          mainPanel(div(htmlOutput("experimental_design"), style= "font-size: 20px;"))

        ))
