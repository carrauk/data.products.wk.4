#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
## @knitr shiny.ui
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict chick weight"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("in.diet",
                   "Select Diet:",
                   choices=c("experimental diet 1" = "1",
                             "experimental diet 2" = "2",
                             "experimental diet 3" = "3",
                             "experimental diet 4" = "4")
                   ),
       
       sliderInput("in.days.on.diet",
                   "Select days on diet:",
                   min=0, max=21, value=14
                   )
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h4("Introduction to the application"),
       textOutput("out.intro"),
       h4("Parameters entered (and resulting prediction)"),
       textOutput("out.diet"),
       textOutput("out.days.on.diet"),
       textOutput("out.pred.weight"),
       plotOutput("out.plot")
    )
  )
))
