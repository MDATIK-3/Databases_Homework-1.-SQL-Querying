-- 9a. Group means by Gender x MaritalStatus
WITH CurrentPay AS (
    SELECT BusinessEntityID, Rate,
           ROW_NUMBER() OVER (PARTITION BY BusinessEntityID
                              ORDER BY RateChangeDate DESC) AS rn
    FROM EmployeePayHistory
),
EmpPay AS (
    SELECT e.BusinessEntityID, cp.Rate AS PayRate,
           e.Gender, e.MaritalStatus,
           CAST((julianday('2014-06-30') - julianday(e.BirthDate)) / 365.25
                AS INTEGER) AS Age
    FROM Employee e
    JOIN CurrentPay cp
      ON cp.BusinessEntityID = e.BusinessEntityID AND cp.rn = 1
)
SELECT Gender, MaritalStatus, COUNT(*) AS N,
       ROUND(AVG(PayRate), 2) AS AvgPay,
       ROUND(MIN(PayRate), 2) AS MinPay,
       ROUND(MAX(PayRate), 2) AS MaxPay,
       ROUND(AVG(Age * 1.0), 1) AS AvgAge
FROM EmpPay
GROUP BY Gender, MaritalStatus
ORDER BY Gender, MaritalStatus;

-- 9b. By age band
WITH CurrentPay AS (
    SELECT BusinessEntityID, Rate,
           ROW_NUMBER() OVER (PARTITION BY BusinessEntityID
                              ORDER BY RateChangeDate DESC) AS rn
    FROM EmployeePayHistory
),
EmpPay AS (
    SELECT cp.Rate AS PayRate,
           CAST((julianday('2014-06-30') - julianday(e.BirthDate)) / 365.25
                AS INTEGER) AS Age
    FROM Employee e
    JOIN CurrentPay cp
      ON cp.BusinessEntityID = e.BusinessEntityID AND cp.rn = 1
)
SELECT CASE WHEN Age < 30 THEN '<30'
            WHEN Age < 40 THEN '30-39'
            WHEN Age < 50 THEN '40-49'
            WHEN Age < 60 THEN '50-59'
            ELSE '60+' END AS AgeBand,
       COUNT(*) AS N,
       ROUND(AVG(PayRate), 2) AS AvgPay,
       ROUND(MIN(PayRate), 2) AS MinPay,
       ROUND(MAX(PayRate), 2) AS MaxPay
FROM EmpPay
GROUP BY AgeBand
ORDER BY AgeBand;

-- 9c. Pearson correlation: age vs pay
WITH CurrentPay AS (
    SELECT BusinessEntityID, Rate,
           ROW_NUMBER() OVER (PARTITION BY BusinessEntityID
                              ORDER BY RateChangeDate DESC) AS rn
    FROM EmployeePayHistory
),
EmpPay AS (
    SELECT cp.Rate AS p,
           (julianday('2014-06-30') - julianday(e.BirthDate)) / 365.25 AS a
    FROM Employee e
    JOIN CurrentPay cp
      ON cp.BusinessEntityID = e.BusinessEntityID AND cp.rn = 1
),
s AS (
    SELECT AVG(a) ma, AVG(p) mp,
           AVG(a*a) maa, AVG(p*p) mpp, AVG(a*p) map_
    FROM EmpPay
)
SELECT (map_ - ma*mp) / (SQRT(maa - ma*ma) * SQRT(mpp - mp*mp)) AS pearson_r
FROM s;

-- 9d. Marginal effect of gender (controlling for age band)
WITH CurrentPay AS (
    SELECT BusinessEntityID, Rate,
           ROW_NUMBER() OVER (PARTITION BY BusinessEntityID
                              ORDER BY RateChangeDate DESC) AS rn
    FROM EmployeePayHistory
),
EmpPay AS (
    SELECT cp.Rate AS PayRate, e.Gender,
           CAST((julianday('2014-06-30') - julianday(e.BirthDate)) / 365.25
                AS INTEGER) AS Age
    FROM Employee e
    JOIN CurrentPay cp
      ON cp.BusinessEntityID = e.BusinessEntityID AND cp.rn = 1
)
SELECT CASE WHEN Age < 30 THEN '<30'
            WHEN Age < 40 THEN '30-39'
            WHEN Age < 50 THEN '40-49'
            WHEN Age < 60 THEN '50-59'
            ELSE '60+' END AS AgeBand,
       Gender, COUNT(*) AS N, ROUND(AVG(PayRate), 2) AS AvgPay
FROM EmpPay
GROUP BY AgeBand, Gender
ORDER BY AgeBand, Gender;
