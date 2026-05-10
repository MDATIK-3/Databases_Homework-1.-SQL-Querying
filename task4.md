# Task 4 - world

## Goal
1. Compute a simple average life expectancy per language.
2. Propose a more correct way using available data.

## Q1 Strategy (simple / incorrect)
Average `CountryLanguage.lifeexpectancy` across all countries that list a language.
- This ignores how many people speak the language in each country.

## Q2 Strategy (more correct / weighted)
Compute a population-weighted average where each country is weighted by the **estimated number of language speakers**:
- `language_speakers = country_population * (percentage_speaking_language / 100)`
- `weighted_avg = sum(language_speakers * lifeexpectancy) / sum(language_speakers)`

## Notes
- This requires `CountryLanguage.percentage` and `Country.population` from the typical schema.
- If column/table names differ, map them to your DDL.

