CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.headline_target` AS
SELECT
  date,
  LEAD(mom_inflation) OVER (ORDER BY date) AS target_inflation
FROM
  `inflation-project-012926.cpi_ml.cpi_sector_inflation`
WHERE
  sector3 = 'SA0';