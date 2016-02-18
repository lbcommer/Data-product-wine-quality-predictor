library(shiny)

ui <- navbarPage("Wine quality!",
                 tabPanel("Predict",fluidPage(

    titlePanel("Predicting wine quality"),
    fluidRow(
        column(width = 4, tableOutput("values")),
        column(width = 4,
               h1(textOutput("quality")),
               plotOutput("qualityPlot")
        ),
        column(width = 4, wellPanel(
            p("We are going to predict the quality of a wine with some params"),
            p("You can see the Help section in the upper menu"),
            #submitButton("Submit")
            actionButton("goButton", "Predict wine quality!")
            )
        )
    ),
    fluidRow(
        column(width = 3,
               sliderInput("fixed.acidity",
                           "fixed.acidity: ",
                           min = 1,
                           max = 15,
                           value = 7.4,
                           step = 0.1
                           )
        ),
        column(width = 3,
               sliderInput("volatile.acidity",
                           "volatile.acidity: ",
                           min = 0,
                           max = 3,
                           value = 0.24,
                           step = 0.01)
        ),
        column(width = 3,
               sliderInput("citric.acid",
                           "citric.acid: ",
                           min = 0,
                           max = 2,
                           value = 0.36,
                           step = 0.01)
        ),
        column(width = 3,
               sliderInput("residual.sugar",
                           "residual.sugar: ",
                           min = 0,
                           max = 100,
                           value = 2,
                           step = 0.1)  
        )
    ),
    fluidRow(
        column(width = 3,
               sliderInput("chlorides",
                           "chlorides: ",
                           min = 0,
                           max = 0.5,
                           value = 0.031,
                           step = 0.01)
        ),
        column(width = 3,
               sliderInput("free.sulfur.dioxide",
                           "free.sulfur.dioxide: ",
                           min = 1,
                           max = 300,
                           value = 27,
                           step = 1)
        ),
        column(width = 3,
               sliderInput("total.sulfur.dioxide",
                           "total.sulfur.dioxide: ",
                           min = 1,
                           max = 500,
                           value = 139,
                           step = 1)
        ),
        column(width = 3,
               sliderInput("density",
                           "density: ",
                           min = 0.01,
                           max = 3,
                           value = 0.99,
                           step = 0.01)  
        )
    ),
    fluidRow(
        column(width = 3,
               sliderInput("pH",
                           "pH: ",
                           min = 1,
                           max = 5,
                           value = 3.28,
                           step = 0.01)
        ),
        column(width = 3,
               sliderInput("sulphates",
                           "sulphates: ",
                           min = 0.1,
                           max = 2,
                           value = 0.48,
                           step = 0.01)
        ),
        column(width = 3,
               sliderInput("alcohol",
                           "alcohol: ",
                           min = 5,
                           max = 20,
                           value = 12.5,
                           step = 0.5)
        )
    )
)),
tabPanel("Help",fluidPage(titlePanel("Help"),
                          fluidRow(
                              p("This app lets you to predice the quality of a wine through some properties."),
                          p("You can set the value of the known properties of the wine with the sliders at the bottom
                            and push the button 'Predict wine quality!'.
                            A categorical prediction will be done: a level between 0 and 10. Bigger integer number
                            means better quality."),
                          p("The more influential properties are alcohol and density."),
                          p("When the button is pressed the app execute a model prediction based on Random Forest.
                            The model is the result of the training with the dataset 'Wine Quality Data Set' from UCI: "),
                          a(href="https://archive.ics.uci.edu/ml/datasets/Wine+Quality", target="_blank", "https://archive.ics.uci.edu/ml/datasets/Wine+Quality"),
                          p("The model was built offline, because it takes time, and saved as a RDS file."),
                          p("The prediction is done only when the button is pressed: changes in the sliders are ignored
                            util button is pressed, but they update the left table to display the whole set of values"),
                          br(),
                          p("The code can be shown in github: "),
                          a(href="https://github.com/lbcommer/Data-product-wine-quality-predictor.git", target="_blank", "https://github.com/lbcommer/Data-product-wine-quality-predictor.git")
                          
                          )))
)