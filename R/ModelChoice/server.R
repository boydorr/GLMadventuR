library("shiny")
library("xtable")

function(input, output) {
  dragons<-read.csv("~/Desktop/git/GLMadventuR/R/DataGeneration/dragons.csv")
  output$modelcommand = renderTable({
    if (is.null(input$variable_selection)){
      vars <- 1
    } else {
      vars <- paste(input$variable_selection, collapse = " + ")
    }
    response <- colnames(dragons)[1]
    formula <- paste0("glm(", response, " ~ ", vars, 
                      ", family = 'gaussian', data = dragons, na.action=na.fail)")
    if (input$model_selection=="NHST") {
      if (is.null(input$variable_selection)){
      
      } else {
        as.matrix(summary(eval(parse(text=formula)))$coefficients)
        # pvalueoutput<-summary(eval(parse(text=formula)))$coefficients[,c(1,4)]
        # pvalueoutput
        # row.names(pvalueoutput)<-vars
        # pvalueoutput
      }
    } else if (input$model_selection=="AIC") {
      MuMIn::dredge(eval(parse(text=formula)))
    } else {
      print("Not yet implemented.")
    }
  })
}

