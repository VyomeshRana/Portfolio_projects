-- Covid 19 Data Exploration
SELECT 
  location,
  date,
  total_cases,
  total_deaths,
  population
FROM 
  covid_deaths ;


-- looking at total cases vs total deaths
SELECT 
  location,
  date,
  total_cases,
  total_deaths,
  (total_deaths / total_cases) * 100 AS death_percentage
FROM 
  covid_deaths 
ORDER BY 
  1, 2 ;

 
-- likelihood of dying if you contract covid (india)
SELECT 
  location,
  date,
  total_cases,
  total_deaths,
  (total_deaths / total_cases) * 100 AS death_percentage
FROM 
  covid_deaths
WHERE
  location like '%india%' 
ORDER BY 
  1, 2 ;


-- looking at Total cases vs population
-- shows what % of population got covid
SELECT 
  location,
  date,
  population,
  total_cases,
  (total_cases / population) * 100 AS percent_population_infected
FROM 
  covid_deaths
-- WHERE location like '%india%' 
ORDER BY
  1, 2 ;


-- Looking at countries with Highest Infected rate compared to population
SELECT 
  location,
  population,
  MAX(total_cases) AS higest_infection_count, 
  MAX(total_cases / population) * 100 AS percent_population_infected
FROM 
  covid_deaths
-- WHERE location like '%india%' 
GROUP BY
  location, population
ORDER BY
  percent_population_infected DESC ;
 

-- Showing countries with highest death count population
SELECT 
  location,
  MAX(total_deaths) AS total_death_count
FROM 
  covid_deaths
WHERE
  continent <> ''
GROUP BY
  location
ORDER BY
  total_death_count DESC ;



-- EXPLORING DATA BY CONTINENTS
-- Showing continents with highest death count per population
SELECT 
  location,
  population,
  MAX(total_deaths) AS total_death_count
FROM 
  covid_deaths
WHERE 
  continent = ''
GROUP BY 
  location
ORDER BY 
  total_death_count DESC ;


 
-- GLOBAL NUMBERS (group by date)
SELECT
  date,
  SUM(new_cases) AS total_cases1,
  SUM(new_deaths) AS total_deaths1,
  SUM(new_deaths)/SUM(new_cases) * 100 AS death_percentage
FROM 
  covid_deaths
WHERE 
  continent <> ''
-- GROUP BY
--   date
ORDER BY
  1, 2 ;



-- TOTAL death percentage
SELECT
  SUM(new_cases) AS total_cases1,
  SUM(new_deaths) AS total_deaths1,
  SUM(new_deaths)/SUM(new_cases) * 100 AS death_percentage
FROM 
  covid_deaths
WHERE 
  continent <> ''
ORDER BY 
  1, 2 ;

 
 
-- TOTAL death group by continent
SELECT
  continent,
  SUM(new_cases) AS total_cases1,
  SUM(new_deaths) AS total_deaths1,
  SUM(new_deaths)/SUM(new_cases) * 100 AS death_percentage
FROM 
  covid_deaths
WHERE 
  continent <> ''
GROUP BY
  continent
ORDER BY 
  1, 2 ;
  

 
-- total population vs vaccinations
SELECT
  cd.continent,
  cd.location,
  cd.date,
  cd.population,
  cv.new_vaccinations
FROM 
  covid_deaths cd
JOIN 
  covid_vaccination cv ON cd.location = cv.location AND cd.date = cv.date
WHERE
  cd.continent <> ''
ORDER BY  
  2, 3 ;

 
 
-- Shows Percentage of Population that has received at least one Covid Vaccine
SELECT
  cd.continent,
  cd.location,
  cd.date,
  cd.population,
  cv.new_vaccinations,
  SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as rolling_people_vaccinated
FROM 
  covid_deaths cd
JOIN 
  covid_vaccination cv ON cd.location = cv.location AND cd.date = cv.date
WHERE
  cd.continent <> ''
ORDER BY  
  2, 3 ;
  
 

-- USE CTE (Common Table Expressions)
-- total vaccination percent rolling count
WITH pop_vs_vac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS
(
  SELECT
    cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as rolling_people_vaccinated
  FROM 
    covid_deaths cd
  JOIN 
    covid_vaccination cv ON cd.location = cv.location AND cd.date = cv.date
  WHERE
    cd.continent <> '' 
--   ORDER BY  
--     2, 3 ;
 )
  SELECT
   *,
   (rolling_people_vaccinated / population) * 100 AS vaccination_percent
 FROM
   pop_vs_vac
 WHERE location like '%afghanistan%';
  
  
 
-- CTE (Common Table Expressions)
-- vaccination percent group by continent 
WITH pop_vs_vac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS
(
  SELECT
    cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as rolling_people_vaccinated
  FROM 
    covid_deaths cd
  JOIN 
    covid_vaccination cv ON cd.location = cv.location AND cd.date = cv.date
  WHERE
    cd.continent <> ''
 -- group by
   -- date
)
SELECT 
  continent,
  sum(new_vaccinations) AS total_vaccinations
FROM pop_vs_vac
GROUP BY
 continent


-- Creating view to store data for later visualization (Queries used for Tableau Project)
-- VIEW 1-> total cases, total death and death percentage
CREATE VIEW death_percentage AS
SELECT 
  SUM(new_cases) AS total_cases,
  SUM(new_deaths ) AS total_deaths,
  SUM(new_deaths )/SUM(new_Cases)*100 AS death_percentage
FROM 
  covid_deaths cd
WHERE 
  continent <> '' ;
 
 
 -- VIEW 2-> total death count
CREATE VIEW total_death_count AS
SELECT 
  location, 
  SUM(new_deaths) AS total_death_count
FROM 
  covid_deaths cd
WHERE 
  continent <> '' AND location NOT IN ('world', 'european union', 'international')
GROUP BY 
  location
ORDER BY 
  total_death_count DESC
  

-- VIEW 3-> population infected
CREATE VIEW population_infected AS
SELECT 
  location, 
  population,
  MAX(total_cases) AS highest_infection_count,
  MAX((total_cases/population))*100 AS percent_population_infected
FROM
  covid_deaths cd
GROUP BY 
  location, population
ORDER BY 
  percent_population_infected DESC
  
  
-- VIEW 4-> population infected by date
CREATE VIEW infection_rate_date AS
SELECT
  location,
  population,
  date,
  MAX(total_cases) AS highest_infection_count,
  MAX((total_cases/population))*100 AS percent_population_infected
FROM 
  covid_deaths cd
GROUP BY 
  location, population, date
ORDER BY 
  percent_population_infected DESC

  
  
  
  
  
  
  