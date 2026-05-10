# Task 9 - AdventureWorks

## Goal
Investigate whether/how employee pay rate correlates with age, gender and marital status.

## Strategy (1–2 paragraphs)
1. Build an analysis dataset joining `Employee` with `EmployeePayHistory` to obtain numeric `Rate` and demographics (`Gender`, `MaritalStatus`).
2. Derive `age_years` from `BirthDate`.
3. Use aggregated views (e.g., avg pay by gender/marital status) and compare pay distributions across demographic groups.

## Included queries
- A join that produces per-employee rows with derived age.
- A grouped aggregation query for pay by `(Gender, MaritalStatus)`.

