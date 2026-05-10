# Task 8 - AdventureWorks

## Goal
Investigate whether/how vendor `CreditRating` correlates with total monetary amount of transactions involving that vendor (`PurchaseOrder*`).

## Strategy (1–2 paragraphs)
1. Aggregate transactions at the vendor level: compute `vendor_total_amount = SUM(PurchaseOrderLine.LineTotal)` grouped by vendor.
2. Join that aggregate to `Vendor` to bring `CreditRating`.
3. To inspect correlation, group vendor totals by `CreditRating` and compare distributions (counts and summed/avg totals).

## Included queries
- A `vendor_totals` CTE + final grouped by `CreditRating`.

