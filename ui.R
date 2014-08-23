library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Shiny: Predict Diamond Prices"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Hello!"),
      helpText("Use this Shiny App to predict diamond prices based on the 4Cs: 
               Carat, Color, Clarity, and Cut."), 
      p("Step 1: Please select your diamond's characteristics."),
            
      sliderInput("carat", 
                  label = "Select Carat:",
                  min = 0.2, max = 5.2, value=0.4),
      
      selectInput("color", 
                  label = "Select Diamond Color",
                  choices = list("D", "E", "F", "G", "H","I","J"),
                  selected = "F"),
      
      selectInput("clarity", 
                  label = "Select Diamond Clarity",
                  choices = list("I1", "SI1", "SI2", "VS1", "VS2","VVS1","VVS2","IF"),
                  selected = "VS1"),

      selectInput("cut", 
                  label = "Select Diamond Cut",
                  choices = list("Fair", "Good", "Very Good", "Premium", "Ideal"),
                  selected = "Good"),
      p("Step 2: Press the Submit Button for the Prediction"),
      submitButton("Submit")
                
      ),

    mainPanel(
      tabsetPanel(
          tabPanel("Main",
            h4("Your chosen diamond has the following characteristics"),
            verbatimTextOutput("carat"),
            verbatimTextOutput("color"),
            verbatimTextOutput("clarity"),
            verbatimTextOutput("cut"),
            br(),
            h4("Predicted Diamond Price in US$"),
            verbatimTextOutput("prediction"),
            p("95% Prediction Interval"),
            verbatimTextOutput("prediction.PI")
            ),
  
          tabPanel("Model Details",
                    p("This prediction model uses Hadley's ggplot2 package"),
                    code("library(ggplot2); data(diamonds)"),
                    p("This dataset is based on data from ", a("www.diamondse.info", href="http://www.diamondse.info"), " collected in ",
                      a("2008",
                        href="http://r.789695.n4.nabble.com/Year-of-data-collection-for-diamonds-dataset-in-ggplot2-td4506598.html",".")
                      ),
                   br(),
                   p("The model is a simple linear regression model of the following form:"),
                   code("model<-lm(log(price) ~ log(carat) + color + clarity + cut, data=diamonds)"),
                   p("The ui.R and server.R files for this app can be found here ",
                     a("on Github",href="https://github.com/ryounglingpadawan/diamondsshinyapp"))
                  ),
          
          tabPanel("Motivation",
                    p("This is a Shiny app prepared for the Coursera", 
                      em("Data Specialisation - Data Products",style="color:gray"),
                      "class.")
                   )
    )
  ) # end main Panel
) # end sidebarlayout
  
))