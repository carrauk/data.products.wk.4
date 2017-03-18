library(shiny)
library(datasets)

## @knitr shiny.server
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
        model <- function(){
                data("ChickWeight"); data <- ChickWeight;
                names(data) <- tolower(names(data))
                # create model on subset of data
                mdl <- lm(weight ~ time, data=data[data$diet==input$in.diet,])
                return(mdl)
        }
        
  output$out.plot <- renderPlot({
    # get model
    mdl <- model()
    # generate plot
    plot(predict(mdl, data.frame(time=c(1:22))),
         type="b",
         col="blue",
         main=sprintf("Predicted weight for chick on experimental diet %s",input$in.diet),
         xlab="time on diet (days)",
         ylab="Weight (gm)")
    
    # add abline to predicted weight based on parameters
    abline(v=input$in.days.on.diet,col="red")
    abline(h=predict(mdl, data.frame(time=c(input$in.days.on.diet))),col="red")
  })
  
  output$out.diet <- renderText({
          sprintf("Diet selected: [experimental diet %s]", input$in.diet)
  })
  
  output$out.days.on.diet <- renderText({
          sprintf("Days on Diet : [%s]", input$in.days.on.diet)
  })
  
  output$out.pred.weight <- renderText({
          pred.wt <- predict(model(), data.frame(time=c(input$in.days.on.diet)))
          sprintf("Predicted weight (gm) : [%s]", pred.wt)
  })
  
  output$out.intro <- renderText({
          paste0("This app predicts chick weights based on the ChickWeight ", 
              "dataset available in the datasets package within R.",
              "You just need to select which diet the chick is on and the time the chick was on the diet."
              )
  })
  
  
})
