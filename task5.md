# Task 5 - AdventureWorks

## Goal
Count employees per department as of **1999-05-01** using `EmployeeDepartmentHistory`.

## Strategy
- A person is employed in a department on date D if:
  - `StartDate <= D`
  - and `EndDate >= D` (or `EndDate IS NULL`)
- Count distinct `BusinessEntityID` grouped by department.

