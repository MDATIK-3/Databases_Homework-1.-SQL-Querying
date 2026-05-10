WITH
  capital_pct
  AS
  (
    SELECT
      c.Code,
      c.Name                                                           AS country_name,
      c.Population                                                     AS country_population,
      ci.Population                                                    AS capital_population,
      (ci.Population / NULLIF(c.Population, 0)) * 100.0               AS pct_population_in_capital
    FROM Country c
      JOIN City ci
      ON ci.ID = c.Capital
    WHERE c.Population  IS NOT NULL
      AND c.Population  <> 0
      AND ci.Population IS NOT NULL
  )
SELECT
  Code,
  country_name,
  pct_population_in_capital
FROM capital_pct
ORDER BY pct_population_in_capital ASC
LIMIT 10;

