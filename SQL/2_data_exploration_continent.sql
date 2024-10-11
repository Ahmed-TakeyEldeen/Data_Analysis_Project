-- grouping death counts by the location

SELECT
    location,
    MAX(total_deaths) AS death_count
FROM 
    covid_deaths
WHERE
    continent is NULL
GROUP BY
    location
ORDER BY
    death_count DESC;


-- Grouping by the Date new_cases AND new_deaths

SELECT 
    date,
    SUM(new_cases) AS total_new_cases,
    SUM(new_deaths) AS total_new_deaths,
    ROUND((SUM(new_deaths)/ SUM(new_cases)) *100,4) AS percentage_of_death
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY
    date
ORDER BY 
    1,2;

-- THE SUM of all cases accros the world

SELECT 
    SUM(new_cases) AS total_new_cases,
    SUM(new_deaths) AS total_new_deaths,
    ROUND((SUM(new_deaths)/ SUM(new_cases)) *100,4) AS percentage_of_death
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 
    1,2;



-- Total Population vs Vaccinations WITH CTE

WITH temm AS(
SELECT 
    covid_deaths.continent AS continent,
    covid_deaths.location AS location,
    covid_deaths.date AS date,
    covid_deaths.population AS population,
    covid_vaccinations.new_vaccinations as vaccinated,
    SUM(covid_vaccinations.new_vaccinations)
    OVER(PARTITION BY covid_deaths.location ORDER BY covid_deaths.location ,covid_deaths.date) AS Rolling_People_Vaccinated
FROM 
    covid_vaccinations
JOIN 
    covid_deaths
ON 
    covid_vaccinations.date = covid_deaths.date
AND
    covid_vaccinations.location = covid_deaths.location
WHERE
    covid_vaccinations.continent IS NOT NULL
ORDER BY
    2,3
)
SELECT
    continent,
    location,
    date,
    population,
    Rolling_People_Vaccinated,
    (Rolling_People_Vaccinated/population)*100 AS percentage_of_Vaccinated
FROM temm;


-- Create View for Later Visual Purpose

Create VIEW PercentPopulationVaccinated as (
    WITH temm AS(

SELECT 
    covid_deaths.continent AS continent,
    covid_deaths.location AS location,
    covid_deaths.date AS date,
    covid_deaths.population AS population,
    covid_vaccinations.new_vaccinations as vaccinated,
    SUM(covid_vaccinations.new_vaccinations)
    OVER(PARTITION BY covid_deaths.location ORDER BY covid_deaths.location ,covid_deaths.date) AS Rolling_People_Vaccinated
FROM 
    covid_vaccinations
JOIN 
    covid_deaths
ON 
    covid_vaccinations.date = covid_deaths.date
AND
    covid_vaccinations.location = covid_deaths.location
WHERE
    covid_vaccinations.continent IS NOT NULL
ORDER BY
    2,3
)
SELECT
    continent,
    location,
    date,
    population,
    Rolling_People_Vaccinated,
    (Rolling_People_Vaccinated/population)*100 AS percentage_of_Vaccinated
FROM temm
)