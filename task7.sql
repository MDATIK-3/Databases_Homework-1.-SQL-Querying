WITH RECURSIVE chain AS (
  SELECT
    e.BusinessEntityID AS chain_root,
    e.BusinessEntityID AS current_id,
    CAST(e.BusinessEntityID AS CHAR(500)) AS chain_str,
    1 AS depth
  FROM
    Employee e
  WHERE
    e.ManagerID IS NULL
    OR e.ManagerID = e.BusinessEntityID
  UNION
  ALL
  SELECT
    chain.chain_root,
    emp.BusinessEntityID AS current_id,
    CONCAT(
      chain.chain_str,
      ' -> ',
      CAST(emp.BusinessEntityID AS CHAR(50))
    ) AS chain_str,
    chain.depth + 1 AS depth
  FROM
    chain
    JOIN Employee emp ON emp.ManagerID = chain.current_id
  WHERE
    chain.depth < 50
)
SELECT
  chain_root,
  current_id AS chain_end,
  chain_str AS subordination_chain,
  depth AS chain_length
FROM
  chain
ORDER BY
  chain_root,
  chain_str;