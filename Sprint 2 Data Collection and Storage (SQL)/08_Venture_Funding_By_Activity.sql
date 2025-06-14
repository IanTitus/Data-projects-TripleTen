-- Objective: Categorize venture funds based on their investment activity (number of companies invested in) and display all original fund information along with this new activity category.
-- Activity levels are defined as:
--   high_activity: 100 or more companies invested.
--   middle_activity: 20 to 99 companies invested in (between 20 and 100 companies invested).
--   low_activity: Fewer than 20 companies invested.

SELECT
    f.*,                                                        -- Selects all columns from the 'fund' table (using alias 'f').
    CASE
        WHEN f.invested_companies >= 100 THEN 'high_activity'
        WHEN f.invested_companies >= 20  THEN 'middle_activity' -- Implicitly < 100 due to the order of WHEN clauses.
        ELSE 'low_activity'                                     -- Covers cases where invested_companies < 20.
    END AS activity_category                                    -- Assigns a name to the new calculated field.
FROM
    fund f;                                                     -- Using 'f' as an alias for the 'fund' table for brevity.

-- Notes:
-- 1. This query relies on the 'invested_companies' column in the 'fund' table accurately reflecting the number of distinct companies each fund has invested in.
-- 2. The CASE statement evaluates conditions in the order they are written. Once a condition is true for a row, that row gets the assigned value, and subsequent WHEN conditions are skipped.
-- 3. An ORDER BY clause (e.g., ORDER BY activity_category, f.invested_companies DESC) could be added if a specific output order is desired for presentation.