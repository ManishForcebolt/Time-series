# Time series Forecast models
install.packages(c("plotly","dplyr","ggplot2", "tidyverse", "tidyr","gt","forecast","lmtest","fpp2"))

library(plotly)
library(dplyr)
library(ggplot2)
library(tidyr)
library(gt)
library(forecast)
library(lmtest)
library(fpp2)

data("AirPassengers")
class(AirPassengers)

Y<-log(AirPassengers)
DY<-diff(log(AirPassengers))
ggtsdisplay(AirPassengers)

ggtsdisplay(Y)
ggtsdisplay(DY)

# Seasonality trend 
ggseasonplot(AirPassengers)+
  ggtitle("Seasonality in differences of cases")+
  ylab("Trend in No.Passengers")

ggseasonplot(Y)+
  ggtitle("Seasonality in differences of cases")+
  ylab("Trend in No.Passengers")

ggseasonplot(DY)+
  ggtitle("Seasonality in differences of cases")+
  ylab("Trend in No.Passengers")

##############################################################
#1. Method for forecast
#Seasonal naive method as benchmark method
#Residual sd: 3222.5244 
##############################################################

fit<-snaive(DY)    
print(summary(fit))
checkresiduals(fit)


##############################################################
#2. Method for forecast
#Exponential Smoothing Model method
#sigma or Residual sd: 0.1305
##############################################################
fit_ets<-ets(Y) 
print(summary(fit_ets))
checkresiduals(fit_ets)


##############################################################
#3. Method for forecast
#ARIMA Model method
# Residual SD = 3222.573
##############################################################
#fit_arima<-auto.arima(Y,d=1,D=1, stepwise = FALSE, approximation = FALSE, trace = TRUE) 
#print(summary(fit_arima))
#checkresiduals(fit_arima)

##############################################################
# Forecast Using ETS model
##############################################################
fcst<-forecast(fit, h=12)
autoplot(fcst, include = 12)


fcst<-forecast(fit_ets)
autoplot(fcst, include = 10*12)

