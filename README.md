# Formula 1 Racing Team Management Database

A relational database project for managing Formula 1 racing teams, drivers, vehicles, engines, contracts, and team personnel.

## Overview

This project models the relationships between F1 teams and their drivers, racing vehicles, engines, mechanics, race engineers, and directors. It demonstrates relational database design, **SQL** schema creation, data population, joins, filtering, set operations, and aggregate queries.

## Database Structure
<img width="1302" height="529" alt="image" src="https://github.com/user-attachments/assets/12c2125b-ca17-4893-ae99-867a3f561222" />

The database includes the following tables:

- **Team** — team information and country
- **RacingVehicle** — chassis, model year, aerodynamics, and fuel capacity
- **Engine** — engine performance and chassis assignment
- **Driver** — driver information and vehicle assignment
- **DriverContract** — driver contracts, salaries, and reserve status
- **Personnel** — team employees and salaries
- **RaceEngineer** — race engineer information and driver assignments
- **Mechanic** — mechanic specialties, vehicle assignments, and work hours
- **Director** — team director information and contract dates

## SQL Features

- Table creation and foreign key constraints
- Primary and composite keys
- Data insertion
- `JOIN` and `NATURAL JOIN`
- Filtering with `WHERE`
- Sorting with `ORDER BY`
- Set operations with `EXCEPT`
- Aggregate functions including `SUM`, `COUNT`, and `AVG`
- `GROUP BY`
- Date and interval operations

## Example Queries

- Which directors have contracts expiring within the next year?
- What country is each driver's team from?
- Which mechanics are currently unassigned to a vehicle?
- Who are the youngest drivers?
- Which drivers are reserves?
- What is the total personnel salary for each team?
- How many mechanics does each team have?
- What is the average engine horsepower per team?

## Project Authors

Created as part of a Database Foundations course at Université Grenoble Alpes
- Madeline LeBreton
- André Mendes
- Artur Martins

## Technologies
- **SQL**
- PostgreSQL
