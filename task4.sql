-- Q1
SELECT
  cl.Language,
  AVG(c.LifeExpectancy) AS avg_life_expectancy_simple
FROM
  CountryLanguage cl
  JOIN Country c ON c.Code = cl.CountryCode
WHERE
  c.LifeExpectancy IS NOT NULL
GROUP BY
  cl.Language
ORDER BY
  avg_life_expectancy_simple DESC;

-- Q2  
WITH weights AS (
  SELECT
    cl.Language,
    c.LifeExpectancy,
    (c.Population * (cl.Percentage / 100.0)) AS language_speakers
  FROM
    CountryLanguage cl
    JOIN Country c ON c.Code = cl.CountryCode
  WHERE
    c.LifeExpectancy IS NOT NULL
    AND c.Population IS NOT NULL
    AND cl.Percentage IS NOT NULL
),
weighted_avg AS (
  SELECT
    Language,
    SUM(language_speakers * LifeExpectancy) / NULLIF(SUM(language_speakers), 0) AS avg_life_expectancy_weighted
  FROM
    weights
  GROUP BY
    Language
)
SELECT
  *
FROM
  weighted_avg
ORDER BY
  avg_life_expectancy_weighted DESC;