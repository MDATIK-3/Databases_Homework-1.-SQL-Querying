# Task 2 - world

## Goal
1. Compute `population / square_mile` ratio per country.
2. Using a CTE and the previous result, compute maximum, minimum, and median of that ratio.
3. Challenge: return exactly three rows with columns `(Metric, Value)`.

## Strategy
- `ratios_clean`: compute the ratio with `NULLIF(area, 0)` to avoid division by zero.
- Median in MySQL: use window functions to rank ordered ratios; for even counts take the average of the two middle values.
- Final result uses `UNION ALL` to output exactly 3 rows: Maximum, Minimum, median.

## Notes
- Replace `area` with the actual square-miles column name in your `Country` table (common names: `area`, `surfacearea`, etc.).

