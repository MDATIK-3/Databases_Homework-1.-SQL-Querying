WITH ratios AS (
  SELECT Code,
    Name,
    Population,
    (SurfaceArea * 0.386102) AS area_sq_miles
  FROM Country
),
ratios_clean AS (
  SELECT Code,
    Name,
    (Population / NULLIF(area_sq_miles, 0)) AS pop_per_sq_mile
  FROM ratios
  WHERE Population IS NOT NULL
    AND area_sq_miles IS NOT NULL
    AND area_sq_miles <> 0
),
ordered AS (
  SELECT pop_per_sq_mile,
    ROW_NUMBER() OVER (
      ORDER BY pop_per_sq_mile
    ) AS rn,
    COUNT(*) OVER () AS cnt
  FROM ratios_clean
),
median_calc AS (
  SELECT AVG(pop_per_sq_mile) AS median_value
  FROM ordered
  WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
),
minmax AS (
  SELECT MAX(pop_per_sq_mile) AS max_value,
    MIN(pop_per_sq_mile) AS min_value
  FROM ratios_clean
)
SELECT 'Maximum' AS Metric,
  max_value AS Value
FROM minmax
UNION ALL
SELECT 'Minimum' AS Metric,
  min_value AS Value
FROM minmax
UNION ALL
SELECT 'Median' AS Metric,
  median_value AS Value
FROM median_calc;