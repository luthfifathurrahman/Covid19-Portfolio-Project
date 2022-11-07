------------------------------------------------------------------------------------------------------
------------------------------------------- DATA PROFILING -------------------------------------------
------------------------------------------------------------------------------------------------------
-- CovidDeaths Table
-- Looking All The Data from The CovidDeaths Table
SELECT *
FROM CovidPortfolioProject..CovidDeaths

-- Counting How Many Rows in The CovidDeaths Table
SELECT COUNT(*) AS Row_Count
FROM CovidPortfolioProject..CovidDeaths

-- Showing The Data Type For Every Column
SELECT COLUMN_NAME, DATA_TYPE
FROM CovidPortfolioProject.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidDeaths'

------------------------------------------------------------------------------------------------------
-- CovidVaccinations Table
-- Looking All The Data from The CovidVaccinations Table
SELECT *
FROM CovidPortfolioProject..CovidVaccinations

-- Counting How Many Rows in The CovidVaccinations Table
SELECT COUNT(*) AS Row_Count
FROM CovidPortfolioProject..CovidVaccinations

-- Showing The Data Type For Every Column
SELECT COLUMN_NAME, DATA_TYPE
FROM CovidPortfolioProject.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidVaccinations'

------------------------------------------------------------------------------------------------------
------------------------------------------- DATA CLEANSING -------------------------------------------
------------------------------------------------------------------------------------------------------
-- CovidDeaths Table
-- iso_code Column
~~~~~~~~~~~~~~~~~~~~
-- Checking The iso_code Column
SELECT iso_code
FROM CovidPortfolioProject..CovidDeaths

-- Removing The iso_code Column
ALTER TABLE CovidPortfolioProject..CovidDeaths
DROP COLUMN iso_code

------------------------------------------------------------------------------------------------------
-- continent Column
~~~~~~~~~~~~~~~~~~~~
-- Checking The Amount of Unique Value in continent Column
SELECT DISTINCT continent
FROM CovidPortfolioProject..CovidDeaths

-- Checking Missing Value on continent Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE continent is null

SELECT DISTINCT location
FROM CovidPortfolioProject..CovidDeaths
WHERE continent is null

/*
Removing Row That Has A Null Value in continent Column and North America, Asia, World, 
Africa, Oceania, European Union, South America, International, Europe.
*/
DELETE FROM CovidPortfolioProject..CovidDeaths
WHERE continent is null
and location like '%north america%' 
or location like '%asia%'
or location like '%world%'
or location like '%africa%'
or location like '%oceania%'
or location like '%european union%'
or location like '%south america%'
or location like '%international%'
or location like '%europe%'

-- Replacing Null Values in continent Column into Undefined
SELECT continent,
CASE WHEN continent is null THEN 'Undefined'
	 ELSE continent
	 END
FROM CovidPortfolioProject..CovidDeaths
ORDER BY continent

UPDATE CovidPortfolioProject..CovidDeaths
SET continent = CASE WHEN continent is null THEN 'Undefined'
	 ELSE continent
	 END

------------------------------------------------------------------------------------------------------
-- location Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on location Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE location is null

-- Checking The Amount of Unique Value in location Column
SELECT DISTINCT location
FROM CovidPortfolioProject..CovidDeaths

------------------------------------------------------------------------------------------------------
-- date Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on date Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE date is null

-- Changing The Format Date on date Column
SELECT date, CONVERT(date, date)
FROM CovidPortfolioProject..CovidDeaths

ALTER TABLE CovidPortfolioProject..CovidDeaths
ADD date_converted Date

UPDATE CovidPortfolioProject..CovidDeaths
SET date_converted = CONVERT(date, date)

-- Removing date column From The CovidDeaths Column
ALTER TABLE CovidPortfolioProject..CovidDeaths
DROP COLUMN date

------------------------------------------------------------------------------------------------------
-- population Column
~~~~~~~~~~~~~~~~~~~~
SELECT *
FROM CovidPortfolioProject..CovidDeaths
ORDER BY location, date_converted

-- Checking Missing Value on population Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE population is null

