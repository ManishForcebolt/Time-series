# Load the required library and dataset
library(datasets)
data("AirPassengers")

# Check the structure of the dataset
str(AirPassengers)
head(AirPassengers,12) 
class(AirPassengers)
start(AirPassengers)
end(AirPassengers)

summary(AirPassengers)

#### Plot the time series data
plot(AirPassengers, main = "Airline Passenger Vs Time Data", ylab = "Passenger Count")
abline(lm(AirPassengers~time(AirPassengers))) 
# Plot shows: Mean of the data is increasing and so is the variance.

#### Decomposition plots
plot(decompose(AirPassengers))

#### Cyclic pattern
boxplot(AirPassengers~cycle(AirPassengers))

### Now we can see data has trend, seasonality and cycle as well. So we
# need to make it stationary for applying forecast models
# 1. we will make variance equal using plot of log function
par(mfrow = c(1, 2))  # Arrange plots in 1 rows and 2 column
plot(AirPassengers)
abline(lm(AirPassengers~time(AirPassengers))) 
plot(log(AirPassengers))
abline(lm(log(AirPassengers)~time(log(AirPassengers))))
#Obs will show that variance will became equal this time
par(mfrow = c(1, 1))  # Arrange plots in 3 rows and 1 column

# 2. We will make the mean constant too using diff() function
D1<-diff(log(AirPassengers))
log(AirPassengers)
D1
plot(D1)
abline(lm(D1~time(D1)))
# Thus we have changed the Non-stationary data to stationary ts data


# Now that you have stationary data, you can select an appropriate ARIMA model. 
#To do this, you'll need to determine the values of p, d, and q in the ARIMA(p, d, q) model. 
#This can be done using the ACF (AutoCorrelation Function) and 
#PACF (Partial AutoCorrelation Function) plots.
#### Now we can create ARIMA model for the same.
### AR(p) I(d) MA(q)
## For 'q' we will do the ACF test: 

acf(AirPassengers) # ACF on original data
acf(D1) # q=1

D2<-diff(D1)
acf(D2)

## For 'p' value we will plot PACF
pacf(AirPassengers)
pacf(D1) # p=0

## Now the value of 'd' = 1. As we used diff() once.
# Fit the ARIMA model

library(forecast)
model <- arima(log(AirPassengers), c(0,1,1), seasonal = list(order=c(0,1,0),period=12))
# Summary of the model
summary(model)
pred_log_values<-predict(model,5*12)
pred_values<- 2.718^pred_log_values$pred
pred_values


# Residuals analysis
residuals <- residuals(model)
acf(residuals, main = "ACF of Residuals")
pacf(residuals, main = "PACF of Residuals")

# Make forecasts
ts.plot(AirPassengers,pred_values, log="y",lty=c(1,3), col=c("blue","red"), main="Forecasted Values")


# Validation of test
checkresiduals(model)

#Residual Plot (ACF and PACF): 
# The checkresiduals() function displays two plots 
# side by side. On the left, you'll see the autocorrelation function (ACF) plot 
# of the residuals. This plot helps you assess whether there are any significant 
# autocorrelations left in the residuals, which could indicate that your model 
# is missing some important patterns. On the right, you'll see the partial 
# autocorrelation function (PACF) plot of the residuals, which can help identify 
# any remaining AR patterns in the residuals.

#Ljung-Box Test: 
# This statistical test is performed on the residuals to assess whether they 
# exhibit significant autocorrelations at various lags. The test is used to 
# check whether the residuals are white noise. The p-value from the 
# Ljung-Box test is displayed, and a small p-value suggests that the residuals 
# are not white noise, indicating that the model might need further refinement.

Box.test(model$resid, lag=5, type="Ljung-Box")
Box.test(model$resid, lag=10, type="Ljung-Box")
Box.test(model$resid, lag=15, type="Ljung-Box")


library(tsfgrnn)
library(dplyr)
library(lubridate)
library(ggplot2)
library(forecast)
library(tseries)
library(plotly)
library(xts)

pred <- grnn_forecasting(AirPassengers, h = 10*12)
autoplot(pred)

pred1 <- grnn_forecasting(AirPassengers, h = 5*12)
  autoplot(pred1$prediction, col='red', lwd=1.5, xlab='Year', ylab='No. Passengers')
