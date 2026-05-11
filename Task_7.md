# Task 7 - Recursive CTE: employee subordination chains

## Part 7a - Spot-check: verify manager assignments

![alt text](Solutions_Images\image-9.png)

## Part 7b - Total chains and maximum depth

![alt text](Solutions_Images\image-10.png)

## Part 7c - Maximal chains: CEO to leaf employees

![alt text](Solutions_Images\image-11.png)

### Key Components

1. **Anchor clause** - Selects starting point(s):
   - Part 7b: All employees (start from each potential root)
   - Part 7c: Only CEO (WHERE ManagerID IS NULL)

2. **Recursive clause** - Finds subordinates:
   - JOINs `EmployeeManager` via `sub.ManagerID = c.CurrentID`
   - Builds path by concatenating: `c.Path || ' -> ' || new_ID`
   - Increments depth: `c.Depth + 1`

3. **Depth limit** - `WHERE c.Depth < 20` prevents infinite loops

4. **Leaf filter** (Part 7c) - `WHERE NOT EXISTS (SELECT 1 FROM EmployeeManager x WHERE x.ManagerID = c.CurrentID)` finds employees with no subordinates

## Use Cases

- **Organizational structure visualization**
- **Finding reporting chains** (who reports to whom through how many levels?)
- **Hierarchy traversal** (CEO to all descendants)
- **Finding anomalies** (cycles, orphaned employees)

**Database:** AdventureWorks (OLTP)  
**Tables:** EmployeeManager, Employee
