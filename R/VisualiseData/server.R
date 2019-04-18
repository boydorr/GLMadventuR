library("shiny")
library("ggplot2")
library("cowplot")

function(input, output) {
  visualise_your_data <- "Now that you have collected your data (see the object '<i>dragons</i>'), it might be a good idea to explore it.
We recommend you visualise the collected data and look at a range of summary statistics."
  dragons <- read.csv("../DataGeneration/dragons.csv")
  response <- colnames(dragons)[2]
  output$text = renderText({
    paste(visualise_your_data)
  })
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
