-- Uploaded the tables seperately as CSV files and want to test if data is correct --

SELECT*
FROM user_profiles
LIMIT 10;

SELECT *
FROM viewership
LIMIT 10;

-- Count the total number of rows in both tables--

SELECT COUNT(*) AS total_users
FROM user_profiles;

SELECT COUNT(*) AS total_sessions
FROM viewership;

-- Checking the data for missing values --

SELECT
  COUNT(*) AS total_rows,
  COUNT(Gender) AS gender_not_null,
  COUNT(Race) AS race_not_null,
  COUNT (Province) AS province_not_null
FROM user_profiles;

-- User Anaylysis: The queries below are to determine the user base of BrightTV based on demographics--

-- Checking users by Gender --

SELECT
    COALESCE(Gender, 'Unknown') AS Gender,
    COUNT(*) AS total_users
FROM user_profiles
GROUP BY COALESCE(Gender, 'Unknown')
ORDER BY total_users DESC;

-- Checking for users by Race --

SELECT
    COALESCE (Race, 'Unknown') AS Race,
    COUNT(*) AS total_users
    FROM user_profiles
    GROUP BY COALESCE (Race, 'Unknown')
    ORDER BY total_users DESC;

-- Checking for users by Province --

SELECT
    COALESCE (Province, 'Unknown') AS Province,
    COUNT(*) AS total_users
    FROM user_profiles
    GROUP BY COALESCE (Province, 'Unknown')
    ORDER BY total_users DESC;

-- Checking the aggregate age of the user base --

SELECT 
    MIN(Age) AS youngest_user,
    MAX(Age) AS oldest_user,
    AVG(Age) AS average_age
FROM user_profiles;

-- Checking the different Age Groups of the user base --

SELECT 
    CASE
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        WHEN Age BETWEEN 65 AND 74 THEN '65-74'
        WHEN Age BETWEEN 75 AND 84 THEN '75-84'
        WHEN Age >= 85 THEN '85+'
    ELSE 'Unknown'
    END AS age_group,   
    COUNT(*) AS total_users
FROM user_profiles
GROUP BY age_group
ORDER BY total_users DESC;

-- Viewership Analysis: The queries below are to determine the viewership of BrightTV based on demographics--

-- Convert the time from UTC to South African Time (UTC+2) --

