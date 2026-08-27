CREATE DATABASE gridmetrics;


CREATE SCHEMA f1;

SET search_path TO f1;

CREATE TABLE circuits (
                          circuitId      VARCHAR(50) PRIMARY KEY,
                          circuitName    VARCHAR(100),
                          lat            DECIMAL(9,6),
                          long           DECIMAL(9,6),
                          locality       VARCHAR(100),
                          country        VARCHAR(100),
                          url            TEXT
);

SELECT current_database();

SELECT current_schema();

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'f1';

SET search_path TO f1;

SELECT current_schema();



CREATE TABLE constructors (
                              constructorId VARCHAR(50) PRIMARY KEY,
                              constructorName VARCHAR(100),
                              nationality VARCHAR(50),
                              url TEXT
);

CREATE TABLE drivers (
                         driverId VARCHAR(50) PRIMARY KEY,
                         givenName VARCHAR(100),
                         familyName VARCHAR(100),
                         code VARCHAR(10),
                         permanentNumber INT,
                         dateOfBirth DATE,
                         nationality VARCHAR(50),
                         url TEXT
);

CREATE TABLE races (
                       season INT,
                       round INT,
                       raceName VARCHAR(100),
                       circuitId VARCHAR(50),
                       circuitName VARCHAR(100),
                       date DATE,
                       time TIME,
                       firstPractice TIMESTAMP,
                       secondPractice TIMESTAMP,
                       thirdPractice TIMESTAMP,
                       qualifying TIMESTAMP,
                       sprint TIMESTAMP,
                       url TEXT,
                       PRIMARY KEY (season, round)
);

CREATE TABLE race_results (
                              season INT,
                              round INT,
                              driverId VARCHAR(50),
                              driverName VARCHAR(100),
                              constructorId VARCHAR(50),
                              constructorName VARCHAR(100),
                              number INT,
                              position INT,
                              positionText VARCHAR(20),
                              points NUMERIC(5,2),
                              grid INT,
                              laps INT,
                              status VARCHAR(50),
                              time VARCHAR(50),
                              fastestLapRank INT,
                              fastestLap INT,
                              fastestLapTime VARCHAR(20),
                              averageSpeed NUMERIC(6,3),
                              PRIMARY KEY (season, round, driverId)
);

CREATE TABLE qualifying_results (
                                    season INT,
                                    round INT,
                                    driverId VARCHAR(50),
                                    driverName VARCHAR(100),
                                    constructorId VARCHAR(50),
                                    constructorName VARCHAR(100),
                                    number INT,
                                    position INT,
                                    Q1 VARCHAR(20),
                                    Q2 VARCHAR(20),
                                    Q3 VARCHAR(20),
                                    PRIMARY KEY (season, round, driverId)
);

CREATE TABLE pitstops (
                          season INT,
                          round INT,
                          driverId VARCHAR(50),
                          lap INT,
                          stop INT,
                          time TIME,
                          duration NUMERIC(6,3),
                          PRIMARY KEY (season, round, driverId, stop)
);