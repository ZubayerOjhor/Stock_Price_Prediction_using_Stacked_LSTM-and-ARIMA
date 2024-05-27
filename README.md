Stock Price Prediction Using Stacked LSTM and ARIMA Models

Objective

This project aims to predict stock prices using two different time series forecasting models: Stacked Long Short-Term Memory (LSTM) networks and the AutoRegressive Integrated Moving Average (ARIMA) model.

Approach

Data Collection: Collected Microsoft (MSFT) stock data from January 2015 to May 2024 using the Tiingo API.

Model Development: Developed a Stacked LSTM model in Python and an ARIMA model in R.

Evaluation: Evaluated both models' performance on a test dataset and compared their Root Mean Squared Error (RMSE).

Visualization: Visualized the actual stock prices and predictions from both models.

Future Prediction: Forecasted future 15 days stock prices using both models.

Results
RMSE Comparison:

Stacked LSTM: 9.6098

ARIMA(6,1,6): 16.95333

Stacked LSTM outperformed ARIMA with a lower RMSE.
Conclusion

This project demonstrates the effectiveness of Stacked LSTM and ARIMA models for stock price prediction. While Stacked LSTM excels in capturing complex temporal patterns, ARIMA provides a robust framework for forecasting. Understanding their strengths and weaknesses is crucial for choosing the appropriate model for different scenarios.

