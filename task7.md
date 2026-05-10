# Task 7 - AdventureWorks

## Goal
Build subordination chains (manager -> subordinate -> subordinate -> ...) using a recursive CTE.

## Strategy
- Recursive CTE `chain`:
  - Base: each employee starts a chain (root).
  - Recursive: find employees whose `ManagerID` equals the current chain node and append them to the chain string.
- `DISTINCT` helps deduplicate identical paths.

## Notes
- AdventureWorks hierarchy column can vary; in many datasets it is `Employee.ManagerID`. If your schema uses a different self-relation, update the join condition.

