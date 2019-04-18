library("shiny")
library(ggplot2)

source("TextAdventure.R")
function(input, output, session) {

  tab_id <- c("Intro", "ExperimentalDesign", "WeightVsCount", "VisualiseData")

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
    output$plot = renderPlot({
      if (input$variable_selection == "hunting"){
        ggplot(data = dragons()) +
          geom_boxplot(aes_string(y = input$response_variable, x = input$variable_selection)) +
          ylab(input$response_variable) + xlab(input$variable_selection)
      }else{
        ggplot(data = dragons()) +
          geom_point(aes_string(y = input$response_variable, x = input$variable_selection)) +
          ylab(paste(input$response_variable)) + xlab(input$variable_selection)}
    })

}
