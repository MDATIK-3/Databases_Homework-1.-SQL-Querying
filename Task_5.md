# Task 5 - Headcount per department on 1999-05-01

## Part 5a - Query with literal date (returns 0 rows)

**Result:** 0 rows (dataset does not contain 1999 records)

## Part 5b - Confirm data range

![alt text](Solutions_Images\image-5.png)

## Part 5c - Working example at 2011-05-01

![alt text](Solutions_Images\image-6.png)

## Query Logic

The date filter ensures we count employees who:
1. **Started** their assignment **on or before** the target date
2. **Are still assigned** - either no end date (NULL) or end date is on or after the target date

This captures a snapshot of departmental headcount on a specific date.

**Database:** AdventureWorks (OLTP)  
**Tables:** EmployeeDepartmentHistory, Department
