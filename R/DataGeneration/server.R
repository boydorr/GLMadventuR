library("shiny")

function(input, output) {
  
  dragons = data.frame(
    sheep = rnorm(input$sample_size, mean = 10, sd = 3), # no of sheep per km2
    hunting = rep(c("low", "mid", "high"), length = input$sample_size), # diff levels of hunting
    unicorn = rnorm(input$sample_size, mean = 5, sd = 1), # no of unicorns per km2
    vegetation_height = rnorm(input$sample_size, mean = 100, sd = 10) # vegetation height in cm
  )
  
  if(input$response_variable == "mass"){
    mass = 500 + 2.5*dragons$sheep + (dragons$hunting == "mid")*-8 + (dragons$hunting == "high")*-16
    dragons = cbind(mass, dragons)
  }
  
  
  if(input$response_variable == "count"){
    count = round(20 + 0.3*dragons$sheep + (dragons$hunting == "mid")*-1 + (dragons$hunting == "high")*-2)
    dragons = cbind(count, dragons)

    }
  
  
  output$response = renderText({
    paste("You have chosen", dragons$hunting[1])
  
    })
  

}
