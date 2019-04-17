library("shiny")


function(input, output) {
  

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

}
