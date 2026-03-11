# Inflation Forecast API

## Project Summary

This project builds and deploys a production-ready inflation forecasting application on Google Cloud Platform (GCP). The application predicts **1-month-ahead monthly headline inflation (MoM CPI inflation)** using a **BigQuery ML boosted tree regression model** trained on U.S. Bureau of Labor Statistics (BLS) CPI data.

The system includes:

- **BigQuery** for data storage, feature engineering, and model training
- **BigQuery ML** for machine learning model creation and prediction
- **FastAPI** for serving predictions through a REST API
- **Google App Engine** for hosting the live API
- **GitHub Actions** for continuous deployment (CI/CD)
- **Cloud Monitoring and Cloud Logging** for production monitoring and observability

---

## Business / Analytics Objective

The objective of this project is to forecast short-term inflation by transforming CPI time-series data into a machine learning feature set and serving predictions through a production API. The final model predicts the next month’s MoM headline inflation rate using engineered lag-based CPI sector features.

---

## Data Source

The primary data source is the public BLS CPI dataset available in BigQuery:

- `bigquery-public-data.bls.cpi_u`

The project filters the data to:

- **seasonally adjusted series only**
- **3-character CPI sector groupings**
- **monthly observations**

---

## ML Methodology

### Target
- **1-month-ahead monthly headline inflation**
- Headline CPI represented through the sector-based CPI feature engineering process

### Feature Engineering
The model uses:

- monthly log inflation
- 3-character CPI sector aggregation
- lagged inflation features
- headline autoregressive structure
- sector-level historical inflation patterns

### Model
- **BigQuery ML Boosted Tree Regressor**

### Evaluation
The final model was evaluated against a naive benchmark and outperformed the naive forecast in mean absolute error (MAE), making it suitable for production deployment.

---

## Production Architecture

```text
Local Development (PowerShell / File Explorer)
        |
        v
GitHub Repository
        |
        v
GitHub Actions CI/CD
        |
        v
Google App Engine REST API
        |
        v
BigQuery Production View
        |
        v
BigQuery ML Forecast Model