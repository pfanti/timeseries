# Load libraries
library(tidyverse)
library(fpp3)
library(rbcb) # To get Selic data from Central Bank of Brazil

# 1. Fetching Data
# Get SP IPCA (Inflation) and Selic (Interest Rate)
sp_ipca <- get_sidra(api = "/t/7060/n7/3550308/v/63/p/all/c315/7169/d/v63%202") %>%
  mutate(Month = yearmonth(Mês_Código)) %>%
  as_tsibble(index = Month) %>%
  select(Month, ipca = Valor)

selic <- get_series(c(selic = 432), last = nrow(sp_ipca)) %>%
  mutate(Month = yearmonth(date)) %>%
  as_tsibble(index = Month)

# 2. Join Datasets
data_combined <- sp_ipca %>%
  left_join(selic, by = "Month") %>%
  fill(selic, .direction = "down")

# 3. Modeling with Exogenous Variable (ARIMAX)
fit_dynamic <- data_combined %>%
  model(
    base_arima = ARIMA(ipca),
    dynamic_arima = ARIMA(ipca ~ selic) # Selic as an external predictor
  )

# 4. Scenario Forecasting
# To forecast IPCA, we must provide a "scenario" for what Selic will be
future_scenarios <- new_data(data_combined, 12) %>%
  mutate(selic = 10.50) # Assuming Selic stays at 10.50%

fc_dynamic <- fit_dynamic %>% forecast(new_data = future_scenarios)

# 5. Reviewing the impact (Coefficients)
report(fit_dynamic %>% select(dynamic_arima))
