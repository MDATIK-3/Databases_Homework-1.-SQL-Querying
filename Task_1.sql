WITH letters(L) AS (
    SELECT
        'A'
    UNION
    SELECT
        'B'
    UNION
    SELECT
        'C'
    UNION
    SELECT
        'D'
    UNION
    SELECT
        'E'
    UNION
    SELECT
        'F'
    UNION
    SELECT
        'G'
    UNION
    SELECT
        'H'
    UNION
    SELECT
        'I'
    UNION
    SELECT
        'J'
    UNION
    SELECT
        'K'
    UNION
    SELECT
        'L'
    UNION
    SELECT
        'M'
    UNION
    SELECT
        'N'
    UNION
    SELECT
        'O'
    UNION
    SELECT
        'P'
    UNION
    SELECT
        'Q'
    UNION
    SELECT
        'R'
    UNION
    SELECT
        'S'
    UNION
    SELECT
        'T'
    UNION
    SELECT
        'U'
    UNION
    SELECT
        'V'
    UNION
    SELECT
        'W'
    UNION
    SELECT
        'X'
    UNION
    SELECT
        'Y'
    UNION
    SELECT
        'Z'
)
SELECT
    (
        SELECT
            GROUP_CONCAT(L, ',')
        FROM
            letters
        WHERE
            L NOT IN (
                SELECT
                    DISTINCT SUBSTR(Code, 1, 1)
                FROM
                    country
            )
    ) AS missing_pos1,
    (
        SELECT
            GROUP_CONCAT(L, ',')
        FROM
            letters
        WHERE
            L NOT IN (
                SELECT
                    DISTINCT SUBSTR(Code, 2, 1)
                FROM
                    country
            )
    ) AS missing_pos2,
    (
        SELECT
            GROUP_CONCAT(L, ',')
        FROM
            letters
        WHERE
            L NOT IN (
                SELECT
                    DISTINCT SUBSTR(Code, 3, 1)
                FROM
                    country
            )
    ) AS missing_pos3;