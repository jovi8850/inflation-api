CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.cpi_sector_inflation` AS
SELECT
  date,
  sector3,
  LOG(sector_index) -
  LOG(LAG(sector_index) OVER (PARTITION BY sector3 ORDER BY date)) AS mom_inflation
FROM
  `inflation-project-012926.cpi_ml.cpi_sector_monthly`
WHERE
  sector_index IS NOT NULL;

CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.sector_features_long` AS
SELECT
  date,
  sector3,
  mom_inflation,
  LAG(mom_inflation, 1) OVER (PARTITION BY sector3 ORDER BY date) AS lag1,
  LAG(mom_inflation, 3) OVER (PARTITION BY sector3 ORDER BY date) AS lag3,
  LAG(mom_inflation, 6) OVER (PARTITION BY sector3 ORDER BY date) AS lag6,
  LAG(mom_inflation, 12) OVER (PARTITION BY sector3 ORDER BY date) AS lag12
FROM
  `inflation-project-012926.cpi_ml.cpi_sector_inflation`;