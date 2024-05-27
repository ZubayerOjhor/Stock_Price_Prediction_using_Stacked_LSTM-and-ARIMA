# Stock_Price_Prediction_using_Stacked_LSTM-and-ARIMA
Microsoft Stock Price (closing) Prediction using Stacked LSTM and ARIMA (6,1,6) models
Stock Price Prediction Using Stacked LSTM and ARIMA Models
Objective
The objective of this project is to develop and compare the effectiveness of two different time series forecasting models—Stacked Long Short-Term Memory (LSTM) networks and the AutoRegressive Integrated Moving Average (ARIMA) model—in predicting stock prices. The project involves data preprocessing, model development, training, evaluation, and visualization of results.

Data Collection and Preprocessing
Data collection through Tiingo API integration with Python.
Collected Microsoft (MSFT) stock data from January 2015 to May 2024.
Gathered historical stock price data including the date and closing prices.
Ensured proper data formatting, handled missing values, and sorted the dataset by date.
Stacked LSTM Model Development
Implemented a Stacked LSTM model using Python.
Preprocessed the data by normalizing the closing prices and creating sequences of past stock prices to predict future prices.
Designed the LSTM architecture with multiple LSTM layers to capture temporal dependencies.
Trained the model on the training dataset (70% of the data).
Evaluated the model's performance on the test dataset (30% of the data) using metrics such as Root Mean Squared Error (RMSE).
Visualized the predicted stock prices against actual prices to assess the model's accuracy.
Predicted future 15 days stock prices using the model.
ARIMA Model Development
Implemented the ARIMA model using R.
Converted the stock price data into a time series object, considering the frequency of observations.
Determined the optimal ARIMA model parameters (p, d, q), which is ARIMA(6,1,6).
Trained the model on the training dataset (70% of the data).
Evaluated the model's performance on the test dataset (30% of the data) using metrics such as RMSE.
Forecasted future 15 days stock prices using the model.
Compared the model's residuals against assumptions of independent and identically distributed (iid) noise to ensure the model's validity.
Comparison and Analysis
Compared the predictions from the Stacked LSTM model and the ARIMA model.
Analyzed the strengths and weaknesses of each approach in terms of prediction accuracy, model complexity, and computational requirements.
Discussed the suitability of each model for different types of stock price data and forecasting horizons.
Visualization and Results
Plotted the actual stock prices and the predictions from both models on the same graph to visualize the performance.
Highlighted key observations, such as periods where the models performed well or struggled.
RMSE Comparison
Model Performance Comparison Based on RMSE on Test Data

Stacked LSTM: 9.6098
ARIMA(6,1,6): 16.95333
Stacked LSTM is the better model in this scenario with a lower RMSE.

Conclusion
This project demonstrated the application of advanced machine learning techniques (Stacked LSTM) and classical statistical methods (ARIMA) for stock price prediction. By comparing these models, insights were gained into their respective capabilities and limitations. The Stacked LSTM model showed promise in capturing complex temporal patterns in stock prices, while the ARIMA model provided a robust and interpretable framework for time series forecasting.
