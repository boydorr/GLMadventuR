library("shiny")

function(input, output) {

  output$modelcommand = renderText({
    if (is.null(input$variable_selection)){
      vars <- 1
    }else{
      vars <- paste(input$variable_selection, collapse = " + ")}
    paste0("glm(dragons ~ ", vars, ", family = 'gaussian')")
  })
}
