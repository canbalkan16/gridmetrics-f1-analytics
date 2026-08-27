SET search_path TO f1;


CREATE OR REPLACE VIEW vw_constructor_championship AS
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
    constructorName;

CREATE OR REPLACE VIEW vw_constructor_championship AS
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
    constructorName;

CREATE OR REPLACE VIEW vw_qualifying_performance AS
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
    constructorName;


CREATE OR REPLACE VIEW vw_pitstop_performance AS
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
    rr.constructorName;

CREATE OR REPLACE VIEW vw_race_performance AS
SELECT
    rr.season,
    rr.round,
    r.raceName,
    r.circuitName,
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
WHERE rr.position IS NOT NULL;


SELECT
    round,
    COUNT(*) AS driver_results
FROM race_results
WHERE season = 2024
GROUP BY round
ORDER BY round;


SELECT
    MIN(round) AS first_round,
    MAX(round) AS last_round,
    COUNT(DISTINCT round) AS total_rounds,
    COUNT(*) AS total_results
FROM race_results
WHERE season = 2024;


SELECT
    driverName,
    SUM(points) AS total_points
FROM race_results
WHERE season = 2024
GROUP BY driverName
ORDER BY total_points DESC;


SELECT
    driverName,
    SUM(points) AS total_points
FROM race_results
WHERE season = 2023
GROUP BY driverName
ORDER BY total_points DESC;



SELECT
    season,
    round,
    driverName,
    position,
    points
FROM race_results
WHERE season = 2023
  AND driverName = 'Max Verstappen'
ORDER BY round;


SELECT
    season,
    COUNT(DISTINCT round) AS rounds,
    COUNT(*) AS verstappen_results,
    SUM(points) AS race_points
FROM race_results
WHERE season = 2023
  AND driverName = 'Max Verstappen'
GROUP BY season;




-- 1. Season completeness by table
SELECT
    'races' AS table_name,
    COUNT(DISTINCT round) AS rounds
FROM races
WHERE season = 2024

UNION ALL

SELECT
    'race_results',
    COUNT(DISTINCT round)
FROM race_results
WHERE season = 2024

UNION ALL

SELECT
    'qualifying_results',
    COUNT(DISTINCT round)
FROM qualifying_results
WHERE season = 2024

UNION ALL

SELECT
    'pitstops',
    COUNT(DISTINCT round)
FROM pitstops
WHERE season = 2024;

-- 3. Dashboard KPI check
SELECT
    COUNT(DISTINCT round) AS races,
    COUNT(DISTINCT driverId) AS drivers,
    COUNT(DISTINCT constructorId) AS teams,
    COUNT(DISTINCT driverId) FILTER (WHERE position = 1) AS race_winners
FROM race_results
WHERE season = 2024;


SELECT
    driverName,
    COUNT(DISTINCT round) AS races_recorded,
    SUM(points) AS race_points
FROM race_results
WHERE season = 2024
GROUP BY driverName
ORDER BY races_recorded DESC, race_points DESC;



SELECT
                         season,
                         COUNT(DISTINCT round) AS races,
                         COUNT(DISTINCT driverId) AS drivers,
                         COUNT(DISTINCT constructorId) AS teams,
                         COUNT(*) AS result_rows
                     FROM race_results
                     GROUP BY season
                     ORDER BY season DESC;


SELECT
    season,
    MIN(round) AS first_round,
    MAX(round) AS last_round,
    COUNT(DISTINCT round) AS rounds
FROM races
GROUP BY season
ORDER BY season DESC;


SELECT
    season,
    COUNT(*) FILTER (WHERE position = 1) AS poles,
    COUNT(DISTINCT driverId) FILTER (WHERE position = 1) AS pole_sitters
FROM qualifying_results
GROUP BY season
ORDER BY season DESC;



SELECT
    season,
    driverName,
    COUNT(*) AS poles
FROM qualifying_results
WHERE position = 1
  AND season >= 2021
GROUP BY season, driverName
ORDER BY season DESC, poles DESC;