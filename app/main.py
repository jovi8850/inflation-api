from fastapi import FastAPI
from google.cloud import bigquery
import os

app = FastAPI()

PROJECT_ID = "inflation-project-012926"
DATASET = "cpi_ml"
VIEW = "production_forecast"

client = bigquery.Client(project=PROJECT_ID)

@app.get("/forecast")
def get_forecast():
    query = f"""
        SELECT *
        FROM `{PROJECT_ID}.{DATASET}.{VIEW}`
    """
    
    results = client.query(query).result()
    
    for row in results:
        return {
            "forecast_mom_inflation": row.forecast_mom_inflation,
            "prediction_timestamp": str(row.prediction_timestamp)
        }

    return {"error": "No prediction available"}