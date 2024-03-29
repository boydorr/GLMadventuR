library("shiny")
library("ggplot2")
library("shiny")
library("xtable")
library("glmnet")
library("MuMIn")
library("tuneR")

setWavPlayer('/usr/bin/afplay')
roar = readMP3("roar.mp3")
source("TextAdventure.R")
function(input, output, session) {

  tab_id <- c("Intro", "ExperimentalDesign", "WeightVsCount", "VisualiseData", "ModelChoice", "ModelSelection")

  ## Next / previous
  observe({
    lapply(c("Next", "Previous"),
           toggle,
           condition = input[["tabs"]])
  })

  Current <- reactiveValues(
    Tab = "Intro"
  )

  observeEvent(
    input[["tabs"]],
    {
      Current$Tab <- input[["tabs"]]
    }
  )

  observeEvent(
    input[["Previous"]],
    {
      tab_id_position <- match(Current$Tab, tab_id) - 1
      if (tab_id_position == 0) tab_id_position <- length(tab_id)
      Current$Tab <- tab_id[tab_id_position]
      updateTabItems(session, "tabs", tab_id[tab_id_position])
    }
  )

  observeEvent(
    input[["Next"]],
    {
      tab_id_position <- match(Current$Tab, tab_id) + 1
      if (tab_id_position > length(tab_id)) tab_id_position <- 1
      Current$Tab <- tab_id[tab_id_position]
      updateTabItems(session, "tabs", tab_id[tab_id_position])
    }
  )

  ## Main story text
  output$setting_up_the_problem = renderText({
    paste(setting_up_the_problem)
  })
  output$experimental_design = renderText({
    paste(experimental_design)
  })
  output$weight_vs_count = renderText({
    paste(weight_vs_count)
  })
  output$visualise_your_data = renderText({
    paste(visualise_your_data)
  })
  output$model_family_selection = renderText({
    paste(model_family_selection)
  })

  ## Generate data
  dragons <- reactive({

    # generating some random data for the explanatory variables
    data <- data.frame(
      sheep = as.numeric(rnorm(input$sample_size, mean = 10, sd = 3)),
      hunting =  as.factor(rep(c("low", "mid", "high"), length = input$sample_size)),
      unicorn = as.numeric(rnorm(input$sample_size, mean = 5, sd = 1)),
      vegetation_height = as.numeric(rnorm(input$sample_size, mean = 100, sd = 10)))

    # generating mass response variable (probs want to adjust this)
    if(input$response_variable == "mass"){
      mass = 500 + 2.5*data$sheep + (data$hunting == "mid")*-8 + (data$hunting == "high")*-16
      data = cbind(mass, data)
    }

    # generating count response variable based on pre-defined relationship (probs want to adjust this)
    if(input$response_variable == "count"){
      count = round(20 + 0.3*data$sheep + (data$hunting == "mid")*-1 + (data$hunting == "high")*-2)
      data = cbind(count, data)
    }

    data

  })
    output$table <- renderDataTable(dragons())
  # Visualise data
    output$plot1 = renderPlot({
      if (input$plot_selection == "hunting"){
        ggplot(data = dragons()) +
          geom_boxplot(aes_string(y = input$response_variable, x = input$plot_selection)) +
          ylab(input$response_variable) + xlab(input$plot_selection)
      }else{
        ggplot(data = dragons()) +
          geom_point(aes_string(y = input$response_variable, x = input$plot_selection)) +
          ylab(paste(input$response_variable)) + xlab(input$plot_selection)}
    })

    ## Model Selection process
    prepDistroSVP <- function(distroType, n, mmean, mstd, mlambda){
      myNormal <- rnorm(n,mmean,mstd)
      myPoisson <- rpois(n,mlambda)
      myDistro <- myPoisson
      if (distroType == "gaussian"){
        myDistro <- myNormal
      }
      return(myDistro)
    }
    plot <- reactiveValues(
      vals = "gaussian",
      warn = "",
      mean = 0,
      var = 0,
      lambda = 0,
      n = 10
    )
    output$moreControls <- renderUI({
      if (input$distroRadio == "gaussian"){
        sliderInput("mean", "Mean", 1, 100, 25)
      } else {
        sliderInput("lambda", "Lambda", 1, 100, 25)
      }})
    output$moreControls2 <- renderUI({
      if (input$distroRadio == "gaussian"){
        sliderInput("var", "Variance", 1, 100, 5)
      }})
    output$plot2 <- renderPlot({
      plot$vals <- input$distroRadio
      if (!is.null(input$mean)){
        plot$mean <- input$mean
      }
      if (!is.null(input$var)){
        plot$var <- input$var
      }
      if (!is.null(input$lambda)){
        plot$lambda <- input$lambda
      }
      plot$n <- input$n
      hist(prepDistroSVP(plot$vals, plot$n, plot$mean, plot$var, plot$lambda),
           main = paste("Example of", input$distroRadio, "distribution"),
           xlab= "Data values")
    })
    output$warning_message <- renderText({
      if (input$distroRadio == "gaussian" && input$response_variable == "count"){
        play(roar)
        normal_for_count
      }else if (input$distroRadio == "poisson" && input$response_variable == "mass"){
        play(roar)
        poisson_for_mass
      }else{
        paste("")
      }})
    output$distribution_choice <- renderText({
      if (plot$vals == "gaussian"){
        "Gaussian - the Gaussian, or normal, distribution has seperate arguments for the mean and variance and
describes integer and non-integers numbers. It can go above and below zero."
      }else{
        "Poisson - the Poisson is a discrete, positive distribution with the same mean and variance. Discrete
means it describes whole numbers, and positive means it is bounded by zero."
             }
    })

    ## Model Selection

    output$modelcommand = renderTable({
      ##generate list for correct glm formlula from inputted variables
      if (is.null(input$variable_selection)){
        vars <- 1
      } else {
        vars <- paste(input$variable_selection, collapse = " + ")
      }
      dragonsdata = dragons()
      ##glm command as string
      formula <- paste0("glm(", input$response_variable, " ~ ", vars,
                        ", family = '",input$distroRadio,"', data = dragonsdata, na.action=na.fail)")
      ##run command from string
      dragonmodel <- eval(parse(text=formula))
      ##if NHST
      if (input$model_selection=="NHST") {
        ##currently no output if no options selected -- what would make sense?
        if (is.null(input$variable_selection)){

        } else {
          ##correct test depends on family so generate p-values based on F-test for Gaussian
          ##and Chi-squared for Poisson
          if (input$distroRadio=="gaussian") {
            as.matrix(drop1(dragonmodel,test="F")[c(2:nrow(drop1(dragonmodel,test="F"))),])
          } else if (input$distroRadio=="poisson") {
            as.matrix(drop1(dragonmodel,test="Chisq")[c(2:nrow(drop1(dragonmodel,test="Chisq"))),])
          }
        }
        ##if using information criteria - just give dredge output
      } else if (input$model_selection=="AIC") {
        dredged <- MuMIn::dredge(eval(parse(text=formula)))
        dredged
        ##if elastic net
      } else if (input$model_selection=="EN") {
        # if (length(input$variable_selection) >2){
        # ##generate correct format for glmnet
        # x <- as.matrix(dragons()[,colnames(dragons())%in%input$variable_selection])
        # y <- dragons()[,1]
        # ##cross validate to optimise alpha and lambda
        # lambdaforseqalong <- exp(seq(from=-10, to=0, by=0.1))
        # optim <- matrix(NA,nrow=101,ncol=101)
        # alphasforseqalong <- seq(from=0, to=1, by=0.01)
        # for (i in 1:101){
        #   optim[,i] <- cv.glmnet(x,y,nfolds=nrow(x),lambda = lambdaforseqalong,alpha=alphasforseqalong[i])$cvm
        # }
        # ##run model at optimal parameter values
        # dragonmodel <- glmnet(x, y, family=input$distroRadio, lambda=lambdaforseqalong[which(optim == min(optim), arr.ind=TRUE)[1]],
        #                       alpha=alphasforseqalong[which(optim == min(optim), arr.ind=TRUE)[2]])
        # ##generate matrix and print
        # dragonmatrix <- as.matrix(dragonmodel$beta)
        # row.names(dragonmatrix) <- vars
        # colnames(dragonmatrix) <- "Coefficients"
        # dragonmatrix
        # }
        }
    }, include.rownames=T)

    output$report <- downloadHandler(
      # For PDF output, change this to "report.pdf"
      filename = "report.html",
      content = function(file) {
        # Copy the report file to a temporary directory before processing it, in
        # case we don't have write permissions to the current working dir (which
        # can happen when deployed).
        tempReport <- file.path(tempdir(), "report.Rmd")
        file.copy("report.Rmd", tempReport, overwrite = TRUE)
        params <- list(response = input$response_variable)
        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        rmarkdown::render(tempReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
      }
    )
}
