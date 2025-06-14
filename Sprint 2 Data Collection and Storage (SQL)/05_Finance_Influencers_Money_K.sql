-- Objective: Identify finance-focused individuals whose Twitter usernames contain 'money' AND whose last names start with the letter 'K'.
-- This query retrieves all available information for these specific influencers.

SELECT
    * -- Selects all columns from the 'people' table for matching individuals.
FROM
    people
WHERE
    twitter_username LIKE '%money%' -- Condition 1: Twitter username contains 'money' anywhere.
                                    -- The '%' wildcard on both sides matches any characters
                                    -- before or after the word 'money'.
    AND last_name LIKE 'K%';        -- Condition 2: Last name starts with 'K'.
                                    -- The '%' wildcard matches any characters after the initial 'K'.
                                 	-- Notes on Case Sensitivity for LIKE:
                               		-- The behavior of LIKE (case-sensitive vs. case-insensitive) depends on the database system and its collation settings.
                                    -- This query matches 'money' (lowercase) and 'K' (uppercase) as specified.
                                    -- For case-insensitive matching (e.g., to include 'Money' or 'k...'), alternatives like ILIKE or functions like LOWER() could be used: e.g., LOWER(twitter_username) LIKE '%money%' AND LOWER(last_name) LIKE 'k%'