-- Objective: Calculate the total funding raised by companies within each country and present the results sorted, with the highest-funded countries listed first.
-- This analysis helps identify key geographic areas for investment based on total capital attracted.

SELECT
    country_code,                     -- The country identifier from the company table.
    SUM(funding_total) AS total_funding_raised
                                      -- Calculates the sum of 'funding_total' for all companies grouped by their 'country_code'.
FROM
    company
GROUP BY
    country_code                      -- Groups rows with the same 'country_code' together,
                                      -- SUM() operates on each country's data individually.
ORDER BY
    total_funding_raised DESC;        -- Sorts the results by the calculated sum in descending order.
                                      -- Most SQL databases allow using the alias from the SELECT clause here.
                                      -- If not, 'ORDER BY SUM(funding_total) DESC' would be used.

                                      
-- Notes:
-- 1. This query assumes that 'funding_total' values are in a consistent currency (e.g., USD) to allow for meaningful aggregation across all companies.
-- 2. Companies with a NULL 'country_code' would typically form their own group if NULLs are present. Further filtering (e.g., WHERE country_code IS NOT NULL) could be added if needed.