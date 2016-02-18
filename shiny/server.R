library(shiny)
library(caret)

modelRF <- readRDS("modelRF.rds")

makePrediction <- function(fixed.acidity, volatile.acidity, citric.acid, residual.sugar,
                           chlorides, free.sulfur.dioxide,total.sulfur.dioxide,
                           density, pH, sulphates, alcohol) 
{
    newData <- data.frame(fixed.acidity=fixed.acidity, 
                          volatile.acidity=volatile.acidity,
                          citric.acid=citric.acid, 
                          residual.sugar=residual.sugar,
                          chlorides=chlorides, 
                          free.sulfur.dioxide=free.sulfur.dioxide,
                          total.sulfur.dioxide=total.sulfur.dioxide, 
                          density=density, 
                          pH=pH, sulphates=sulphates, alcohol=alcohol)
    
    modelRF2 <<- modelRF
    quality <-  predict(modelRF2, newData)
    quality <- as.numeric(quality)
    #quality <-  runif(1, 1.0, 6)
}

#wine <- read.csv("winequality-white.csv", sep = ";", header = TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    plot(NA,xlim=c(0,100),ylim=c(0,100))


    
    output$plot1 <- renderPlot({
        plot(NA,xlim=c(0,100),ylim=c(0,100))

    })
    

    predictorValues <- reactive({
        data.frame(
            Predictor = c("fixed.acidity", 
                     "volatile.acidity",
                     "citric.acid",
                     "residual.sugar",
                     "chlorides",
                     "free.sulfur.dioxide",
                     "total.sulfur.dioxide",
                     "density",
                     "pH",
                     "sulphates",
                     "alcohol"),
            Value = c(input$fixed.acidity, 
                        input$volatile.acidity,
                        input$citric.acid,
                        input$residual.sugar,
                        input$chlorides,
                        input$free.sulfur.dioxide,
                        input$total.sulfur.dioxide,
                        input$density,
                        input$pH,
                        input$sulphates,
                        input$alcohol
                      ) 
            )
    }) 
    
    # Show the values using an HTML table
    output$values <- renderTable({
        predictorValues()
    })
    
    
    quality <- reactive({
        if (input$goButton == 0) {
            quality <- "No calculated"
        } else
        {
            withProgress(message = 'Calculation in progress',
                                           detail = 'wait...', value = 0,
                        {
                            #Sys.sleep(5)
                            isolate({
                            quality <- makePrediction(input$fixed.acidity, input$volatile.acidity, 
                                                      input$citric.acid, input$residual.sugar,
                                                      input$chlorides, input$free.sulfur.dioxide,
                                                      input$total.sulfur.dioxide, input$density, 
                                                      input$pH, input$sulphates, input$alcohol)    
                            })
                        })

        }
    })
    
    output$quality <- renderText({
        paste("Quality: ",quality())
    })
    
    output$qualityPlot <- renderPlot({
        
        # Render a barplot
        if (class(quality()) == "character") 
        {
            tmp <- 0
        }
        else
        {
            tmp <- quality()
        }
        barplot(tmp, ylim=c(0,10), col=6)
    })
})