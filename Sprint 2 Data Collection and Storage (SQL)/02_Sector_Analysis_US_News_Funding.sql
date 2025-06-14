-- Objective: Identify total funding for US-based news companies, highlighting top-funded entities.
-- This query retrieves the company name and its total funding for entities in the 'news'
-- sector and 'USA' country, ordered by funding amount in descending order.

SELECT
    name,          -- Company name
    funding_total  -- Total funding amount raised (numeric value, represents USD)
FROM
    company
WHERE
    category_code = 'news'     -- Filter for news-related companies
    AND country_code = 'USA'   -- Filter for companies based in the USA
ORDER BY
    funding_total DESC;    -- Sorts from highest to lowest funding