SELECT
    RecordDate2,
    timestampadd (HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')) AS sa_time
FROM viewership
LIMIT 10;

-- Checking the total number of sessions by channel --

SELECT
    Channel2,
    COUNT(*) AS total_sessions
FROM viewership
GROUP BY Channel2
ORDER BY total_sessions DESC;

-- Checking for total number of session by Date --

SELECT
    DATE(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm'))) AS sa_date,
    COUNT(*) AS total_sessions
FROM viewership
GROUP BY DATE(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')))
ORDER BY sa_date DESC;

-- Checking for total number of sessions by Hour --

SELECT
    HOUR(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm'))) AS hour_of_day,
    COUNT(*) AS total_sessions
FROM viewership
GROUP BY HOUR(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')))
ORDER BY hour_of_day;

-- Checking sessions by day of the week to determine which days have the highest activity and which days have the lowest activity --

SELECT
    DATE_FORMAT(
        timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')),
        'E'
    ) AS day_of_week,
    COUNT(*) AS total_sessions
FROM viewership
GROUP BY DATE_FORMAT(
    timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')),
    'E'
)
ORDER BY total_sessions DESC;

-- Join the user_profiles and viewership tables to enrich viewership data with user demographics --

SELECT
    u.UserID,
    COALESCE(u.Gender, 'Unknown') AS Gender,
    COALESCE(u.Province, 'Unknown') AS Province,
    COALESCE(u.Race, 'Unknown') AS Race,
    u.Age,
    v.Channel2,

    DATE(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm'))) AS sa_date,
    HOUR(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm'))) AS hour_of_day,
    DATE_FORMAT(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')), 'E') AS day_of_week

FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
LIMIT 10;

-- Check the data for inactive users --

SELECT
    u.UserID,
    COALESCE(u.Gender, 'Unknown') AS Gender,
    COALESCE(u.Province, 'Unknown') AS Province,
    COALESCE (u.Race, 'Unknown') AS Race,
    u.Age
FROM user_profiles AS u
LEFT JOIN viewership AS v
    ON u.UserID = v.UserID
WHERE v.UserID IS NULL;

-- Checking for the most and least active users for the purpose of engagement analysis --

SELECT
    v.UserID,
    COUNT(*) AS total_sessions
FROM viewership AS v
GROUP BY v.UserID
ORDER BY total_sessions DESC;

-- Checking the total number of sessions by gender --

SELECT
    COALESCE(u.Gender, 'Unknown') AS Gender,
    COUNT(*) AS total_sessions
FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
GROUP BY COALESCE(u.Gender, 'Unknown')
ORDER BY total_sessions DESC;

-- Checking the total number of sessions by Race --

SELECT
    COALESCE(u.Race, 'Unknown') AS Race,
    COUNT(*) AS total_sessions
FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
GROUP BY COALESCE(u.Race, 'Unknown')
ORDER BY total_sessions DESC;

-- Check the total number of sessions by Province --

SELECT
    COALESCE(u.Province, 'Unknown') AS Province,
    COUNT(*) AS total_sessions
FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
GROUP BY COALESCE(u.Province, 'Unknown')
ORDER BY total_sessions DESC;

-- Check the total number of sessions by Age Group --

SELECT
    CASE
        WHEN u.Age < 18 THEN 'Under 18'
        WHEN u.Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN u.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN u.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN u.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_sessions
FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
GROUP BY
    CASE
        WHEN u.Age < 18 THEN 'Under 18'
        WHEN u.Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN u.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN u.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN u.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END
ORDER BY total_sessions DESC;

-- Running a query that will help us see what content is most popular --

SELECT
    v.Channel2,
    COUNT(*) AS total_sessions
FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
GROUP BY v.Channel2
ORDER BY total_sessions DESC;

-- Checking what content performs poorly on low-consumption days --

SELECT
    DATE_FORMAT(
        timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')),
        'E'
    ) AS day_of_week,
    v.Channel2,
    COUNT(*) AS total_sessions
FROM user_profiles u
INNER JOIN viewership v
    ON u.UserID = v.UserID
GROUP BY
    DATE_FORMAT(timestampadd(HOUR, 2, to_timestamp(RecordDate2, 'yyyy/MM/dd HH:mm')), 'E'),
    v.Channel2
ORDER BY total_sessions ASC;

-- Query to create analysis-ready dataset for use in Excel pivot tables, charts and dashboard visuals --

SELECT
    u.UserID,
    u.Name,
    u.Surname,
    u.Email,
    COALESCE(u.Gender, 'Unknown') AS Gender,
    COALESCE(u.Race, 'Unknown') AS Race,
    u.Age,
    COALESCE(u.Province, 'Unknown') AS Province,
    COALESCE(u.`Social Media Handle`, 'Unknown') AS Social_Media_Handle,

    v.Channel2,
    v.`Duration 2` AS Duration,

    to_timestamp(v.RecordDate2, 'yyyy/MM/dd HH:mm') AS utc_time,
    timestampadd(HOUR, 2, to_timestamp(v.RecordDate2, 'yyyy/MM/dd HH:mm')) AS sa_time,
    DATE(timestampadd(HOUR, 2, to_timestamp(v.RecordDate2, 'yyyy/MM/dd HH:mm'))) AS sa_date,
    HOUR(timestampadd(HOUR, 2, to_timestamp(v.RecordDate2, 'yyyy/MM/dd HH:mm'))) AS hour_of_day,
    DATE_FORMAT(timestampadd(HOUR, 2, to_timestamp(v.RecordDate2, 'yyyy/MM/dd HH:mm')), 'E') AS day_of_week,

    CASE
        WHEN u.Age < 18 THEN 'Under 18'
        WHEN u.Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN u.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN u.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN u.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group

FROM user_profiles AS u
INNER JOIN viewership AS v
    ON u.UserID = v.UserID
ORDER BY sa_date, hour_of_day;
