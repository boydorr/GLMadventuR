library("shiny")
library("xtable")
library("glmnet")

function(input, output) {
  ##read in data
  dragons <- read.csv("~/Desktop/git/GLMadventuR/R/DataGeneration/dragons.csv")
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
                      ", family = '",input$distribution_choice,"', data = dragons(), na.action=na.fail)")
    ##run command from string
    dragonmodel <- eval(parse(text=formula))
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
      dredged <- MuMIn::dredge(eval(parse(text=formula)))
      dredged
    ##if elastic net
    } else if (input$model_selection=="EL") {
      ##generate correct format for glmnet
      x <- as.matrix(dragons()[,colnames(dragons())%in%input$variable_selection])
      y <- dragons()[,1]
      ##cross validate to optimise alpha and lambda
      lambdaforseqalong <- exp(seq(from=-10, to=0, by=0.1))
      optim <- matrix(NA,nrow=101,ncol=101)
      alphasforseqalong <- seq(from=0, to=1, by=0.01)
      for (i in 1:101){
        optim[,i] <- cv.glmnet(x,y,nfolds=nrow(x),lambda = lambdaforseqalong,alpha=alphasforseqalong[i])$cvm
      }
      ##run model at optimal parameter values
      dragonmodel <- glmnet(x, y, family=input$distribution_choice, lambda=lambdaforseqalong[which(optim == min(optim), arr.ind=TRUE)[1]],
             alpha=alphasforseqalong[which(optim == min(optim), arr.ind=TRUE)[2]])
      ##generate matrix and print
      dragonmatrix <- as.matrix(dragonmodel$beta)
      row.names(dragonmatrix) <- vars
      colnames(dragonmatrix) <- "Coefficients"
      dragonmatrix
    }
  }, include.rownames=T)
}

