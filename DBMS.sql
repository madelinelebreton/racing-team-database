-- Database project: Formula 1 Racing Team Management
/* Project made by: 
 - Madeline LeBreton
 - André Mendes
 - Artur Martins
*/
-- SCHEMA CREATION
DROP TABLE IF EXISTS Team cascade;

DROP TABLE IF EXISTS RacingVehicle cascade;

DROP TABLE IF EXISTS Engine cascade;

DROP TABLE IF EXISTS Driver cascade;

DROP TABLE IF EXISTS DriverContract cascade;

DROP TABLE IF EXISTS Personnel cascade;

DROP TABLE IF EXISTS RaceEngineer cascade;

DROP TABLE IF EXISTS Mechanic cascade;

DROP TABLE IF EXISTS Director cascade;

CREATE TABLE Team (
    TeamID NUMERIC(15) NOT NULL,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(100) NOT NULL,
    PRIMARY KEY (TeamID)
);

CREATE TABLE RacingVehicle (
    ChassisNUM NUMERIC(15) NOT NULL,
    ModelYear INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    AeroSpec VARCHAR(50),
    TankSize INT NOT NULL,
    TeamID NUMERIC(15) NOT NULL,
    PRIMARY KEY (ChassisNUM),
    FOREIGN KEY (TeamID) REFERENCES Team (TeamID)
);

CREATE TABLE Engine (
    SerialNUM NUMERIC(15) NOT NULL,
    HP INT NOT NULL,
    NM INT NOT NULL,
    ChassisNUM NUMERIC(15) NOT NULL,
    PRIMARY KEY (ChassisNUM, SerialNUM),
    FOREIGN KEY (ChassisNUM) REFERENCES RacingVehicle (ChassisNUM) ON DELETE CASCADE
);

CREATE TABLE Driver (
    FIAID NUMERIC(15) NOT NULL,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    TeamID NUMERIC(15) NOT NULL,
    ChassisNUM NUMERIC(15) NOT NULL UNIQUE,
    PRIMARY KEY (FIAID),
    FOREIGN KEY (TeamID) REFERENCES Team (TeamID),
    FOREIGN KEY (ChassisNUM) REFERENCES RacingVehicle (ChassisNUM)
);

CREATE TABLE DriverContract (
    FIAID NUMERIC(15) NOT NULL,
    TeamID NUMERIC(15) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Salary NUMERIC(15, 2) NOT NULL,
    Reserve BOOLEAN NOT NULL,
    PRIMARY KEY (FIAID, TeamID, StartDate),
    FOREIGN KEY (FIAID) REFERENCES Driver (FIAID),
    FOREIGN KEY (TeamID) REFERENCES Team (TeamID)
);

CREATE TABLE Personnel (
    EmployeeID NUMERIC(15) NOT NULL,
    Salary NUMERIC(15, 2) NOT NULL,
    TeamID NUMERIC(15) NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (TeamID) REFERENCES Team (TeamID)
);

CREATE TABLE RaceEngineer (
    EmployeeID NUMERIC(15) NOT NULL,
    Main BOOLEAN NOT NULL,
    RadioCalls INT NOT NULL,
    Name VARCHAR(100) NOT NULL UNIQUE,
    FIAID NUMERIC(15) NOT NULL UNIQUE,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Personnel (EmployeeID),
    FOREIGN KEY (FIAID) REFERENCES Driver (FIAID)
);

CREATE TABLE Mechanic (
    EmployeeID NUMERIC(15) NOT NULL,
    ChassisNUM NUMERIC(15),
    Specialty VARCHAR(50) NOT NULL,
    WorkHours INT NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Personnel (EmployeeID),
    FOREIGN KEY (ChassisNUM) REFERENCES RacingVehicle (ChassisNUM)
);

CREATE TABLE Director (
    EmployeeID NUMERIC(15) NOT NULL,
    Name VARCHAR(100) NOT NULL UNIQUE,
    ContractUntil DATE,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Personnel (EmployeeID)
);

