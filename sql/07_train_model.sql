CREATE OR REPLACE MODEL `inflation-project-012926.cpi_ml.inflation_xgb_model`
OPTIONS(
  MODEL_TYPE = 'BOOSTED_TREE_REGRESSOR',
  INPUT_LABEL_COLS = ['target_inflation'],
  MAX_ITERATIONS = 80,
  MAX_TREE_DEPTH = 5,
  LEARN_RATE = 0.07,
  SUBSAMPLE = 0.8,
  COLSAMPLE_BYTREE = 0.8
) AS
SELECT
  * EXCEPT(date)
FROM
  `inflation-project-012926.cpi_ml.training_split`;