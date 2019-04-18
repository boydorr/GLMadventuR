library("shiny")
library("xtable")

function(input, output) {
  ##read in data
  dragons<-read.csv("~/Desktop/git/GLMadventuR/R/DataGeneration/dragons.csv")
  ##render table
  output$modelcommand = renderTable({
    ##generate list for correct glm formlula from inputted variables
    if (is.null(input$variable_selection)){
      vars <- 1
    } else {
      vars <- paste(input$variable_selection, collapse = " + ")
    }
    ##set response variable - will need changing when feedthrough implemented
    response <- colnames(dragons)[1]
    ##glm command as string
    formula <- paste0("glm(", response, " ~ ", vars,
                      ", family = '",input$distribution_choice,"', data = dragons, na.action=na.fail)")
    ##run command from string
    dragonmodel<--eval(parse(text=formula))
    ##if NHST
    if (input$model_selection=="NHST") {
      ##currently no output if no options selected -- what would make sense?
      if (is.null(input$variable_selection)){

      } else {
        ##correct test depends on family so generate p-values based on F-test for Gaussian
        ##and Chi-squared for Poisson
        if (input$distribution_choice=="gaussian") {
          as.matrix(drop1(dragonmodel,test="F")[c(2:nrow(drop1(testglm,test="F"))),])
        } else if (input$distribution_choice=="poisson") {
          as.matrix(drop1(dragonmodel,test="Chisq")[c(2:nrow(drop1(testglm,test="Chisq"))),])
        }
      }
    ##if using information criteria - just give dredge output
    } else if (input$model_selection=="AIC") {
      dredged<-MuMIn::dredge(eval(parse(text=formula)))
      dredged
    ##glmnet elastic net not implemented yet
    } else {
    }
  }, include.rownames=T)
}