-- POPULATE TABLES
INSERT INTO
    Team (TeamID, Name, Country)
VALUES
    (1, 'Ferrari', 'Italy'),
    (2, 'Williams', 'UK'),
    (3, 'Red Bull', 'Austria');

INSERT INTO
    RacingVehicle (
        ChassisNUM,
        ModelYear,
        Name,
        AeroSpec,
        TankSize,
        TeamID
    )
VALUES
    (1001, 2025, 'F1-75', 'High', 110, 1),
    (1002, 2025, 'MCL36', 'Medium', 112, 2),
    (1003, 2025, 'RB21', 'Low', 108, 3),
    (1004, 2025, 'RB21', 'Medium', 110, 3);

INSERT INTO
    Engine (SerialNUM, HP, NM, ChassisNUM)
VALUES
    (5001, 1000, 760, 1001),
    (5002, 950, 740, 1002),
    (5003, 1020, 770, 1003),
    (5004, 930, 760, 1004);

INSERT INTO
    Driver (
        FIAID,
        Name,
        Country,
        Age,
        TeamID,
        ChassisNUM
    )
VALUES
    (
        111,
        'Charles Leg',
        'Monaco',
        27,
        1,
        1001
    ),
    (
        6,
        'Nicholas Goatifi',
        'Canada',
        40,
        2,
        1002
    ),
    (
        33,
        'Max Verstappen',
        'Netherlands',
        27,
        3,
        1003
    ),
    (50, 'Yuki Tsunoda', 'Japan', 23, 3, 1004);

INSERT INTO
    DriverContract (
        FIAID,
        TeamID,
        StartDate,
        EndDate,
        Salary,
        Reserve
    )
VALUES
    (
        111,
        1,
        '2023-01-01',
        '2025-12-31',
        8000000,
        FALSE
    ),
    (
        6,
        2,
        '2022-02-01',
        '2024-12-31',
        100000000,
        FALSE
    ),
    (
        33,
        3,
        '2023-05-01',
        '2025-11-30',
        9000000,
        FALSE
    ),
    (50, 3, '2024-01-01', NULL, 600000, TRUE);

INSERT INTO
    Personnel (EmployeeID, Salary, TeamID)
VALUES
    -- 4 RaceEngineers (1 per driver)
    (2001, 150000, 1),
    (2002, 120000, 2),
    (2003, 140000, 3),
    (2004, 130000, 3),
    -- 4 Mechanics (1 per car)
    (3001, 110000, 1),
    (3002, 160000, 2),
    (3003, 170000, 3),
    (3004, 180000, 3),
    (3005, 120000, 2),
    (3006, 115000, 1),
    -- 3 Directors (1 per team)
    (4001, 300000, 1),
    (4002, 250000, 2),
    (4003, 280000, 3);

INSERT INTO
    RaceEngineer (EmployeeID, Main, RadioCalls, Name, FIAID)
VALUES
    (2001, TRUE, 1500, 'Nicholas James', 111),
    (2002, FALSE, 1300, 'James Anderson', 6),
    (2003, TRUE, 1400, 'Michael Smith', 33),
    (2004, FALSE, 1200, 'David Brown', 50);

INSERT INTO
    Mechanic (EmployeeID, ChassisNUM, Specialty, WorkHours)
VALUES
    (3001, 1001, 'Engine', 40),
    (3002, 1002, 'Aero', 35),
    (3003, 1003, 'Tire', 30),
    (3004, 1004, 'Suspension', 25),
    (3005, NULL, 'Hydraulics', 20),
    (3006, 1001, 'Electrics', 15);

INSERT INTO
    Director (EmployeeID, Name, ContractUntil)
VALUES
    (4001, 'Mattia SBinalla', '2028-12-31'),
    (4002, 'James Vowels', '2025-06-30'),
    (4003, 'Christian Horner', '2026-11-30');

-- 5 QUERIES WITHOUT AGGREGATES
-- 1) Directors with a contract expiring next year
-- (Director:ContractUntil < current_date)[Name]
SELECT
    Name
