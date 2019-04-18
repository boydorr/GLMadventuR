weight_v_count_tab = tabItem(tabName = "WeightVsCount",
        sidebarLayout(
          sidebarPanel(

            # asks user which response variable they want to use
            selectInput(inputId = "response_variable",
                        label = "Do you want to look at mass or count of dragons?",
                        choices = c("mass", "count")),

            # asks user how many areas (?) they want to sample
            sliderInput(inputId = "sample_size",
                        label = "How many areas do you want to sample?",
                        min = 10,
                        max = 100,
                        value = 55,
                        step = 1),
            div(img(src='dragon.png', width = 100), style="text-align: center;")),

          # shows generated data frame
          mainPanel(htmlOutput("weight_vs_count"), fluidRow(
            column(5, dataTableOutput('table')
            )
          )
          )
        )
)
