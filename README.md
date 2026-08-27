# gridmetrics-f1-analytics



🏎️ GridMetrics — Formula 1 Season Analytics
GridMetrics is an end-to-end Formula 1 analytics project built with PostgreSQL, SQL, and Power BI.

The project explores historical Formula 1 race data with a focus on driver performance, constructor performance, race results, qualifying, and starting-grid vs finishing-position analysis.

The final output is an interactive Power BI dashboard where users can explore results by season, driver, and team.

📊 Dashboard
GridMetrics Dashboard

Dashboard features
Season, driver, and team filtering
Driver championship points ranking
Constructor championship points ranking
Race wins by constructor
Starting grid vs finishing position analysis
Season-level KPI cards for races, drivers, teams, race winners, and pole sitters
🗂️ Data Model
The Power BI model connects race, driver, constructor, qualifying, circuit, and pit-stop data to support interactive analysis across multiple Formula 1 seasons.

Power BI Data Model

🔍 SQL Analysis
The analysis was performed in PostgreSQL before creating reporting views for Power BI.

Examples include:

Race-by-race driver performance
Positions gained from starting grid to finishing position
Driver and constructor championship performance
Race wins and podiums
Average finishing position
Qualifying and pole-position analysis
Season-level aggregations
Example: Race-by-Race Driver Performance
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
    AND rr.grid > 0
ORDER BY
    rr.season,
    rr.round,
    rr.position;
Example: Constructor Performance View
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
🛠️ Tools & Technologies
PostgreSQL — database and analytical queries
SQL — data exploration, joins, aggregations, calculated metrics, and reporting views
Power BI — data modeling, DAX measures, interactive filtering, and dashboard development
DataGrip — PostgreSQL development environment
📁 Repository Structure
gridmetrics-f1-analytics/
│
├── data/
│   ├── circuits.csv
│   ├── constructors.csv
│   ├── drivers.csv
│   ├── pitstops.csv
│   ├── qualifying_results.csv
│   ├── race_results.csv
│   └── races.csv
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_exploratory_analysis.sql
│   ├── 03_driver_analysis.sql
│   ├── 04_constructor_analysis.sql
│   ├── 05_race_analysis.sql
│   └── 06_powerbi_views.sql
│
├── images/
│   ├── gridmetrics_dashboard.png
│   └── data_model.png
│
├── powerbi/
│   └── GridMetrics.pbix
│
└── README.md
📈 Project Workflow
Raw Formula 1 Data → PostgreSQL → SQL Analysis → Power BI Data Model → Interactive Dashboard

The project was designed to demonstrate an end-to-end analytics workflow, from structuring and querying raw Formula 1 data to building an interactive business intelligence dashboard.
