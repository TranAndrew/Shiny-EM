## Toy Shiny Example

#install.packages("shiny")
#install.packages("tigerstats")
library(shiny)
library(tigerstats)
ui <- fluidPage(

  sliderInput(inputId = "meanHead", 
              label = "Mean of Heads", 
              min = 0, max = 10, value = 2),
  
  sliderInput(inputId = "meanTail", 
              label = "Mean of Tails", 
              min = 0, max = 10, value = 7),
  
  sliderInput(inputId = "nFlips", 
              label = "Number of Flips", 
              min = 1, max = 10000, value = 1000),
  
  plotOutput(outputId = "flipDistribution")
  
)
server <- function(input, output){
  
#  coinFlips <- matrix(data = NA, ncol = 2, nrow = input$nFlips)
#  tau_Heads <- input$meanHead/10 

#  for(runs in 1:input$nFlips)
#  for( i in 1:nFlips ) {
#    if( runif(1) < tau_1_true ) {
#      coinFlips[runs,1] <- rnorm(1, mean=input$meadHead)
#      coinFlips[runs,2] <- "heads"
#    } else {
#      x[i] <- rnorm(1, mean=input$meanTail)
#      y[i] <- "tails"
#    }
#  }

  
  output$flipDistribution <- renderPlot({
    
    tau_1_true <- 0.25
    x <- y <- rep(0,length(input$nFlips))
    for( i in 1:input$nFlips ) {
      if( runif(1) < tau_1_true ) {
        x[i] <- rnorm(1, mean= input$meanHead)
        y[i] <- "heads"
      } else {
        x[i] <- rnorm(1, mean= input$meanTail)
        y[i] <- "tails"
      }
    }
    
    
    densityplot( ~x, 
               par.settings = list(
                 plot.symbol = list(
                   col=as.factor(y)
                 )
               )
            )
    
    })
  
  
  
}
shinyApp(ui = ui, server = server)

