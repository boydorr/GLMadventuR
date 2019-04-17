library("shiny")

function(input, output) {

  output$modelcommand = renderText({
    if (is.null(input$variable_selection)){
      vars <- 1
    } else {
      vars <- paste(input$variable_selection, collapse = " + ")
    }
    response <- colnames(dragons[,1]
    formula <- paste0("glm(", response, " ~ ", vars, 
                      ", family = 'gaussian', data = dragons)")
    if (input$model_selection=="NHST") {
      pvalueoutput<-summary(eval(parse(text=formula)))$coefficients[,c(1,4)]
      row.names(pvalueoutput)<-vars
      pvalueoutput
    } elseif (input$model_selection=="AIC") {
      
    } else {
    
    }
  })
}

