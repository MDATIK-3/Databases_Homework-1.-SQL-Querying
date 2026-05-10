# Task 1 - world

## Goal
Find which Latin letter does **not** appear in the 1st, 2nd, and 3rd position of the 3-letter `Country.code`.

## Strategy
1. Build a reference set of letters `A..Z`.
2. For each position (1/2/3), extract the corresponding character from `Country.code`.
3. Left join reference letters with the used letters; return those with `NULL`.

## Expected output
Three result sets (one per query) listing the missing letters for positions 1, 2, and 3.
