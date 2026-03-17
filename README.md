## 📉 Economic Time Series Analysis: São Paulo Region

### Executive Summary
This project implements a predictive framework for São Paulo's economic indicators. The goal is to provide data-driven insights for strategic planning and fiscal forecasting using state-of-the-art statistical methods in R.

### Technical Approach
- **Stationarity & Differencing:** Applied Augmented Dickey-Fuller (ADF) tests to ensure the series is stationary before ARIMA modeling.
- **Model Selection:** Utilized the **AICc (Akaike Information Criterion corrected)** to automatically select the best parameters for the ARIMA $(p, d, q)$ and ETS $(A, N, N)$ models.
- **Decomposition:** Used **STL Decomposition** (Seasonal and Trend decomposition using Loess) to isolate the underlying economic trend from seasonal fluctuations (e.g., end-of-year retail spikes).

### Business Impact
- **Budget Planning:** Accurate forecasts allow for better allocation of resources based on expected inflation or growth.
- **Risk Mitigation:** By identifying seasonal patterns, the organization can prepare for cyclical downturns in the São Paulo market.
