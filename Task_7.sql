-- 7a. Spot-check: verify manager assignments
SELECT
    em.BusinessEntityID,
    e.JobTitle,
    em.ManagerID,
    m.JobTitle AS ManagerTitle
FROM
    EmployeeManager em
    JOIN Employee e ON e.BusinessEntityID = em.BusinessEntityID
    LEFT JOIN Employee m ON m.BusinessEntityID = em.ManagerID
WHERE
    em.BusinessEntityID IN (1, 2, 3, 4, 16, 17, 25, 273, 290)
ORDER BY
    em.BusinessEntityID;

-- 7b. Total chains and maximum depth
WITH RECURSIVE Chains(TopID, CurrentID, Path, Depth) AS (
    SELECT
        BusinessEntityID,
        BusinessEntityID,
        CAST(BusinessEntityID AS TEXT),
        1
    FROM
        EmployeeManager
    UNION
    ALL
    SELECT
        c.TopID,
        sub.BusinessEntityID,
        c.Path || ' -> ' || CAST(sub.BusinessEntityID AS TEXT),
        c.Depth + 1
    FROM
        Chains c
        JOIN EmployeeManager sub ON sub.ManagerID = c.CurrentID
    WHERE
        c.Depth < 20
)
SELECT
    COUNT(*) AS total_chains,
    MAX(Depth) AS max_depth
FROM
    Chains;

-- 7c. Maximal chains starting from CEO (root-to-leaf paths)
WITH RECURSIVE Chains(TopID, CurrentID, Path, Depth) AS (
    SELECT
        BusinessEntityID,
        BusinessEntityID,
        CAST(BusinessEntityID AS TEXT),
        1
    FROM
        EmployeeManager
    WHERE
        ManagerID IS NULL
    UNION
    ALL
    SELECT
        c.TopID,
        sub.BusinessEntityID,
        c.Path || ' -> ' || CAST(sub.BusinessEntityID AS TEXT),
        c.Depth + 1
    FROM
        Chains c
        JOIN EmployeeManager sub ON sub.ManagerID = c.CurrentID
    WHERE
        c.Depth < 20
)
SELECT
    Path AS RootToLeafChain,
    Depth
FROM
    Chains c
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            EmployeeManager x
        WHERE
            x.ManagerID = c.CurrentID
    )
ORDER BY
    Depth DESC,
    Path
LIMIT
    15;