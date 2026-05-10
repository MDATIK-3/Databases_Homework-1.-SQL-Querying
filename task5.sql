SELECT
  d.DepartmentID,
  d.Name                                        AS DepartmentName,
  COUNT(DISTINCT edh.BusinessEntityID)          AS EmployeeCount
FROM EmployeeDepartmentHistory edh
  JOIN Department d
  ON d.DepartmentID = edh.DepartmentID
WHERE edh.StartDate <= '1999-05-01'
  AND (edh.EndDate IS NULL OR edh.EndDate >= '1999-05-01')
GROUP BY d.DepartmentID, d.Name
ORDER BY EmployeeCount DESC;