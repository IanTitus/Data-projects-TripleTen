-- Objective: Calculate the average number of degrees for employees (who have education records) at companies that closed after a single funding round (determined by is_first_round/is_last_round flags).

SELECT
    AVG(CAST(t.total_degree_count AS REAL)) AS avg_degrees_per_employee_at_failed_startups
                                                                                            -- Calculates the average of per-person degree counts from the subquery 't'.
                                                                                            -- CAST to REAL (or FLOAT/DECIMAL) ensures accurate floating-point division for the AVG.
FROM (
                                                                                            -- Subquery 't': Calculates the number of degrees for each employee
                                                                                            -- who worked at a 'failed company with one round' AND has education records.
    SELECT
        p.id AS person_id,                                                                  -- Person identifier from the 'people' table.
        COUNT(e.degree_type) AS total_degree_count                                          -- Counts education entries (degrees) for this person.
    FROM
        people AS p
    INNER JOIN                                                                              -- This join ensures only people with at least one education record are included.
        education AS e ON p.id = e.person_id
    WHERE
        p.company_id IN (
                                                                                            -- Subquery: Identifies IDs of 'failed companies with exactly one funding round'.
            SELECT
                c.id                                                                        -- Selects the company ID from the 'company' table.
            FROM
                company AS c
            WHERE
                c.id IN (
                                                                                            -- Innermost Subquery: Identifies company_ids that had exactly one funding round
                                                                                            -- by checking if a funding round was both its first and its last.
                    SELECT
                        fr.company_id
                    FROM
                        funding_round AS fr
                    WHERE
                        fr.is_first_round = 1 AND fr.is_last_round = 1                      -- Ensures the funding round is both the first and last, indicating a single round.  
                )
                AND c.status = 'closed'                                                     -- Ensures the company is also 'closed'.
        )
    GROUP BY
        p.id                                                                                -- Groups the counts by person to get total degrees per person.
) AS t;                                                                                     -- Alias 't' for the derived table (subquery result).

-- Notes:
-- 1.  **Defining the Company Cohort**: The query precisely identifies "failed companies with one funding round."
--     This is achieved by first finding companies with exactly one recorded funding round (using the
--     `is_first_round` and `is_last_round` flags from the `funding_round` table) and then filtering
--     this set to include only companies with a `status` of 'closed' from the `company` table.
-- 2.  **Focus of the Average**: The use of an `INNER JOIN` between the `people` and `education` tables
--     means that the analysis focuses on employees who are associated with the identified failed
--     companies AND have at least one education record documented. The final average reflects the
--     degree count for this specific group of "educated employees."
-- 3.  **Counting Degrees**: `COUNT(e.degree_type)` is used to determine the number of degrees for each
--     person. It assumes each education record found after the join represents a distinct, countable degree.
-- 4.  **Query Structure (Subqueries)**: The query effectively uses nested subqueries to break down
--     the problem. This approach allows for sequential filtering and data derivation: first identifying
--     the target companies, then linking to relevant employees and their education, and finally
--     performing the aggregation.
-- 5.  **Precision in Averaging**: The `CAST(total_degree_count AS REAL)` operation before the `AVG`
--     function ensures that the average is calculated using floating-point arithmetic. This provides
--     a more precise decimal result if the average isn't a whole number, which is typical for averages.
--     For presentation in reports, this value might be further rounded to a conventional number of decimal places.