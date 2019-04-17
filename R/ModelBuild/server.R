library("shiny")

function(input, output) {
  dragons <- read.csv("../DataGeneration/dragons.csv")
  output$modelcommand = renderText({
    if (is.null(input$variable_selection)){
      vars <- 1
    }else{
      vars <- paste(input$variable_selection, collapse = " + ")
    }
    response <- colnames(dragons)[1]
    paste0("glm(", response, " ~ ", vars, ", family = 'gaussian', data = dragons)")
  })
}
