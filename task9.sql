WITH current_pay AS (
  SELECT
    p.BusinessEntityID,
    p.Rate
  FROM
    EmployeePayHistory p
    JOIN (
      SELECT
        BusinessEntityID,
        MAX(RateChangeDate) AS latest_date
      FROM
        EmployeePayHistory
      GROUP BY
        BusinessEntityID
    ) latest ON latest.BusinessEntityID = p.BusinessEntityID
    AND latest.latest_date = p.RateChangeDate
) 
-- Q1: 
SELECT
  e.BusinessEntityID AS employee_id,
  TIMESTAMPDIFF(YEAR, e.BirthDate, CURDATE()) AS age_years,
  cp.Rate AS pay_rate,
  e.Gender,
  e.MaritalStatus
FROM
  Employee e
  JOIN current_pay cp ON cp.BusinessEntityID = e.BusinessEntityID;

-- Q2: 
WITH current_pay AS (
  SELECT
    p.BusinessEntityID,
    p.Rate
  FROM
    EmployeePayHistory p
    JOIN (
      SELECT
        BusinessEntityID,
        MAX(RateChangeDate) AS latest_date
      FROM
        EmployeePayHistory
      GROUP BY
        BusinessEntityID
    ) latest ON latest.BusinessEntityID = p.BusinessEntityID
    AND latest.latest_date = p.RateChangeDate
)
SELECT
  e.Gender,
  e.MaritalStatus,
  AVG(cp.Rate) AS avg_pay_rate,
  MIN(cp.Rate) AS min_pay_rate,
  MAX(cp.Rate) AS max_pay_rate,
  COUNT(*) AS employee_count
FROM
  Employee e
  JOIN current_pay cp ON cp.BusinessEntityID = e.BusinessEntityID
GROUP BY
  e.Gender,
  e.MaritalStatus
ORDER BY
  avg_pay_rate DESC;