-- 5a. Literal date as stated (returns 0 rows data doesn't go back to 1999)
SELECT
    d.Name AS Department,
    COUNT(*) AS Headcount
FROM
    EmployeeDepartmentHistory edh
    JOIN Department d ON d.DepartmentID = edh.DepartmentID
WHERE
    date(edh.StartDate) <= date('1999-05-01')
    AND (
        edh.EndDate IS NULL
        OR date(edh.EndDate) >= date('1999-05-01')
    )
GROUP BY
    d.Name
ORDER BY
    Headcount DESC,
    d.Name;

-- 5b. Confirm the actual data range
SELECT
    MIN(StartDate) AS earliest_start,
    MAX(StartDate) AS latest_start
FROM
    EmployeeDepartmentHistory;

-- 5c. Same query at a date inside the data range — 2011-05-01
SELECT
    d.Name AS Department,
    COUNT(*) AS Headcount
FROM
    EmployeeDepartmentHistory edh
    JOIN Department d ON d.DepartmentID = edh.DepartmentID
WHERE
    date(edh.StartDate) <= date('2011-05-01')
    AND (
        edh.EndDate IS NULL
        OR date(edh.EndDate) >= date('2011-05-01')
    )
GROUP BY
    d.Name
ORDER BY
    Headcount DESC,
    d.Name;