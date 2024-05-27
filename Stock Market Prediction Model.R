# Set the working directory
setwd("G:/Works/Completed Projects/Stock Market/R")

# Read the CSV file
data <- read.csv("MSFT.csv")

# Display the first few rows of the dataset
head(data)
View(data)
data
# Convert 'date' column to Date format
data$date <- as.Date(data$date, format = "%d-%m-%y")

# Plot the time series
plot(data$date, data$close, type = "l", 
     main = "Time Series Plot of Close Price of Microsoft Stocks",
     xlab = "Year", ylab = "Closing Price")


# Calculate the number of rows for training and testing
train_rows <- round(nrow(data) * 0.7)  # 70% for training
test_rows <- nrow(data) - train_rows   # Remaining 30% for testing
train_rows
# Split the dataset into training and testing
train_data <- data[1:train_rows, ]  # First 70% rows for training
test_data <- data[(train_rows + 1):nrow(data), ]  # Remaining rows for testing

train_data$date <- as.Date(train_data$date, format = "%d-%m-%y")
test_data$date <- as.Date(test_data$date, format = "%d-%m-%y")

# Extract year and month from the first date in the dataset
start_year_train <- as.numeric(format(train_data$date[1], "%Y"))
start_month_train <- as.numeric(format(train_data$date[1], "%m"))
start_year_test <- as.numeric(format(test_data$date[1], "%Y"))
start_month_test <- as.numeric(format(test_data$date[1], "%m"))

# Create time series objects
train_ts <- ts(train_data$close, start = c(start_year_train, start_month_train), frequency = 365)
test_ts <- ts(test_data$close, start = c(start_year_test, start_month_test), frequency = 365)

# Check the lengths of the train and test data
length(train_ts)
length(test_ts)
plot(train_ts)
plot(test_ts)

library(tseries)
library(forecast)

#Stock ARIMA Model using Auto Arima Function
Stock_ARIMA=auto.arima(train_ts)
Stock_ARIMA
#ARIMA(5,2,0) #AIC=7687.99   AICc=7688.04   BIC=7720.42

### Residuals Diagnostic
library(itsmr)
test(Stock_ARIMA$residuals)

Stock_ARIMA2=Arima(train_ts, order = c(6, 1, 6))
Stock_ARIMA2
#ARIMA(6,1,6)#AIC=7330.61   AICc=7330.83   BIC=7400.9
test(Stock_ARIMA2$residuals)

##Forecasting Model 1
n=length(test_ts)
forecast_Stock_ARIMA <- forecast::forecast(Stock_ARIMA,h=n)
plot(forecast_Stock_ARIMA)
forecast_Stock_ARIMA$mean

### Calculating Forecasting Accuracy Measures
M1=forecast::forecast(Stock_ARIMA, h=n)$mean
err=test_ts - M1
ME=sum(err)/n
print(ME)
MSE=sum(err^2)/n
print(MSE)
RMSE=sqrt(MSE)
print(RMSE)# 166.2498

#Stock_ARIMA2

##Forecasting Model 2


forecast_Stock_ARIMA2 <- forecast::forecast(Stock_ARIMA2,h=n)
plot(forecast_Stock_ARIMA2)
forecast_Stock_ARIMA2$mean

### Calculating Forecasting Accuracy Measures
M2=forecast::forecast(Stock_ARIMA2, h=n)$mean
err=test_ts - M2
ME=sum(err)/n
print(ME)
MSE=sum(err^2)/n
print(MSE)
RMSE=sqrt(MSE)
print(RMSE)#16.95333

##ARIMA (6,1,6) is a better model compared by AIC, AICc, BIC, Residual Assumption fulfillment and RMSE value.

plot(data)


## Create a complete sequence of dates
complete_dates <- seq(from = min(data$date), to = max(data$date), by = "day")

# Create a data frame with complete dates
complete_data <- data.frame(date = complete_dates)

# Merge with original data to get closing prices for all dates
complete_data <- merge(complete_data, data, by = "date", all.x = TRUE)

# Sort by date
complete_data <- complete_data[order(complete_data$date), ]

# Create time series object
data_ts <- ts(complete_data$close, start = min(complete_data$date), frequency = 365)

plot(data_ts)

install.packages("xts")
install.packages("forecast")
install.packages("ggplot2")
install.packages("scales")

library(xts)
library(forecast)
library(ggplot2)
library(scales)



# Convert to xts object
data_xts <- xts(data$close, order.by = data$date)

# Train the best model on the entire dataset
Stock_ARIMA_Model <- Arima(data_xts, order = c(6, 1, 6))

# Forecast 60 points ahead
forecast_result <- forecast::forecast(Stock_ARIMA_Model, h=15)

# Convert forecast to data frame for ggplot
forecast_df <- data.frame(
  date = seq(as.Date(max(data$date)) + 1, by = "day", length.out = 60),
  forecast = as.numeric(forecast_result$mean),
  lower = as.numeric(forecast_result$lower[, 2]),
  upper = as.numeric(forecast_result$upper[, 2])
)

# Combine actual data and forecast for plotting
actual_data <- data.frame(date = data$date, close = data$close, type = "Actual")
forecast_data <- data.frame(date = forecast_df$date, close = forecast_df$forecast, type = "Forecast")

# Plot original data and forecasted values
ggplot() +
  geom_line(data = actual_data, aes(x = date, y = close, color = type)) +
  geom_line(data = forecast_data, aes(x = date, y = close, color = type)) +
  geom_ribbon(data = forecast_df, aes(x = date, ymin = lower, ymax = upper), fill = "grey80", alpha = 0.5) +
  labs(title = "Microsoft (MSFT) Stock Prices- ARIMA (6,1,6) Prediction in R", x = "Date", y = "Closing Price") +
  scale_x_date(date_breaks = "6 months", date_labels = "%Y-%m") +
  theme_minimal() +
  theme(legend.position = "bottom")

forecast_result$mean