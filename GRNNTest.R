library(shinydashboard)
library(shiny)
library(tsfgrnn)
library(dplyr)
library(lubridate)
library(ggplot2)
library(forecast)
library(tseries)
library(plotly)
library(xts)
dataset1 <- read.csv("dataset1.csv")
dataset1<-data.frame(dataset1)

# Date column correction
dataset1$Date<-ymd(dataset1$Date)

# Making date order ascending
mydata<- dataset1 %>% 
  dplyr::select(1,4,5,6) %>% 
  arrange(dataset1$Date) %>% 
  filter(dataset1$State=="Total")


####### Time Series Format
ts.data<-ts(mydata$Confirmed)

ui <- fluidPage(
  sliderInput("obs", "Number of observations:",
              min = 0, max = 100, value = 10),
  
  plotlyOutput("Plotfst1"),
  plotlyOutput("Plotfst2")
)

# Server logic
server <- function(input, output) {
  output$Plotfst1 <- renderPlotly({
    pred <- grnn_forecasting(ts.data, h = input$obs)
    autoplot(pred)
      })
  output$Plotfst2 <- renderPlotly({
    pred <- grnn_forecasting(ts.data, h = input$obs)
        autoplot(pred$prediction, col='red', lwd=1.5, xlab='Day (Time)', ylab='No. of Cases')
  })
  
  
  }

# Complete app with UI and server components
shinyApp(ui, server)
