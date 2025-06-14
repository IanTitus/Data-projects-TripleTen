-- Objective: To understand if a fund's investment approach (average number of funding rounds participated in) correlates with its activity level (high, middle, low).
-- This query first categorizes funds by activity level, then calculates the average number of investment rounds for each category, rounds this average, and presents the results sorted.

WITH FundWithCategory AS (
    -- Step 1: Assign activity category to each fund, similar to Question 8.
    -- We only need 'investment_rounds' and the derived 'activity_category' for the next step.
    SELECT
        investment_rounds, -- The number of investment rounds the fund participated in.
        CASE
            WHEN invested_companies >= 100 THEN 'high_activity'
            WHEN invested_companies >= 20  THEN 'middle_activity' -- Implicitly < 100
            ELSE 'low_activity'                               -- Covers < 20
        END AS activity_category
    FROM
        fund
)
-- Step 2: Calculate the average 'investment_rounds' for each 'activity_category' and round it.
SELECT
    activity_category,
    ROUND(AVG(investment_rounds)) AS avg_funding_rounds -- Calculate average and round to nearest whole number.
FROM
    FundWithCategory
GROUP BY
    activity_category                 -- Group by the derived category to aggregate per category.
ORDER BY
    avg_funding_rounds ASC;           -- Sort by the calculated average in ascending order.
                                      -- Or use: ORDER BY ROUND(AVG(investment_rounds)) ASC;

-- Notes:
-- 1. This query assumes 'invested_companies' (for categorization) and 'investment_rounds' (for averaging) are accurate numeric columns in the 'fund' table.
-- 2. The 'investment_rounds' column is interpreted as the number of funding rounds a specific fund entity has participated in. The average is taken over this metric for all funds within a category.
-- 3. The ROUND() function typically rounds .5 away from zero (e.g., 2.5 to 3, -2.5 to -3), but exact behavior for halves can sometimes vary slightly by SQL dialect (e.g., round half to even).