-- Objective: Identify dates with significant variation between the smallest and largest funding rounds.
-- This query calculates the minimum and maximum 'raised_amount' for each date in the 'funding_round' table.
-- It then filters these results to include only dates where the minimum funding was not zero
-- and where the minimum and maximum funding amounts were different, indicating actual variance.

SELECT
    funded_at,                                    -- The date of the funding rounds
    MIN(raised_amount) AS lowest_amount_raised,   -- The smallest amount raised on that date
    MAX(raised_amount) AS highest_amount_raised   -- The largest amount raised on that date
FROM
    funding_round
GROUP BY
    funded_at                                     -- Group funding rounds by date
HAVING
    MIN(raised_amount) <> 0                       -- Condition 1: Lowest amount raised is not zero
    AND MIN(raised_amount) <> MAX(raised_amount); -- Condition 2: Lowest and highest amounts are not the same (ensuring there was a range of funding amounts)

-- Notes:
-- 1. 'funded_at' might be a full DATETIME/TIMESTAMP. GROUP BY could group by the exact timestamp.
--  If daily grouping is intended and 'funded_at' includes time, it should be separated to just the date part using DATE(funded_at).
-- 2. 'raised_amount' is assumed to be numeric and in a consistent currency.
-- 3. Sorting (e.g., ORDER BY funded_at) can be added for chronological output if desired.