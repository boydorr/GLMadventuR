library("shiny")
library("ggplot2")
library("cowplot")

function(input, output) {
  dragons <- read.csv("../DataGeneration/dragons.csv")
  response <- colnames(dragons)[2]
  output$plot = renderPlot({
    if (input$variable_selection == "hunting"){
      ggplot(data = dragons) +
        geom_boxplot(aes_string(y = response, x = input$variable_selection)) +
        ylab(response) + xlab(input$variable_selection)
    }else{
    ggplot(data = dragons) +
      geom_point(aes_string(y = response, x = input$variable_selection)) +
      ylab(paste(response)) + xlab(input$variable_selection)}
  })
}
