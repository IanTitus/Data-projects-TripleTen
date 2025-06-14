-- Objective: Identify individuals whose Twitter usernames start with 'Silver'.
-- This query retrieves the first name, last name, and Twitter username for such individuals,
-- which can be used for targeted outreach to potential industry influencers.

SELECT
    first_name,
    last_name,
    twitter_username
FROM
    people
WHERE
    twitter_username LIKE 'Silver%';
    -- The LIKE operator is used for pattern matching.
    -- 'Silver%' matches any string that starts with "Silver".
    -- The '%' wildcard matches any sequence of zero or more characters.
    -- Note on case sensitivity: The behavior of LIKE (case-sensitive vs. case-insensitive) can vary depending on the database system and its collation settings. For case-insensitive matching, some systems use ILIKE or functions like LOWER().
