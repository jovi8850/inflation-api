SELECT *
FROM ML.EVALUATE(
  MODEL `inflation-project-012926.cpi_ml.inflation_xgb_model`,
  (
    SELECT * EXCEPT(date)
    FROM `inflation-project-012926.cpi_ml.test_split`
  )
);

SELECT *
FROM ML.EVALUATE(
  MODEL `inflation-project-012926.cpi_ml.inflation_xgb_model`,
  (
    SELECT * EXCEPT(date)
    FROM `inflation-project-012926.cpi_ml.test_split`
  )
);