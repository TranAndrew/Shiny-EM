library(shiny)

fluidPage(
  titlePanel("EM Algorithm in R -- Probability Project"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file', 'Choose CSV File'),
      checkboxInput('header', 'Header', TRUE),
      tags$hr(),
      numericInput("numofmodes", "Number of Modes:", min = 1, value = 1),
      numericInput("pickcolumn", "Pick the Column:", min = 1, value = 1),
      numericInput("value", "Max Likelihood:", min = 1, value = 1),
      sliderInput("bins", "Number of bins:",min = 1,max = 50,value = 30),
      tags$hr(),
      submitButton("Update View")
    ),
    
    mainPanel(
      uiOutput('content'),
      tabsetPanel(tabPanel("Data",tableOutput("obs")),
                  tabPanel("Summary",verbatimTextOutput("summary")),
                  tabPanel("Data Selected",verbatimTextOutput("ds")),
                  tabPanel("Model Selection",plotOutput("modelsel")),
                  tabPanel("Visualisation",plotOutput("visual")))
    )
  )
)