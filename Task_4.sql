-- 4a. Simple (unweighted) way — NOT RECOMMENDED
SELECT
    cl.Language,
    ROUND(AVG(c.LifeExpectancy), 2) AS avg_life_exp_simple,
    COUNT(*) AS n_countries
FROM
    countrylanguage cl
    JOIN country c ON c.Code = cl.CountryCode
WHERE
    c.LifeExpectancy IS NOT NULL
GROUP BY
    cl.Language
ORDER BY
    avg_life_exp_simple DESC;

-- 4b. Weighted by speakers (RECOMMENDED)
SELECT
    cl.Language,
    ROUND(
        SUM(
            c.LifeExpectancy * c.Population * cl.Percentage / 100.0
        ) / NULLIF(SUM(c.Population * cl.Percentage / 100.0), 0),
        2
    ) AS avg_life_exp_weighted,
    ROUND(SUM(c.Population * cl.Percentage / 100.0)) AS approx_speakers
FROM
    countrylanguage cl
    JOIN country c ON c.Code = cl.CountryCode
WHERE
    c.LifeExpectancy IS NOT NULL
GROUP BY
    cl.Language
ORDER BY
    avg_life_exp_weighted DESC;