-- Viewing Covid Death Data
Select *
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Order by Location, date

-- Viewing Covid Vaccination Data
Select *
From [Portfolio Project]..CovidVaccinations
Where continent is not NULL
Order by Location, date

-- Looking at Cases and Total Deaths in each country
	
Select location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths
Order by location, date

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in Canada
Select location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
Where location like '%canada%' and total_cases is not NULL
Order by location, date

-- Shows likelihood of dying if you  contract covid in every country
Select location, date, total_cases, total_deaths, Round((CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as DeathPercentage
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and total_cases is not NULL
Order by location, date

-- Shows likelihood of dying/being in the hospital/icu in every country
Select location, date, total_cases, total_deaths, Round((CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as DeathPercentage
, Round((CONVERT(float, hosp_patients) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as HospitalRate
, Round((CONVERT(float, icu_patients) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as ICURate
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and total_cases is not null
Order by location, date

-- Looking at first cases
-- First cases to be documented 
SELECT 
  location, 
  MIN(date) AS first_case,
  total_cases
FROM [Portfolio Project]..CovidDeaths
WHERE total_cases > 0 
  AND continent IS NOT NULL
GROUP BY location, total_cases
HAVING MIN(date) = (
  SELECT MIN(date)
  FROM [Portfolio Project]..CovidDeaths
  WHERE total_cases > 0
)
ORDER BY first_case
 
 -- First case in Canada
 SELECT 
  location, 
  MIN(date) AS first_case,
  total_cases
FROM [Portfolio Project]..CovidDeaths
WHERE total_cases > 0 and location = 'Canada'
  AND continent IS NOT NULL
GROUP BY location, total_cases
HAVING MIN(date) = (
  SELECT MIN(date)
  FROM [Portfolio Project]..CovidDeaths
  WHERE total_cases > 0 and location = 'Canada'
)
ORDER BY first_case
 

-- Looking at Total Cases vs Population
-- Shows what percentage of population who got covid
Select location, date, population, total_cases, Round((CONVERT(float, total_cases) / population)*100, 2) as InfectionPercentage
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Order by location, date

-- Show what percentage of population got covid in Canada
Select location, date, population, total_cases, Round((CONVERT(float, total_cases) / population)*100, 2) as InfectionPercentage
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and location = 'Canada'
Order by location, date

-- Looking at Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(cast(total_cases as bigint)) as HighestInfectionCount,  Max((cast(total_cases as bigint)/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Group by Location, Population
order by PercentPopulationInfected desc

--Looking at Highest Infection Rate in Canada
Select Location, Population, MAX(cast(total_cases as bigint)) as HighestInfectionCount,  Max((cast(total_cases as bigint)/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and location = 'Canada'
Group by Location, Population


--Showing Countries with Highest Death Count compared to Population
Select Location, population, MAX(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Group by Location, population
order by TotalDeathCount desc

-- Show continents with highest death count
Select location, MAX(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
-- Where location like '%canada%'
Where continent is NULL
Group by location
order by TotalDeathCount desc


-- GLOBAL NUMBERS
-- Looking at the global death rate and cases
Select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as float))/sum(NULLIF(CONVERT(float, new_cases), 0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
-- Where location like '%canada%'
where continent is not null
Group By date
Order by 1,2

-- Looking at total global death rate and cases
Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as float))/sum(NULLIF(CONVERT(float, new_cases), 0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
-- Where location like '%canada%'
where continent is not null
-- Group By date
Order by 1,2

--Looking at the relationship between total population and vaccination rates
-- Looking at global rolling vaccination 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
Order by dea.location, dea.date

-- Looking at Canada's rolling vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.location='Canada'
Order by dea.location, dea.date

-- Looking at relationship between total population, rolling vaccination and booster 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
, vac.total_boosters
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
Order by dea.location, dea.date


-- Use CTE

With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPopulationVaccinated)
as 
(Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
--, (RollingPopulationVaccinated/dea.population)*100
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null)
Select *, (RollingPopulationVaccinated/Population)*100 as PopulationVaccinated
From PopvsVac

-- Creating Temp Table

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPopulationVaccinated numeric
)

-- Inserting into Temp Table
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
--, (RollingPopulationVaccinated/dea.population)*100
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- Order by 1,2,3
Select *, (RollingPopulationVaccinated/Population)*100 
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
--, (RollingPopulationVaccinated/dea.population)*100
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- Order by 1,2,3