FROM
    Director
WHERE
    ContractUntil BETWEEN CURRENT_DATE
    AND CURRENT_DATE + INTERVAL '1 year';

-- output:
/*
 name     
 --------------
 James Vowels
 (1 row)
 */
-- 2) Retrieve the names of drivers and the country of their team
-- A ← Driver X Team
-- B ← A:Driver.TeamID = Team.TeamID
-- R ← B[Driver.Name, Team.Country]
SELECT
    Driver.Name,
    Team.Country
FROM
    Driver
    JOIN Team ON Driver.TeamID = Team.TeamID;

-- output:
/*
 name       | country 
 ------------------+---------
 Charles Leg      | Italy
 Nicholas Goatifi | UK
 Max Verstappen   | Austria
 Yuki Tsunoda     | Austria
 (4 rows)
 */
-- 3) Mechanics that are not assigned to a vehicle
-- (Mechanic:ChassisNUM IS NULL)[EmployeeID]
SELECT
    EmployeeID
FROM
    Mechanic
WHERE
    ChassisNUM IS NULL;

-- output:
/*
 employeeid 
 ------------
 3005
 (1 row)
 */
-- 4) Drivers ordered by age, youngest first
-- Driver[Name, Age] ORDER BY Age ASC
SELECT
    Name,
    Age
FROM
    Driver
ORDER BY
    Age ASC;

-- output:
/*
 name       | age 
 ------------------+-----
 Yuki Tsunoda     |  23
 Charles Leg      |  27
 Max Verstappen   |  27
 Nicholas Goatifi |  40
 (4 rows)
 */
-- 5) Drivers that are reserves
-- A ← Driver[FIAID]
-- B ← DriverContract:Reserve = FALSE
-- C ← B[FIAID]
-- R ← A - C
SELECT
    Driver.FIAID
FROM
    Driver
EXCEPT
SELECT
    DriverContract.FIAID
FROM
    DriverContract
WHERE
    Reserve = FALSE;

-- output:
/*
 fiaid 
 -------
 50
 (1 row)
 */
-- 3 QUERIES REQUIRING AGGREGATES
-- 1) Total personnel salary per team
-- TotalSalary(TeamID, TotalSalary) ← γ_{TeamID; SUM(Salary)→TotalSalary}(Personnel)
SELECT
    TeamID,
    SUM(Salary) AS TotalSalary
FROM
    Personnel
GROUP BY
    TeamID;

-- output:
/*
 teamid | totalsalary 
 --------+-------------
 3 |   900000.00
 1 |   675000.00
 2 |   650000.00
 (3 rows)
 */
-- 2) Number of mechanics per team (requires join to get TeamID)
-- A ← Mechanic * Personnel  
-- B ← A[TeamID, EmployeeID]  
-- MechanicCount(TeamID, NumMechanics) ← γ_{TeamID; COUNT(EmployeeID)→NumMechanics}(B)
SELECT
    TeamID,
    COUNT(EmployeeID) AS NumMechanics
FROM
    Mechanic NATURAL
    JOIN Personnel
GROUP BY
    TeamID;

-- output:
/*
 teamid | nummechanics 
 --------+--------------
 3 |            2
 1 |            2
 2 |            2
 (3 rows)
 */
-- 3) Average engine horsepower per team (join Engine→RacingVehicle to get TeamID)
-- C ← Engine * RacingVehicle  
-- D ← C[TeamID, HP]  
-- AvgEngineHP(TeamID, AvgHP) ← γ_{TeamID; AVG(HP)→AvgHP}(D)
SELECT
    TeamID,
    AVG(HP) AS AvgHP
FROM
    Engine NATURAL
    JOIN RacingVehicle
GROUP BY
    TeamID;

-- output:
/*
 teamid |         avghp         
 --------+-----------------------
 3 |  975.0000000000000000
 1 | 1000.0000000000000000
 2 |  950.0000000000000000
 (3 rows)
 */
