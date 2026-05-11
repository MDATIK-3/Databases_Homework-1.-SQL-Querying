SELECT
    co.Name AS Country,
    ci.Name AS Capital,
    co.Population AS CountryPopulation,
    ci.Population AS CapitalPopulation,
    ROUND(100.0 * ci.Population / co.Population, 4) AS PctInCapital
FROM
    country co
    JOIN city ci ON ci.ID = co.Capital
WHERE
    co.Population > 0
ORDER BY
    PctInCapital ASC
LIMIT
    10;