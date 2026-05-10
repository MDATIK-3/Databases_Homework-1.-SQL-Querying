# Task 6 - AdventureWorks

## Goal
Find the date where the USD↔CAD exchange rate changed the most compared to the previous day.

## Strategy
- Filter `CurrencyRate` to `USD -> CAD`.
- Use `LAG()` to get the previous day’s `AverageRate`.
- Compute `delta_rate = current - previous`.
- Order by `ABS(delta_rate)` and take the top 1 row.