SELECT DISTINCT location
FROM CovidPortfolioProject..CovidDeaths
WHERE population is null

-- Handling Missing Value on population Column
SELECT population, ISNULL(population, 1252013)
FROM CovidPortfolioProject..CovidDeaths
WHERE population is null

UPDATE CovidPortfolioProject..CovidDeaths
SET population = ISNULL(population, 1252013)

------------------------------------------------------------------------------------------------------
-- total_cases Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on total_cases Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE total_cases is null

-- Handling Missing Value on total_cases Column
SELECT total_cases, ISNULL(total_cases, 0)
FROM CovidPortfolioProject..CovidDeaths
WHERE total_cases is null

UPDATE CovidPortfolioProject..CovidDeaths
SET total_cases = ISNULL(total_cases, 0)

------------------------------------------------------------------------------------------------------
-- new_cases Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on new_cases Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE new_cases is null

-- Handling Missing Value on new_cases Column
SELECT new_cases, ISNULL(new_cases, 0)
FROM CovidPortfolioProject..CovidDeaths
WHERE new_cases is null

UPDATE CovidPortfolioProject..CovidDeaths
SET new_cases = ISNULL(new_cases, 0)

------------------------------------------------------------------------------------------------------
-- total_deaths Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on total_deaths Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE total_deaths is null

-- Handling Missing Value on total_deaths Column
SELECT total_deaths, ISNULL(total_deaths, 0)
FROM CovidPortfolioProject..CovidDeaths
WHERE total_deaths is null

UPDATE CovidPortfolioProject..CovidDeaths
SET total_deaths = ISNULL(new_cases, 0)

------------------------------------------------------------------------------------------------------
-- new_deaths Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on new_deaths Column
SELECT *
FROM CovidPortfolioProject..CovidDeaths
WHERE new_deaths is null

-- Handling Missing Value on new_deaths Column
SELECT new_deaths, ISNULL(new_deaths, 0)
FROM CovidPortfolioProject..CovidDeaths
WHERE new_deaths is null

UPDATE CovidPortfolioProject..CovidDeaths
SET new_deaths = ISNULL(new_deaths, 0)

------------------------------------------------------------------------------------------------------
-- Removing Unused Column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE CovidPortfolioProject..CovidDeaths
DROP COLUMN new_cases_smoothed, new_deaths_smoothed, total_cases_per_million,
new_cases_per_million, new_cases_smoothed_per_million, total_deaths_per_million,
new_deaths_per_million, new_deaths_smoothed_per_million, reproduction_rate, icu_patients,
icu_patients_per_million, hosp_patients, hosp_patients_per_million, weekly_icu_admissions,
weekly_icu_admissions_per_million, weekly_hosp_admissions, weekly_hosp_admissions_per_million

SELECT  continent, location, date_converted, population, new_cases, total_cases, new_deaths, total_deaths
FROM CovidPortfolioProject..CovidDeaths
ORDER BY location, date_converted

------------------------------------------------------------------------------------------------------
-- Changing The Data Type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE CovidPortfolioProject..CovidDeaths
ALTER COLUMN population numeric

ALTER TABLE CovidPortfolioProject..CovidDeaths
ALTER COLUMN total_cases numeric

ALTER TABLE CovidPortfolioProject..CovidDeaths
ALTER COLUMN new_cases numeric

ALTER TABLE CovidPortfolioProject..CovidDeaths
ALTER COLUMN total_deaths numeric

ALTER TABLE CovidPortfolioProject..CovidDeaths
ALTER COLUMN new_deaths numeric

------------------------------------------------------------------------------------------------------
-- CovidVaccinations Table
-- iso_code Column
~~~~~~~~~~~~~~~~~~~~
-- Checking The iso_code Column
SELECT iso_code
FROM CovidPortfolioProject..CovidVaccinations

-- Removing The iso_code Column
ALTER TABLE CovidPortfolioProject..CovidVaccinations
DROP COLUMN iso_code

------------------------------------------------------------------------------------------------------
-- continent Column
~~~~~~~~~~~~~~~~~~~~
-- Checking The Amount of Unique Value in continent Column
SELECT DISTINCT continent
FROM CovidPortfolioProject..CovidVaccinations

