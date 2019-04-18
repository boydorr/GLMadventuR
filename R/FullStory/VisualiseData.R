vis_data_tab = tabItem(tabName="VisualiseData", #title
        ## Sidebar with a selection input for different variables to plot against
        ## dragon mass/count
        sidebarLayout(
          sidebarPanel(
            selectInput("variable_selection",
                        label = "Choose your variable here:",
                        choices = c("Sheep" = "sheep", "Hunting" = "hunting",
                                    "Unicorn" = "unicorn",
                                    "Vegetation Height" = "vegetation_height")),
            div(img(src='dragon.png', width = 100), style="text-align: center;")
          ),
          ## Show a plot of the generated distribution and story text
          mainPanel(htmlOutput("visualise_your_data"), plotOutput("plot"))
        )
)
