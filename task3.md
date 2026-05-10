# Task 3 - world

## Goal
For each country compute the percentage of its population living in its capital. Return the 10 smallest percentages.

## Strategy
- Join `Country` to `City` using the capital reference (`capital_id` in the common schema).
- Compute:
  `pct = (capital_population / country_population) * 100`
- Filter null/zero populations.
- Order ascending and `LIMIT 10`.

## Notes
- If your schema uses different key names (e.g., `capital` holds a city name/code), adjust the `JOIN` accordingly.

