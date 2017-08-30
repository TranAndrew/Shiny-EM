## Shiny App Tutorial
# Understanding architecture

# Using web browser/app to play with data that can be manipulated with R via a web application 
# Share app with cloud, using web server to run R. <my github account> 
# 
# Two components: UX(generated via R) and R instructions 

# code has UI component, server component, and ShinyApp component 
# TEMPLATE
install.packages("shiny")
library(shiny)
ui <- fluidPage()
server <- function(input, output){}
shinyApp(ui = ui, server = server)

# To change app, app must be killed, then add new changes 

## Building out app 10:46
# build around inputs and outputs from server function

ui <- fluidPage(
  # Add elements to the app as arguements to fluidPage()
  # *Input() functions,
  # *Output() functions
)
server <- function(input, output){}
shinyApp(ui = ui, server = server)

## Inputs
# *Input()

ui <- fluidPage(
  sliderInput(inputId = "num",
              label = "Choose a number",
              value = 25, min = 1, max = 100)
  # Buttons, sliders, test, inputs, radio buttons. Mouse click functions
  # *Input(inputId = * , label = "*Name of input type*",
  # additional information for that specific arguement input (ie sliderInput?))
)

## Outputs
# *Output()

# * = plot, or other name
# *Output("some name of the * name")
# ie plotOutput("hist")

# Recap 16:27

## Server - assemble inputs and outputs

server <- function(input,output){
  # Rules 1, 2, & 3
  ## 1) output value with output$
  # plotOutput("hist")
  #              |
  #              V
  #       output$hist <- *some code
  
  
  ## 2) Render function will output functions ie render*
  # renderPlot()...
  
  # example
  # renderPlot({hist(rnorm(100))}) ; 'plot' is object type, 
  #                                   braces allow user to put as many lines of code as needed
  
  ## 3) input values with input$*
  # sliderInput(inputId = "num")
  #                         |
  #                         V
  #                      input$num
  
  ## ex for reactivity of the app 
  # output$hist <- renderPlot({
  #   hist(rnorm(input$num))
  # })
  
}

## Recap 23:52
# 1) save output that youd build to output$
# 2) build output object with render*() function
# 3) access input values with input$ within render func
# reactivity will work with this 

# 02-hist-app.R 





