library("shiny")

fluidPage(
    titlePanel("Model Selection"),
    sidebarLayout(
        sidebarPanel(
            h1("Decide!!!"),
            h3("Where is your data coming from, oh my merry fellow?"),
            radioButtons("distroRadio", h3("Is it:"),
                         choices = list("Normal brew" = 1, "Poison" = 2),
                         selected = 1)
        ),
        plotOutput(outputId = "plot1")
    )
)
