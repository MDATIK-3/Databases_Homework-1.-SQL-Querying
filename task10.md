# Task 10 (optional) - LLM usage findings

## Fill with your experience
- Typical SQL mistakes from LLMs:
  - wrong/missing join keys (hallucinated columns)
  - dialect mismatches (median implementation differences)
  - missing NULL/zero-div checks
  - recursive CTE stopping/deduplication issues
- Hallucinations:
  - invented column/table names not present in the DDL
  - assumed a specific schema relationship for hierarchies
- Context needed:
  - more context for analytics tasks (what columns represent amounts, percentages, effective dates)
  - less context for technical patterns (CTE/LAG/recursive skeleton)
- Effectiveness:
  - often strong at producing SQL structure quickly
  - requires verification for business logic and correctness

## Advice to future self/colleagues
- Always start with exact DDL/table definitions.
- Ask the LLM to list assumptions before producing final SQL.
- Run small sanity checks (counts, min/max) after generation.