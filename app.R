library(shiny)
library(shinythemes)
suppressPackageStartupMessages({
    library(tidyverse)
    library(stringr)
})

source("ngram.R")

ui <- fluidPage(
    
    theme = shinytheme("superhero"),
    titlePanel("EC's Prediction Machine"),
    p("Type a phrase in the input box and get a prediction of the next word"),
    
    sidebarLayout(
        sidebarPanel(
            h4("Note: to improve computational efficiency, a lightweight database has been used, so a question mark could be displayed on some results."),
            h6("https://github.com/estebancarboni/Data-Science-Capstone")
           ),
        
        mainPanel(
            tabsetPanel(
                tabPanel(
                         textInput("user_input", 
                                   h3("Enter word/words and see the results"), 
                                   value = "Johns Hopkins"),
                         h3("Prediction"),
                         h3(em(span(textOutput("ngram_output"), 
                                    style = "color:red"))))
            )   
        )
    )
)

server <- function(input, output) {
    
    output$ngram_output <- renderText({
        ngrams(input$user_input)
    })
    
}

shinyApp(ui = ui, server = server)
