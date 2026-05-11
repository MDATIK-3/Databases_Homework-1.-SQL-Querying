WITH ratios AS (
    SELECT
        Code,
        CAST(Population AS REAL) / (SurfaceArea * 0.386102) AS pop_per_sq_mile
    FROM
        country
    WHERE
        SurfaceArea > 0
),
ordered AS (
    SELECT
        pop_per_sq_mile,
        ROW_NUMBER() OVER (
            ORDER BY
                pop_per_sq_mile
        ) AS rn,
        COUNT(*) OVER () AS total
    FROM
        ratios
),
median_calc AS (
    SELECT
        AVG(pop_per_sq_mile) AS median_val
    FROM
        ordered
    WHERE
        rn IN ((total + 1) / 2, (total + 2) / 2)
)
SELECT
    'Maximum' AS Metric,
    MAX(pop_per_sq_mile) AS Value
FROM
    ratios
UNION
ALL
SELECT
    'Minimum',
    MIN(pop_per_sq_mile)
FROM
    ratios
UNION
ALL
SELECT
    'Median',
    median_val
FROM
    median_calc;