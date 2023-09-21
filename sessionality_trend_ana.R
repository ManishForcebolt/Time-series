#######
# In this code:
# We load the "AirPassengers" dataset.
# We use the decompose() function to decompose 
# the time series into its seasonal, trend, and residual components.We then use 
# the plot() function to visualize each of these components separately.
# The "Seasonal Component" plot will show the repeating patterns or seasonality 
# in the data, while the "Trend Component" plot will represent the underlying trend. 
# The "Residuals (Random) Component" plot will show what's left after removing both 
# the seasonal and trend components, which ideally should look like white noise.
# This decomposition can help you better understand the underlying patterns in 
# your time series data and can be useful for further analysis or modeling, 
# such as forecasting with more advanced techniques like Seasonal Decomposition 
# of Time Series (STL) or Seasonal Auto regressive Integrated Moving Average (SARIMA) models.

########


# Load the required library and dataset
library(datasets)
data("AirPassengers")

# Decompose the time series
decomposed <- decompose(AirPassengers)

# Plot the decomposed components
par(mfrow = c(3, 1))  # Arrange plots in 3 rows and 1 column
plot(decomposed$seasonal, main = "Seasonal Component")
plot(decomposed$trend, main = "Trend Component")
plot(decomposed$random, main = "Residuals (Random) Component")
# Restore the default plotting layout
par(mfrow = c(1, 1))
