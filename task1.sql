WITH
  letters
  AS
  (
                                                                                                          SELECT 'A' AS l
    UNION ALL
      SELECT 'B'
    UNION ALL
      SELECT 'C'
    UNION ALL
      SELECT 'D'
    UNION ALL
      SELECT 'E'
    UNION ALL
      SELECT 'F'
    UNION ALL
      SELECT 'G'
    UNION ALL
      SELECT 'H'
    UNION ALL
      SELECT 'I'
    UNION ALL
      SELECT 'J'
    UNION ALL
      SELECT 'K'
    UNION ALL
      SELECT 'L'
    UNION ALL
      SELECT 'M'
    UNION ALL
      SELECT 'N'
    UNION ALL
      SELECT 'O'
    UNION ALL
      SELECT 'P'
    UNION ALL
      SELECT 'Q'
    UNION ALL
      SELECT 'R'
    UNION ALL
      SELECT 'S'
    UNION ALL
      SELECT 'T'
    UNION ALL
      SELECT 'U'
    UNION ALL
      SELECT 'V'
    UNION ALL
      SELECT 'W'
    UNION ALL
      SELECT 'X'
    UNION ALL
      SELECT 'Y'
    UNION ALL
      SELECT 'Z'
  )
SELECT
  l AS missing_letter,
  CASE WHEN l NOT IN (SELECT SUBSTRING(Code, 1, 1)
  FROM Country) THEN 'Missing' ELSE 'Used' END AS pos_1,
  CASE WHEN l NOT IN (SELECT SUBSTRING(Code, 2, 1)
  FROM Country) THEN 'Missing' ELSE 'Used' END AS pos_2,
  CASE WHEN l NOT IN (SELECT SUBSTRING(Code, 3, 1)
  FROM Country) THEN 'Missing' ELSE 'Used' END AS pos_3
FROM letters
ORDER BY l;