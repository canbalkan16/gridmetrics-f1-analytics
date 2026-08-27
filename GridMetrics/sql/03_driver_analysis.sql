SET search_path TO f1;

-- 1. Driver season summary
SELECT
    season,
    driverName,
    constructorName,
    SUM(points) AS total_points,
    COUNT(*) FILTER (WHERE position = 1) AS wins,
    COUNT(*) FILTER (WHERE position <= 3) AS podiums,
    ROUND(AVG(position), 2) AS avg_finish_position
FROM race_results
WHERE position IS NOT NULL
GROUP BY
    season,
    driverName,
    constructorName
ORDER BY
    season,
    total_points DESC;

-- 2. Fastest laps by driver
SELECT
    season,
    driverName,
    constructorName,
    COUNT(*) FILTER (WHERE fastestLapRank = 1) AS fastest_laps
FROM race_results
GROUP BY
    season,
    driverName,
    constructorName
ORDER BY
    season,
    fastest_laps DESC;


-- 3. Qualifying performance
SELECT
    season,
    driverName,
    constructorName,
    ROUND(AVG(position), 2) AS avg_qualifying_position,
    COUNT(*) FILTER (WHERE position = 1) AS pole_positions
FROM qualifying_results
GROUP BY
    season,
    driverName,
    constructorName
ORDER BY
    season,
    avg_qualifying_position;