-- Checking Missing Value on continent Column
SELECT *
FROM CovidPortfolioProject..CovidVaccinations
WHERE continent is null

SELECT DISTINCT location
FROM CovidPortfolioProject..CovidVaccinations
WHERE continent is null

/*
Removing Row That Has A Null Value in continent Column and North America, Asia, World, 
Africa, Oceania, European Union, South America, International, Europe.
*/
DELETE FROM CovidPortfolioProject..CovidVaccinations
WHERE continent is null
and location like '%north america%' 
or location like '%asia%'
or location like '%world%'
or location like '%africa%'
or location like '%oceania%'
or location like '%european union%'
or location like '%south america%'
or location like '%international%'
or location like '%europe%'

-- Replacing Null Values in continent Column into Undefined
SELECT continent,
CASE WHEN continent is null THEN 'Undefined'
	 ELSE continent
	 END
FROM CovidPortfolioProject..CovidVaccinations
ORDER BY continent

UPDATE CovidPortfolioProject..CovidVaccinations
SET continent = CASE WHEN continent is null THEN 'Undefined'
	 ELSE continent
	 END

------------------------------------------------------------------------------------------------------
-- location Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on location Column
SELECT *
FROM CovidPortfolioProject..CovidVaccinations
WHERE location is null

-- Checking The Amount of Unique Value in location Column
SELECT DISTINCT location
FROM CovidPortfolioProject..CovidVaccinations

------------------------------------------------------------------------------------------------------
-- date Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on date Column
SELECT *
FROM CovidPortfolioProject..CovidVaccinations
WHERE date is null

-- Changing The Format Date on date Column
SELECT date, CONVERT(date, date)
FROM CovidPortfolioProject..CovidVaccinations

ALTER TABLE CovidPortfolioProject..CovidVaccinations
ADD date_converted Date

UPDATE CovidPortfolioProject..CovidVaccinations
SET date_converted = CONVERT(date, date)

-- Removing date column From The CovidDeaths Column
ALTER TABLE CovidPortfolioProject..CovidVaccinations
DROP COLUMN date

------------------------------------------------------------------------------------------------------
-- people_fully_vaccinated Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on people_fully_vaccinated Column
SELECT *
FROM CovidPortfolioProject..CovidVaccinations
WHERE people_fully_vaccinated is null

-- Handling Missing Value on people_fully_vaccinated Column
SELECT people_fully_vaccinated, ISNULL(people_fully_vaccinated, 0)
FROM CovidPortfolioProject..CovidVaccinations
WHERE people_fully_vaccinated is null

UPDATE CovidPortfolioProject..CovidVaccinations
SET people_fully_vaccinated = ISNULL(people_fully_vaccinated, 0)

------------------------------------------------------------------------------------------------------
-- total_boosters Column
~~~~~~~~~~~~~~~~~~~~
-- Checking Missing Value on total_boosters Column
SELECT *
FROM CovidPortfolioProject..CovidVaccinations
WHERE total_boosters is null

-- Handling Missing Value on total_boosters Column
SELECT total_boosters, ISNULL(total_boosters, 0)
FROM CovidPortfolioProject..CovidVaccinations
WHERE total_boosters is null

UPDATE CovidPortfolioProject..CovidVaccinations
SET total_boosters = ISNULL(total_boosters, 0)

------------------------------------------------------------------------------------------------------
-- Removing Unused Column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE CovidPortfolioProject..CovidVaccinations
DROP COLUMN total_tests,new_tests,total_tests_per_thousand,new_tests_per_thousand,new_tests_smoothed,new_tests_smoothed_per_thousand,
positive_rate,tests_per_case,tests_units,total_vaccinations,people_vaccinated,new_vaccinations,new_vaccinations_smoothed,
total_vaccinations_per_hundred,people_vaccinated_per_hundred,people_fully_vaccinated_per_hundred,total_boosters_per_hundred,
new_vaccinations_smoothed_per_million,new_people_vaccinated_smoothed,new_people_vaccinated_smoothed_per_hundred,
stringency_index,population_density,median_age,aged_65_older,aged_70_older,gdp_per_capita,extreme_poverty,cardiovasc_death_rate,
diabetes_prevalence,female_smokers,male_smokers,handwashing_facilities,hospital_beds_per_thousand,life_expectancy,human_development_index,
excess_mortality_cumulative_absolute,excess_mortality_cumulative,excess_mortality,excess_mortality_cumulative_per_million

