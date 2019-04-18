intro_tab =
  tabItem(tabName = "Intro",
          sidebarLayout(
            sidebarPanel(div(img(src='dragon.png', width = 100), style="text-align: center;")),
            # shows generated data frame
            mainPanel(div(htmlOutput("setting_up_the_problem"), style= "font-size: 20px;"))
          ))
