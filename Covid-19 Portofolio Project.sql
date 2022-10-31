--COVID-19 Data Exploration

SELECT *
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
ORDER BY location, date

--Now, I will select a data that I am goint to use from CovidDeaths Table.
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
ORDER BY 1,2

--Looking for a countries with the highest total cases
SELECT location, MAX(cast(total_cases as float)) AS highest_total_cases
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY highest_total_cases desc

--Looking for the highest total cases in Indonesia for each year
SELECT location, YEAR(date) AS year, MAX(cast(total_cases as float)) AS highest_total_cases
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null and location like '%indonesia%'
GROUP BY location, YEAR(date)
ORDER BY YEAR(date)

--Looking for a countries with the highest total deaths
SELECT location, MAX(cast(total_deaths as float)) AS highest_total_deaths
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY highest_total_deaths desc

--Looking for the highest total deaths in Indonesia for each year
SELECT location, YEAR(date) AS year, MAX(cast(total_deaths as float)) AS highest_total_deaths
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null and location like '%indonesia%'
GROUP BY location, YEAR(date)
ORDER BY YEAR(date)

/*
Case Fatality Rate (CFR)
CFR is the proportion of people diagnosed with a Covid-19, who end up of dying of it.
In another word, CFR is showing likelihood of dying if you contract Covid-19 in Indonesia
*/
SELECT location, MAX(cast(total_deaths as float)) AS highest_total_deaths, MAX(cast(total_cases as float)) AS highest_total_cases,
		(MAX(cast(total_deaths as float))/MAX(cast(total_cases as float)))*100 AS case_fatality_rate
FROM CovidPortofolioProject..CovidDeaths
WHERE continent is not null and location like '%indonesia%'
GROUP BY location
ORDER BY location

--Now I will see the countries with the highest CFR
SELECT location, MAX(cast(total_deaths as float)) AS highest_total_deaths, MAX(cast(total_cases as float)) AS highest_total_cases,
		(MAX(cast(total_deaths as float))/MAX(cast(total_cases as float)))*100 AS case_fatality_rate
FROM CovidPortofolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY case_fatality_rate desc

/*
Attack Rate (AR)
AR is the proportion of an at-risk population that contracts the disease during a specified time interval in Indonesia
in another word it shows what percentage of population infected with Covid-19 in Indonesia
*/
SELECT location, MAX(cast(total_cases as float)) AS highest_total_cases, population, (MAX(cast(total_cases as float))/population)*100 AS attack_rate 
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null and location like '%indonesia%'
GROUP BY location, population
ORDER BY location

--Now I will see the countries with the highest AR
SELECT location, MAX(cast(total_cases as float)) AS highest_total_cases, population, (MAX(cast(total_cases as float))/population)*100 AS attack_rate 
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY attack_rate desc

--After looking at countries, now I will breaking things down by continent.
--Looking for a continent with the highest total cases
SELECT continent, MAX(cast(total_cases as float)) AS highest_total_cases
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY highest_total_cases desc

--Looking for a continent with the highest total deaths
SELECT continent, MAX(cast(total_deaths as float)) AS highest_total_deaths
FROM CovidPortofolioProject.dbo.CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY highest_total_deaths desc

--GLOBAL CFR
SELECT SUM(cast(new_cases as float)) AS total_cases, SUM(cast(new_deaths as float)) AS total_deaths,
		SUM(cast(new_deaths as float))/SUM(cast(new_cases as float))*100 AS global_cfr
FROM CovidPortofolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2

--Looking for percentage of population that has received at least one Covid-19 Vaccine
SELECT *
FROM CovidPortofolioProject.dbo.CovidVaccinations
WHERE continent is not null
ORDER BY location, date

SELECT Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as float)) OVER (PARTITION BY Dea.Location ORDER BY Dea.location, Dea.Date) AS amount_people_vaccinated
FROM CovidPortofolioProject..CovidDeaths AS Dea
JOIN CovidPortofolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
WHERE Dea.continent is not null AND Dea.location like '%indonesia%'
ORDER BY 1,2

--Now, I will using CTE to perform calculation on Partition By in previous query
WITH PopVac (Location, Date, Population, New_Vaccinations, Amount_People_Vaccinated)
as
(
SELECT Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as float)) OVER (PARTITION BY Dea.Location ORDER BY Dea.location, Dea.Date) AS amount_people_vaccinated
FROM CovidPortofolioProject..CovidDeaths AS Dea
JOIN CovidPortofolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
WHERE Dea.continent is not null AND Dea.location like '%indonesia%'
--ORDER BY 1,2
)
Select *, (Amount_People_Vaccinated/Population)*100 AS percent_population_vaccinated
FROM PopVac

--Now, I will using Temp Table to perform calculation on Partition By in previous query
DROP TABLE IF EXISTS #AmountPeopleVaccinated
CREATE TABLE #AmountPeopleVaccinated
(
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
Amount_People_Vaccinated numeric,
)

INSERT INTO #AmountPeopleVaccinated
SELECT Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as float)) OVER (PARTITION BY Dea.Location ORDER BY Dea.location, Dea.Date) AS amount_people_vaccinated
FROM CovidPortofolioProject..CovidDeaths AS Dea
JOIN CovidPortofolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
WHERE Dea.continent is not null AND Dea.location like '%indonesia%'
ORDER BY 1,2

SELECT *, (Amount_People_Vaccinated/Population)*100 AS percent_population_vaccinated
FROM #AmountPeopleVaccinated

-- Creating View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated as
SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as float)) OVER (PARTITION BY Dea.Location ORDER BY Dea.location, Dea.Date) AS amount_people_vaccinated
FROM CovidPortofolioProject..CovidDeaths AS Dea
JOIN CovidPortofolioProject..CovidVaccinations As Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
WHERE Dea.continent is not null