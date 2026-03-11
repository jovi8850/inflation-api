CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.model_features` AS
SELECT *
FROM (
  SELECT
    date,
    sector3,
    lag1,
    lag3,
    lag6,
    lag12
  FROM `inflation-project-012926.cpi_ml.sector_features_long`
)
PIVOT (
  AVG(lag1) AS lag1,
  AVG(lag3) AS lag3,
  AVG(lag6) AS lag6,
  AVG(lag12) AS lag12
  FOR sector3 IN (
    'SA0','SA3','SAA','SAC','SAD','SAE','SAF','SAG','SAH','SAM',
    'SAN','SAR','SAS','SAT','SEA','SEE','SEF','SEG','SEH','SEM',
    'SER','SET','SS0','SS1','SS2','SS3','SS4','SS5','SS6','SSF'
  )
);

CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.model_features_enhanced` AS
SELECT
  *,
  LAG(lag1_SA0, 1) OVER (ORDER BY date) AS lag2_SA0
FROM
  `inflation-project-012926.cpi_ml.model_features`;

CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.training_data` AS
SELECT
  f.*,
  t.target_inflation
FROM
  `inflation-project-012926.cpi_ml.model_features_enhanced` f
JOIN
  `inflation-project-012926.cpi_ml.headline_target` t
USING(date)
WHERE
  t.target_inflation IS NOT NULL
  AND f.lag12_SA0 IS NOT NULL;

CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.training_split` AS
SELECT *
FROM `inflation-project-012926.cpi_ml.training_data`
WHERE date < '2017-01-01';

CREATE OR REPLACE TABLE `inflation-project-012926.cpi_ml.test_split` AS
SELECT *
FROM `inflation-project-012926.cpi_ml.training_data`
WHERE date >= '2017-01-01';