# Task 8 - Vendor CreditRating vs total purchase amount

## Part 8a - Per-rating roll-up

![alt text](Solutions_Images\image-12.png)

## Part 8b - Pearson correlation: CreditRating vs spend

![alt text](Solutions_Images\image-13.png)

**Formula:** Pearson's r is the ratio of covariance to the product of standard deviations:
$$r = \frac{\text{E}[XY] - \text{E}[X] \cdot \text{E}[Y]}{\sqrt{\text{E}[X^2] - \text{E}[X]^2} \cdot \sqrt{\text{E}[Y^2] - \text{E}[Y]^2}}$$

**Result:** Correlation coefficient between –1 (perfect negative) and +1 (perfect positive).
- If > 0: Better credit rating associates with higher spending
- If < 0: Better credit rating associates with lower spending
- If ≈ 0: No linear relationship

## Part 8c - Spearman correlation (rank-based)

![alt text](Solutions_Images\image-14.png)

**Why Spearman?** Rank-based correlation is robust to outliers and doesn't assume linearity-it measures monotonic association.

- Rank each variable independently
- Apply Pearson's formula to the ranks
- Comparable interpretation to Pearson's r


## Part 8d - Top 5 vendors by spend

![alt text](Solutions_Images\image-15.png)

## Interpretation Tips

- **Strong positive r → good credit = big spender** → company trusts/relies on them
- **Weak/no correlation → spending independent of rating** → company uses various vendors
- **Spearman vs Pearson:** If correlation differs significantly between the two, the relationship may be non-linear or influenced by outliers

**Database:** AdventureWorks (OLTP)  
**Tables:** Vendor, PurchaseOrderHeader
