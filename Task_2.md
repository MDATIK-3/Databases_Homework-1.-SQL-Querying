# Task 2 - Population density (per square mile): max, min, median

## Background

The `SurfaceArea` column in the country table is in km². To convert to people per square mile:
- Conversion factor: 1 km² = 0.386102 mi²
- Formula: `pop / (SurfaceArea * 0.386102)`
![alt text](Solutions_Images\image-1.png)

## Explanation

The query uses three CTEs:

1. **ratios** - Calculates population density in people/mi² for each country (filtering out SurfaceArea ≤ 0)
2. **ordered** - Assigns row numbers and counts total countries to enable median calculation
3. **median_calc** - Finds the middle value(s) using the formula for both odd and even counts

The median formula `rn IN ((total + 1) / 2, (total + 2) / 2)` works for both:
- **Odd N**: Select the single middle row
- **Even N**: Average the two middle rows (the formula selects both)

Window functions (`ROW_NUMBER()`, `COUNT() OVER()`) allow us to compute ranking and totals in a single pass.

**Database:** world (SQLite)  
**Tables:** country
