SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    covid_deaths;


-- Total Cases VS Total Deaths in US OR any Country of your choice
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    ROUND((total_deaths / total_cases) * 100, 4) AS death_rate 
FROM
    covid_deaths
WHERE
    location = 'United States'
ORDER BY 1 ,2;


-- Looking for Total Cases vs the population for any country of your choice

SELECT 
    location,
    date,
    total_cases,
    population,
    ROUND((total_cases / population)*100 ,3 ) AS infection_rate
FROM
    covid_deaths
where 
    location = 'United Kingdom';

-- Looking For the maximum Poulation vs maximum infection

SELECT 
    location,
    population,
    MAX(total_cases) AS highest_infection_rate,
    MAX((total_cases / population)*100) AS infection_percent_population
FROM
    covid_deaths
GROUP BY
    location,
    population
ORDER BY
    percent_population DESC;




-- looking for the maximum Population vs maximum death rate

SELECT
    location,
    MAX(total_deaths) AS death_count
FROM 
    covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY
    location
HAVING
    MAX(total_cases) is NOT NULL
ORDER BY
    death_count ASC;
