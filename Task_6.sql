-- 6a. Main answer: single largest move
WITH usd_cad AS (
    SELECT
        date(CurrencyRateDate) AS d,
        AverageRate AS rate
    FROM
        CurrencyRate
    WHERE
        FromCurrencyCode = 'USD'
        AND ToCurrencyCode = 'CAD'
),
diffed AS (
    SELECT
        d,
        rate,
        rate - LAG(rate) OVER (
            ORDER BY
                d
        ) AS delta,
        ABS(
            rate - LAG(rate) OVER (
                ORDER BY
                    d
            )
        ) AS abs_delta
    FROM
        usd_cad
)
SELECT
    d AS RateChangeDate,
    rate AS NewRate,
    delta AS DayOverDayChange
FROM
    diffed
WHERE
    abs_delta = (
        SELECT
            MAX(abs_delta)
        FROM
            diffed
    );

-- 6b. Top 10 moves for context
WITH usd_cad AS (
    SELECT
        date(CurrencyRateDate) AS d,
        AverageRate AS rate
    FROM
        CurrencyRate
    WHERE
        FromCurrencyCode = 'USD'
        AND ToCurrencyCode = 'CAD'
),
diffed AS (
    SELECT
        d,
        LAG(rate) OVER (
            ORDER BY
                d
        ) AS prev_rate,
        rate,
        rate - LAG(rate) OVER (
            ORDER BY
                d
        ) AS delta
    FROM
        usd_cad
)
SELECT
    d,
    prev_rate,
    rate,
    delta
FROM
    diffed
WHERE
    delta IS NOT NULL
ORDER BY
    ABS(delta) DESC
LIMIT
    10;