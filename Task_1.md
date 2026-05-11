# Task 1 - Letters not appearing at each position of the 3-letter country code

![alt text](./Solutions_Images\image.png)

## Explanation

This query:
1. Generates a CTE `letters` containing all 26 capital letters A–Z
2. For each of the three positions in country codes, finds letters that never appear in that position
3. Uses `SUBSTR()` to extract each character position from the `Code` column
4. Uses `DISTINCT` to identify unique letters appearing in each position
5. Uses set subtraction (NOT IN) to find missing letters
6. Uses `GROUP_CONCAT()` to list all missing letters as a comma-separated string

**Database:** world (SQLite)  
**Tables:** country
