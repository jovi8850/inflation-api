CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.cpi_sector_monthly` AS
SELECT
  date,
  sector3,
  AVG(value) AS sector_index
FROM
  `inflation-project-012926.cpi_ml.cpi_base`
GROUP BY
  date,
  sector3;