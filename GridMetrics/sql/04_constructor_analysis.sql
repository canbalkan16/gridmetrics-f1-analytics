SET search_path TO f1;

-- 1. Constructor season summary
SELECT
    season,
    constructorName,
    SUM(points) AS total_points,
    COUNT(*) FILTER (WHERE position = 1) AS wins,
    COUNT(*) FILTER (WHERE position <= 3) AS podiums,
    ROUND(AVG(position), 2) AS avg_finish_position
FROM race_results
WHERE position IS NOT NULL
GROUP BY
    season,
    constructorName
ORDER BY
    season,
    total_points DESC;

-- 2. Constructor qualifying performance
SELECT
    season,
    constructorName,
    ROUND(AVG(position), 2) AS avg_qualifying_position,
    COUNT(*) FILTER (WHERE position = 1) AS pole_positions
FROM qualifying_results
GROUP BY
    season,
    constructorName
ORDER BY
    season,
    avg_qualifying_position;

-- 3. Constructor pit stop performance
SELECT
    p.season,
    rr.constructorName,
    ROUND(AVG(p.duration), 3) AS avg_pit_stop,
    MIN(p.duration) AS fastest_pit_stop,
    COUNT(*) AS total_pit_stops
FROM pitstops p
         JOIN race_results rr
              ON p.season = rr.season
                  AND p.round = rr.round
                  AND p.driverId = rr.driverId
GROUP BY
    p.season,
    rr.constructorName
ORDER BY
    p.season,
    avg_pit_stop;


