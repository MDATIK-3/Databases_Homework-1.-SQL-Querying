WITH usd_cad AS (
  SELECT
    CurrencyRateDate,
    AverageRate AS usd_cad_rate
  FROM
    CurrencyRate
  WHERE
    FromCurrencyCode = 'USD'
    AND ToCurrencyCode = 'CAD'
),
ordered AS (
  SELECT
    CurrencyRateDate,
    usd_cad_rate,
    LAG(usd_cad_rate) OVER (
      ORDER BY
        CurrencyRateDate
    ) AS prev_rate
  FROM
    usd_cad
),
diffs AS (
  SELECT
    CurrencyRateDate,
    usd_cad_rate,
    prev_rate,
    (usd_cad_rate - prev_rate) AS delta_rate
  FROM
    ordered
  WHERE
    prev_rate IS NOT NULL
)
SELECT
  CurrencyRateDate,
  usd_cad_rate,
  prev_rate,
  delta_rate
FROM
  diffs
ORDER BY
  ABS(delta_rate) DESC
LIMIT
  1;