CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.cpi_base` AS
SELECT
  DATE(year, CAST(SUBSTR(period, 2) AS INT64), 1) AS date,
  series_id,
  SUBSTR(series_id, 9, 3) AS sector3,
FROM
  `bigquery-public-data.bls.cpi_u`
WHERE
  SUBSTR(series_id, 3, 1) = 'S'
  AND period LIKE 'M%';