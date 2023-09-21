# Load the required library and dataset
library(datasets)
library(zoo)

data("AirPassengers")
class(AirPassengers)
start(AirPassengers)
end(AirPassengers)

plot.ts(AirPassengers)
# For NA 
sum(is.na(AirPassengers))

# Summary of data
summary(AirPassengers)

#Observations of the time series data
# Decompose the data
tsdata<-ts(AirPassengers, frequency = 12)
summary(tsdata)
tsdata
plot(tsdata)

# Plot a Trendline on the Original Dataset
plot(tsdata)
abline(reg=lm(tsdata~time(tsdata)))

cycle(tsdata)
plot(tsdata, ylab="Passengers (1000s)", type="o")
# Create a Box Plot by Cycle
boxplot(tsdata~cycle(tsdata),main="Monthly boxplot from 1949-1960", xlab="Months", ylab = "Passenger Numbers (1000's)")

# Decomposing the tsdata
ddata<-decompose(tsdata, "multiplicative")
plot(ddata)
# Ploting separately
plot(ddata$trend)
plot(ddata$seasonal)
plot(ddata$random)

#Testing the stationarity of the data
#Augmented Dickey-Fuller Test
adf.test(tsdata) 

#Autocorrelation test
autoplot(acf(tsdata,plot=FALSE))+ labs(title="Correlogram of Air Passengers data") 
ddata$random
autoplot(acf(ddata$random[7:138],plot=FALSE))+ labs(title="Correlogram of Air Passengers Random Component") 



#Fitting the model
#Linear model
autoplot(tsdata) + geom_smooth(method="lm")+ labs(x ="Date", y = "Passenger numbers (1000's)", title="Air Passengers data") 


# generating ARIMA
mymodel <- auto.arima(AirPassengers)
mymodel
auto.arima(AirPassengers, ic="aic", trace = TRUE)


# Plot the Residuals
plot.ts(mymodel$residuals)

#Forecast the Values for the Next 10 Years
myforecast <- forecast(mymodel, level=c(95), h=12)

plot(myforecast)

myforecast

checkresiduals(mymodel)
