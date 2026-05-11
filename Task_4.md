# Task 4 - Average life expectancy per language

## Part 4a - Simple (unweighted) approach

![alt text](Solutions_Images\image-3.png)

## Part 4b - Population-weighted approach (more correct)

![alt text](Solutions_Images\image-4.png)

### Methodology

The weighted approach answers: **"What is the life expectancy a randomly chosen speaker of this language would have?"**

- **Number of speakers in country** = `Population × Percentage / 100`
- **Weighted mean** = $\frac{\sum(\text{LifeExpectancy} \times \text{Speakers})}{\sum(\text{Speakers})}$
- This assumes uniform life expectancy across subgroups within each country

### Caveats

1. **Life expectancy is national** - We can't see differences between language communities within a country
2. **Percentage may not sum to 100** - Bilingual speakers counted in multiple languages
3. **No overlap data** - Can't separate monolingual from multilingual speakers
4. **Best available** - Given the schema constraints, speaker-weighted averaging is the best estimator

**Database:** world (SQLite)  
**Tables:** countrylanguage, country