------------------------------------------------------------------------------------------------------
-- Changing The Data Type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE CovidPortfolioProject..CovidVaccinations
ALTER COLUMN people_fully_vaccinated numeric

ALTER TABLE CovidPortfolioProject..CovidVaccinations
ALTER COLUMN total_boosters numeric

------------------------------------------------------------------------------------------------------
------------------------------------------ DATA EXPLORATION ------------------------------------------
------------------------------------------------------------------------------------------------------
-- CovidDeaths Table
SELECT  continent, location, date_converted, population, new_cases, total_cases, new_deaths, total_deaths
FROM CovidPortfolioProject..CovidDeaths
ORDER BY location, date_converted

-- CovidVaccinations Table
SELECT  continent, location, date_converted, people_fully_vaccinated, total_boosters
FROM CovidPortfolioProject..CovidVaccinations
ORDER BY location, date_converted

-- Looking For The Highest Total Cases in ASEAN Country
SELECT location, MAX(total_cases) AS highest_total_cases
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%' 
and location like '%brunei%'
or location like '%cambodia%'
or location like '%indonesia%'
or location like '%laos%'
or location like '%malaysia%'
or location like '%myanmar%'
or location like '%philippines%'
or location like '%singapore%'
or location like '%thailand%'
or location like '%vietnam%'
GROUP BY location
ORDER BY highest_total_cases desc

-- Looking For The Highest Total Deaths in ASEAN Country
SELECT location, MAX(total_deaths) AS highest_total_deaths
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%' 
and location like '%brunei%'
or location like '%cambodia%'
or location like '%indonesia%'
or location like '%laos%'
or location like '%malaysia%'
or location like '%myanmar%'
or location like '%philippines%'
or location like '%singapore%'
or location like '%thailand%'
or location like '%vietnam%'
GROUP BY location
ORDER BY highest_total_deaths desc

/*
Case Fatality Rate (CFR)
CFR is the proportion of people diagnosed with a Covid-19, who end up of dying of it.
In another word, CFR is showing likelihood of dying if you contract Covid-19 in particular area.
*/
-- Looking For The Highest CFR in ASEAN Country
SELECT location, MAX(total_deaths) AS highest_total_deaths, MAX(total_cases) AS highest_total_cases,
		(MAX(total_deaths)/MAX(total_cases))*100 AS case_fatality_rate
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%' 
and location like '%brunei%'
or location like '%cambodia%'
or location like '%indonesia%'
or location like '%laos%'
or location like '%malaysia%'
or location like '%myanmar%'
or location like '%philippines%'
or location like '%singapore%'
or location like '%thailand%'
or location like '%vietnam%'
GROUP BY location
ORDER BY case_fatality_rate DESC

/*
Attack Rate (AR)
AR is the proportion of an at-risk population that contracts the disease during a specified time interval in Indonesia
in another word it shows what percentage of population infected with Covid-19 in Indonesia
*/
-- Looking For The Highest AR in ASEAN Country
SELECT location, MAX(total_cases) AS highest_total_cases, population, (MAX(total_cases)/population)*100 AS attack_rate 
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%' 
and location like '%brunei%'
or location like '%cambodia%'
or location like '%indonesia%'
or location like '%laos%'
or location like '%malaysia%'
or location like '%myanmar%'
or location like '%philippines%'
or location like '%singapore%'
or location like '%thailand%'
or location like '%vietnam%'
GROUP BY location, population
ORDER BY attack_rate DESC

-- AFTER LOOKING AT COUNTRY, NOW I WILL BREAKING THINGS DOWN BY A CONTINENT.
-- Looking For a Continent with The Highest Total Cases
SELECT continent, MAX(total_cases) AS highest_total_cases
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%'
GROUP BY continent
ORDER BY highest_total_cases desc

