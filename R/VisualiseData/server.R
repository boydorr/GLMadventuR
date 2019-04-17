library("shiny")
library("ggplot2")
library("cowplot")

function(input, output) {
  dragons <- read.csv("../DataGeneration/dragons.csv")
  output$plot = renderPlot({
    response <- colnames(dragons)[1]
    if (input$variable_selection == "hunting"){
      ggplot(data = dragons) +
        geom_boxplot(aes_string(y = response, x = input$variable_selection)) +
        xlab(response) + ylab(input$variable_selection)
    }else{
    ggplot(data = dragons) +
      geom_point(aes_string(y = response, x = input$variable_selection)) +
      xlab(response) + ylab(input$variable_selection)}
  })
}
