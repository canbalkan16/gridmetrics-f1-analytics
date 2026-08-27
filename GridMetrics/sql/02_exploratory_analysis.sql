03_exploratory_analysis.sql

SET search_path TO f1;


SELECT
    season,
    driverName,
    constructorName,
    SUM(points) AS total_points,
    COUNT(*) FILTER (WHERE position = 1) AS wins,
    COUNT(*) FILTER (WHERE position <= 3) AS podiums
FROM race_results
GROUP BY
    season,
    driverName,
    constructorName
ORDER BY
    season,
    total_points DESC;

SELECT
    season,
    constructorName,
    SUM(points) AS total_points,
    COUNT(*) FILTER (WHERE position = 1) AS wins,
    COUNT(*) FILTER (WHERE position <= 3) AS podiums
FROM race_results
GROUP BY
    season,
    constructorName
ORDER BY
    season,
    total_points DESC;

SELECT
    season,
    driverName,
    constructorName,
    ROUND(AVG(grid), 2) AS avg_grid_position,
    ROUND(AVG(position), 2) AS avg_finish_position,
    ROUND(AVG(grid - position), 2) AS avg_positions_gained
FROM race_results
WHERE
    position IS NOT NULL
  AND grid > 0
GROUP BY
    season,
    driverName,
    constructorName
ORDER BY
    season,
    avg_positions_gained DESC;


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


SELECT
    p.season,
    r.constructorName,
    ROUND(AVG(p.duration), 3) AS avg_pit_stop,
    MIN(p.duration) AS fastest_pit_stop,
    COUNT(*) AS total_pit_stops
FROM pitstops p
         JOIN race_results r
              ON p.season = r.season
                  AND p.round = r.round
                  AND p.driverId = r.driverId
GROUP BY
    p.season,
    r.constructorName
ORDER BY
    p.season,
    avg_pit_stop;

SELECT
    rr.season,
    rr.round,
    r.raceName,
    rr.driverName,
    rr.constructorName,
    rr.grid,
    rr.position,
    rr.points,
    rr.grid - rr.position AS positions_gained
FROM race_results rr
         JOIN races r
              ON rr.season = r.season
                  AND rr.round = r.round
WHERE rr.position IS NOT NULL
ORDER BY
    rr.season,
    rr.round,
    rr.position;

SELECT COUNT(*)
FROM race_results;


SELECT DISTINCT season
FROM race_results
ORDER BY season;

SELECT
    COUNT(*) AS total_rows,
    COUNT(position) AS non_null_positions
FROM race_results;


SELECT COUNT(*)
FROM race_results rr
         JOIN races r
              ON rr.season = r.season
                  AND rr.round = r.round;



SELECT season, round
FROM race_results
ORDER BY season DESC, round
LIMIT 20;


SELECT season, round
FROM races
ORDER BY season DESC, round
LIMIT 20;


DROP TABLE races;

CREATE TABLE races (
                       season INT,
                       round INT,
                       raceName VARCHAR(100),
                       circuitId VARCHAR(50),
                       circuitName VARCHAR(100),
                       date VARCHAR(20),
                       time VARCHAR(20),
                       firstPractice VARCHAR(50),
                       secondPractice VARCHAR(50),
                       thirdPractice VARCHAR(50),
                       qualifying VARCHAR(50),
                       sprint VARCHAR(50),
                       url TEXT,
                       PRIMARY KEY (season, round)
);


