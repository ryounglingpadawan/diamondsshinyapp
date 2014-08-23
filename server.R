#load the load-once codes for the model here

library(ggplot2)
data(diamonds)

#data mungling
ddata<-diamonds[,1:7]
ddata<-ddata[,-(5:6)]
ddata$cut<-as.factor(as.character(ddata$cut))
ddata$color<-as.factor(as.character(ddata$color))
ddata$clarity<-as.factor(as.character(ddata$clarity))
ddata$price<-as.numeric(ddata$price)

# The actual model
fit.4C<-lm(log(price) ~ log(carat) + color + clarity + cut, data=ddata)
# summary(fit.4C) # adjusted r-sq: 0.9826

ModOut<-function(carat,color,clarity,cut)
  {
  user.input<-data.frame(carat,color,clarity,cut)
  user.input$carat<-as.numeric(user.input$carat)
 # print(user.input)
  PredFit<-predict(fit.4C,newdata=user.input, interval="prediction")
  round(exp(PredFit),2)
}


# this is the start of the shiny function
shinyServer(function(input, output) {

  output$carat <-renderText({
    paste("Carat: ",input$carat)
  })
  output$color<-renderText({
    paste("Color: ",input$color)
  })

  output$clarity<-renderText({
    paste("Clarity: ",input$clarity)
  })
  
  output$cut<-renderText({
    paste("Cut: ",input$cut)
  })

  output$prediction<-renderText({
    ModOut(input$carat, input$color, input$clarity, input$cut)[,1]
  })

  output$prediction.PI<-renderText({
    paste(ModOut(input$carat, input$color, input$clarity, input$cut)[,2],
          " to ",
          ModOut(input$carat, input$color, input$clarity, input$cut)[,3])
  })
    
})
