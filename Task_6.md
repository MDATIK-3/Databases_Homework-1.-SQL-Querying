# Task 6 - Day with the largest USD→CAD AverageRate change

## Part 6a - Main answer: single largest move

![alt text](Solutions_Images\image-7.png)

## Part 6b - Top 10 moves (for context)

![alt text](Solutions_Images\image-8.png)

## Explanation

### Key Techniques

1. **CTE `usd_cad`** - Filters to USD→CAD rates and converts dates
2. **Window function `LAG()`** - Gets the previous day's rate, ordered by date
3. **Delta calculation** - Computes day-over-day change: `current_rate - previous_rate`
4. **Absolute value** - Finds magnitude of change regardless of direction (up or down)
5. **Set-to-scalar subquery** - Finds the maximum absolute delta and filters for that row

### Why LAG()?

- `LAG(rate, 1)` retrieves the previous row's rate in chronological order
- The `OVER (ORDER BY d)` ensures proper time sequencing
- First row has NULL for LAG (no previous day), automatically excluded by `WHERE delta IS NOT NULL`

**Database:** AdventureWorks (OLTP)  
**Tables:** CurrencyRate
