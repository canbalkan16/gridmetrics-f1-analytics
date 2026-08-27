SET search_path TO f1;

-- 1. Race-by-race driver performance
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

-- 2. Race winners by season
SELECT
    rr.season,
    rr.round,
    r.raceName,
    rr.driverName,
    rr.constructorName,
    rr.points
FROM race_results rr
         JOIN races r
              ON rr.season = r.season
                  AND rr.round = r.round
WHERE rr.position = 1
ORDER BY
    rr.season,
    rr.round;


-- 3. Circuit performance by constructor
SELECT
    rr.season,
    r.circuitName,
    rr.constructorName,
    SUM(rr.points) AS total_points,
    COUNT(*) FILTER (WHERE rr.position = 1) AS wins,
    ROUND(AVG(rr.position), 2) AS avg_finish_position
FROM race_results rr
         JOIN races r
              ON rr.season = r.season
                  AND rr.round = r.round
WHERE rr.position IS NOT NULL
GROUP BY
    rr.season,
    r.circuitName,
    rr.constructorName
ORDER BY
    rr.season,
    total_points DESC;


-- 4. Race points trend by constructor
SELECT
    rr.season,
    rr.round,
    r.raceName,
    rr.constructorName,
    SUM(rr.points) AS race_points
FROM race_results rr
         JOIN races r
              ON rr.season = r.season
                  AND rr.round = r.round
GROUP BY
    rr.season,
    rr.round,
    r.raceName,
    rr.constructorName
ORDER BY
    rr.season,
    rr.round,
    race_points DESC;