-- Looking For a Continent with The Highest Total Deaths
SELECT continent, MAX(total_deaths) AS highest_total_deaths
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%'
GROUP BY continent
ORDER BY highest_total_deaths desc

-- AFTER LOOKING AT CONTINENT, NOW I WILL BREAKING THINGS DOWN BY THE LEVEL OF INCOME.
-- Looking For The Highest Total Cases
SELECT location, MAX(total_cases) AS highest_total_cases
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent like '%undefined%'
GROUP BY location
ORDER BY highest_total_cases desc

-- Looking For The Highest Total Deaths
SELECT location, MAX(total_deaths) AS highest_total_deaths
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent like '%undefined%'
GROUP BY location
ORDER BY highest_total_deaths desc

-- GLOBAL CFR
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths,
		SUM(new_deaths)/SUM(new_cases)*100 AS global_cfr
FROM CovidPortfolioProject.dbo.CovidDeaths
WHERE continent not like '%undefined%'
ORDER BY 1,2

-- Looking For Percentage of Population That Has Fully Received Covid-19 Vaccine in ASEAN Country
SELECT Dea.location, Dea.population, MAX(Vac.people_fully_vaccinated) AS total_people_fully_vaccinated
FROM CovidPortfolioProject..CovidDeaths AS Dea
JOIN CovidPortfolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
WHERE Dea.continent not like '%undefined%' 
and Dea.location like '%brunei%'
or Dea.location like '%cambodia%'
or Dea.location like '%indonesia%'
or Dea.location like '%laos%'
or Dea.location like '%malaysia%'
or Dea.location like '%myanmar%'
or Dea.location like '%philippines%'
or Dea.location like '%singapore%'
or Dea.location like '%thailand%'
or Dea.location like '%vietnam%'
GROUP BY Dea.location, Dea.population
ORDER BY 1

-- Now, I Will Using CTE to Perform Calculation on Percent Poppulation Vaccinated in ASEAN Country
WITH PopVac (Location, Population, Total_People_Fully_Vaccinated)
as
(
SELECT Dea.location, Dea.population, MAX(Vac.people_fully_vaccinated) AS total_people_fully_vaccinated
FROM CovidPortfolioProject..CovidDeaths AS Dea
JOIN CovidPortfolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
WHERE Dea.continent not like '%undefined%'
GROUP BY Dea.location, Dea.population
)
Select *, (Total_People_Fully_Vaccinated/Population)*100 AS percent_population_vaccinated
FROM PopVac
WHERE location like '%brunei%'
or location like '%cambodia%'
or location like '%indonesia%'
or location like '%laos%'
or location like '%malaysia%'
or location like '%myanmar%'
or location like '%philippines%'
or location like '%singapore%'
or location like '%thailand%'
or location like '%vietnam%'
ORDER BY percent_population_vaccinated DESC

-- Now, I Will Using Temp Table to Perform Calculation on Percent Poppulation Vaccinated in ASEAN Country
DROP TABLE IF EXISTS #PercentPeopleVaccinated
CREATE TABLE #PercentPeopleVaccinated
(
Location nvarchar(255),
Population numeric,
Total_People_Fully_Vaccinated numeric
)

INSERT INTO #PercentPeopleVaccinated
SELECT Dea.location, Dea.population, MAX(CAST(Vac.people_fully_vaccinated AS float)) AS total_people_fully_vaccinated
FROM CovidPortfolioProject..CovidDeaths AS Dea
JOIN CovidPortfolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
WHERE Dea.continent not like '%undefined%'
GROUP BY Dea.location, Dea.population

Select *, (Total_People_Fully_Vaccinated/Population)*100 AS percent_population_vaccinated
FROM #PercentPeopleVaccinated
WHERE location like '%brunei%'
or location like '%cambodia%'
or location like '%indonesia%'
or location like '%laos%'
or location like '%malaysia%'
or location like '%myanmar%'
or location like '%philippines%'
or location like '%singapore%'
or location like '%thailand%'
or location like '%vietnam%'
ORDER BY percent_population_vaccinated DESC
