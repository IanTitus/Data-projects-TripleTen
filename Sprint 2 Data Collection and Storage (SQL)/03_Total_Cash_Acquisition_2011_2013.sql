-- Objective: Calculate the total monetary value of company acquisitions that were made in cash between January 1, 2011, and December 31, 2013.
-- This analysis helps quantify cash-based M&A activity during a specific period.

SELECT
    SUM(price_amount) AS total_cash_acquisition_2011_to_2013
    -- This sums the 'price_amount' for all acquisitions meeting the criteria.
    -- The result represents the total value in US dollars, as per the problem description.
FROM
    acquisition
WHERE
    term_code = 'cash'  -- Filters for acquisitions where the payment term was 'cash'.
    AND acquired_at >= '2011-01-01' -- Start of the period.
    AND acquired_at <= '2013-12-31'; -- End of the period.
    -- Note: This date comparison assumes 'acquired_at' is a DATE or DATETIME type and can be directly compared with 'YYYY-MM-DD' formatted strings.
    -- For some SQL dialects or if 'acquired_at' only stores year, functions like YEAR(acquired_at) or strftime('%Y', acquired_at) might be used, such as AND YEAR(acquired_at) BETWEEN 2011 AND 2013