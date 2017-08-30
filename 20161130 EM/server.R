library(shiny)

function(input,output){
  
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()} 
    read.csv(file=file1$datapath, sep=",", header = input$header)
  })
 
  
  output$obs <- renderTable({
    if(is.null(data()))
    {return()}
    data()
  })
  output$summary <- renderPrint({
    if(is.null(data()))
    {return()}
    summary(data())
  })
  output$ds <- renderPrint({
    if(is.null(data()))
    {return()}
    data()[input$pickcolumn]
    #L(theta|x) = PI(f(x|theta)); theta  <- c(pi, mu, sigma); 
    #myData <- read.csv("faithful.csv"); myData <- myData$waiting
    myData <- data()[,input$pickcolumn]
    
    
    nModes = input$numofmodes
    piGuess = 0
    sigmaGuess = 0
    muGuess = 0
    # set.seed(143)
    
    for (i in 1:nModes) {
      piGuess[i] <- 1/nModes; # tau in website
      sigmaGuess[i] = sd(myData); 
      muGuess[i] = (max(myData)-min(myData))/(nModes+1)*i + min(myData); 
    }      
    
    #myData <- read.table()
    
    prob = matrix(0, nrow = length(myData), ncol = nModes)
    latentVariable = matrix(0, nrow = length(myData), ncol = nModes)
    distProb = matrix(0, nrow = length(myData), ncol = nModes)
    latentVariableSum = 0
    
    for (count in 1:150){
      
      for (nProb in 1:nModes){
        prob[,nProb] <- dnorm(myData, mean = muGuess[nProb])
      }
      
      latentVariableSum <- 0
      for (i in 1:nModes){
        latentVariable[,i] <- piGuess[i]*prob[,i] 
        latentVariableSum <- latentVariableSum + latentVariable[,i]
      }
      
      for (i in 1:nModes){
        distProb[,i] <- latentVariable[,i]/latentVariableSum
      }
      
      for (i in 1:nModes){
        piGuess[i] <- mean(distProb[,i])
        muGuess[i] <- sum(prob[,i]*myData)/sum(prob[,i])
        sigmaGuess[i] <- sum(piGuess[i]*(myData-muGuess[i])^2)/sum(piGuess[i])
        print(c('pi = ',piGuess[i],'mi','sigma'))
      }
    
    }
    
    logLikelihood <- function(data, mu, stdeviation){
      n <- length(data)
      logLikelihoodEq <- -n/2*log(2*pi) - n/2*log(stdeviation^2) - sum(((data - mu)^2)/(2*(stdeviation)^2))  # for normal ^2
      
      # output <- mle(minuslogl = logLikelihood, nobs = n)
      return(-logLikelihoodEq)
    }
    
    mle(minuslogl = logLikelihood,
        start = list(data = data, mu = mu, stdeviation = stdeviation),
        nobs = length(data))
    
  })
  
  output$modelsel <- renderPlot({
    if(is.null(data()))
    {return()}
    L <- input$value
    k <- input$numofmodes
    AIC <- 2*k - 2*log(L)
    abline(lm(k~AIC), col="red")
  })
  
  output$visual <- renderPlot({
    if(is.null(data()))
    {return()}
    x <- data()[,input$pickcolumn]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins,col = 'darkgray', border = 'white',main = "Histograms of the Data", xlab = "Data")
  })
  
  
  output$content <- renderUI({
    if(is.null(data()))
      h5("No dataset loaded!")
   # else
      #tabsetPanel(tabPanel("Data",tableOutput("obs")),tabPanel("Summary",verbatimTextOutput("summary")),
                 # tabPanel("AIC Function"),tabPanel("Visualisation"))
  })
  
}