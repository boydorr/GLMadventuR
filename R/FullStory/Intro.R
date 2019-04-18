intro_tab =
  tabItem(tabName = "Intro",
          sidebarLayout(
            sidebarPanel(div(img(src='dragon.png', width = 100), style="text-align: center;")),
            # shows generated data frame
            mainPanel(htmlOutput("setting_up_the_problem"))
          ))
