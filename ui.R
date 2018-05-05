#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that predicts words based on input.
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CAPSTONE - TO PREDICT WORDS FOR INPUT"),
  

  sidebarLayout(
    sidebarPanel(
      textInput("inputText", "ENTER YOUR SENTENCE HERE",value = ""),
      submitButton('Submit'),
      hr(),
      h3("Hint:"),
      helpText("1 - You have to enter a partial sentence to show the next word prediction.", 
               hr(),
               "2 - After inputting and clicking submit button, the predict next word will be displayed.",
               hr(),
               "3 - Your input and the predicted word are showed in the text boxes on the right side. Please be patient!"),
      hr()
      
    ),
    
    # Show results
    mainPanel(
      h3("INTRODUCTION:"),
      h4("This application takes your input and will predict the next word."),
      hr(),
      h4('Words you entered : '),
      verbatimTextOutput("inputValue"),
      hr(),

      h4('Next word :'),
      verbatimTextOutput("prediction")    
    )
  )
))
