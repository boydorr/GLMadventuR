library("shiny")

prepDistroSVP <- function(distroType){
    n <- 1000
    mmean <- 10
    mstd <- 3
    myNormal <- rnorm(n,mmean,mstd)
    myPoisson <- rpois(n,mmean)
    myDistro <- myPoisson
    if (distroType == 1){
        myDistro <- myNormal
    }
    return(myDistro)
}

function(input, output) {
    output$plot1 <- renderPlot({
        hist(prepDistroSVP(input$distroRadio))
    })
}
