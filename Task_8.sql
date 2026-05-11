-- 8a. Per-rating roll-up
WITH VendorTotals AS (
    SELECT
        v.BusinessEntityID,
        v.Name,
        v.CreditRating,
        COALESCE(SUM(poh.TotalDue), 0) AS TotalSpend,
        COUNT(poh.PurchaseOrderID) AS NumPOs
    FROM
        Vendor v
        LEFT JOIN PurchaseOrderHeader poh ON poh.VendorID = v.BusinessEntityID
    GROUP BY
        v.BusinessEntityID,
        v.Name,
        v.CreditRating
)
SELECT
    CreditRating,
    COUNT(*) AS NumVendors,
    ROUND(AVG(TotalSpend), 2) AS AvgSpendPerVendor,
    ROUND(SUM(TotalSpend), 2) AS OverallSpend,
    ROUND(AVG(NumPOs * 1.0), 2) AS AvgPOsPerVendor
FROM
    VendorTotals
GROUP BY
    CreditRating
ORDER BY
    CreditRating;

-- 8b. Pearson correlation: CreditRating vs total spend
WITH VendorTotals AS (
    SELECT
        v.BusinessEntityID,
        CAST(v.CreditRating AS REAL) AS cr,
        COALESCE(SUM(poh.TotalDue), 0) AS sp
    FROM
        Vendor v
        LEFT JOIN PurchaseOrderHeader poh ON poh.VendorID = v.BusinessEntityID
    WHERE
        v.CreditRating IS NOT NULL
    GROUP BY
        v.BusinessEntityID
),
s AS (
    SELECT
        AVG(cr) ma,
        AVG(sp) mb,
        AVG(cr * cr) maa,
        AVG(sp * sp) mbb,
        AVG(cr * sp) mab
    FROM
        VendorTotals
)
SELECT
    (mab - ma * mb) / (SQRT(maa - ma * ma) * SQRT(mbb - mb * mb)) AS pearson_r
FROM
    s;

-- 8c. Spearman correlation (rank-based)
WITH VendorTotals AS (
    SELECT
        v.BusinessEntityID,
        CAST(v.CreditRating AS REAL) cr,
        COALESCE(SUM(poh.TotalDue), 0) sp
    FROM
        Vendor v
        LEFT JOIN PurchaseOrderHeader poh ON poh.VendorID = v.BusinessEntityID
    WHERE
        v.CreditRating IS NOT NULL
    GROUP BY
        v.BusinessEntityID,
        v.CreditRating
),
ranked AS (
    SELECT
        CAST(
            RANK() OVER (
                ORDER BY
                    cr
            ) AS REAL
        ) AS rcr,
        CAST(
            RANK() OVER (
                ORDER BY
                    sp
            ) AS REAL
        ) AS rsp
    FROM
        VendorTotals
),
s AS (
    SELECT
        AVG(rcr) ma,
        AVG(rsp) mb,
        AVG(rcr * rcr) maa,
        AVG(rsp * rsp) mbb,
        AVG(rcr * rsp) mab
    FROM
        ranked
)
SELECT
    (mab - ma * mb) / (SQRT(maa - ma * ma) * SQRT(mbb - mb * mb)) AS spearman_r
FROM
    s;

-- 8d. Top 5 vendors by spend
SELECT
    v.Name,
    v.CreditRating,
    ROUND(SUM(poh.TotalDue), 2) AS Spend,
    COUNT(*) AS NumPOs
FROM
    Vendor v
    JOIN PurchaseOrderHeader poh ON poh.VendorID = v.BusinessEntityID
GROUP BY
    v.BusinessEntityID,
    v.Name,
    v.CreditRating
ORDER BY
    Spend DESC
LIMIT
    5;