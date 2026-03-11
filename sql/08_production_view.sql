CREATE OR REPLACE VIEW `inflation-project-012926.cpi_ml.production_forecast` AS
SELECT
  predicted_target_inflation AS forecast_mom_inflation,
  CURRENT_TIMESTAMP() AS prediction_timestamp
FROM
  ML.PREDICT(
    MODEL `inflation-project-012926.cpi_ml.inflation_xgb_model`,
    (
      SELECT * EXCEPT(target_inflation, date)
      FROM `inflation-project-012926.cpi_ml.training_data`
      ORDER BY date DESC
      LIMIT 1
    )
  );