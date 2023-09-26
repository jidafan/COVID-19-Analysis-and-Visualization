# Covid19 Dashboard

## Table of Contents
* [Introduction](#introduction)
* [Data Review](#data-review)
* [SQL Exploration](#sql-exploration)
* [Tableau Dashboard](#tab;eau=dashboard)

## Introduction

Covid-19 is a recent pandemic that has left a mark on our history as a species. It has greatly affected individuals, families, and communities worldwide. Countless lives were lost to this disease and many people are still affected by this debilitating virus.

This project aims to analyze data from the pandemic on a global and local scale. The project will use SQL to analyze the data by using queries and the findings will be visualized using tableau.

## Data Review

The data used in the project was sourced from [Our World in Data](https://ourworldindata.org/covid-deaths), which includes information from all around the globe on COVID-19. The data was split into two sets to better analyze the information.

The first file, [CovidDeaths.xlsb](https://github.com/jidafan/Covid19-Dashboard/blob/main/CovidDeaths.xlsb), provides information on COVID-19 cases and deaths worldwide from January 3, 2020 to September 21, 2023.

| Variable      | Description           | 
| ------------- |:---------------------| 
| `iso_code`     | 	ISO 3166-1 alpha-3 – three-letter country codes.    |
| `continent`     | Continent where the country is located         |   
| `location` | Name of the country                                      |
| `date`  | Date when the observation was recorded                                 |
| `population`  | Population of the country                       |
| `total_cases`  |  Total confirmed cases of COVID-19.                                   |
| `new_cases`  | New confirmed cases of COVID-19.                                   |
| `new_cases_smoothed`  | Smoothed newly confirmed cases of COVID-19.                |
| `total_deaths`  | Total confirmed deaths attributed to COVID-19.                                      |
| `new_deaths`  | New confirmed deaths attributed to COVID-19                                    |
| `new_deaths_smoothed`  | Smoothed newly confirmed deaths attributed to COVID-19                                   |
| `total_cases_per_million`  | Total confirmed cases of COVID-19 per million                                    |
| `new_cases_per_million`  | New confirmed cases of COVID-19 per million                    |
| `new_cases_smoothed_per_million`     | Smoothed newly confirmed cases of COVID-19 per million          |   
| `total_deaths_per_million` | Total confirmed deaths attributed to COVID-19 per million                                         |
| `new_deaths_smoothed_per_million`  | Smoothed newly confirmed deaths attributed to COVID-19 per million                                |
| `reproduction_rate`  | Number of children per couple on average                   |
| `icu_patients`  |  Number of patients placed in ICU due to COVID-19                             |
| `icu_patients_per_million`  | Number of patients placed in ICU due to COVID-19 per million                              |
| `hosp_patients`  | Number of hospital patients due to COVID-19           |
| `hosp_patients_per_million`  | Number of hospital patients due to COVID-19 per million                                      |

The file contains 5795730 observations and 22 variables

The second file, [CovidVaccinations.xlsb](https://github.com/jidafan/Covid19-Dashboard/blob/main/CovidVaccinations.xlsb), provides information on COVID-19 tests and vaccinations worldwide from January 3, 2020 to September 21, 2023.

| Variable      | Description           | 
| ------------- |:---------------------| 
| `iso_code`     | 	ISO 3166-1 alpha-3 – three-letter country codes.    |
| `continent`     | Continent where the country is located         |   
| `location` | Name of the country                                      |
| `date`  | Date when the observation was recorded                                 |
| `total_tests`  | Total confirmed tests of COVID-19                    |
| `new_tests`  |  New confirmed tests of COVID-19                                 |
| `total_tests_per_thousand`  | Total confirmed tests of COVID-19 per thousand                                   |
| `new_tests_per_thousand`  | New confirmed tests of COVID-19 per thousand              |
| `new_tests_smoothed`  | Smoothed newly confirmed tests of COVID-19                                  |
| `new_tests_smoothed_per_thousand`  | Smoothed newly confirmed tests of COVID-19 per thousand                                 |
| `positive_rate`  | Confirmed positive rate of COVID-19 tests                                  |
| `tests_per_case`  | Number of COVID-19 tests per COVID-19 cases                                   |
| `tests_units`  | Number of test units available                 |
| `total_vaccinations`     | Total number of COVID-19 vaccination doses administered   |   
| `people_vaccinated` | 	Total number of people who received at least one vaccine dose                                     |
| `people_fully_vaccinated`  | Total number of people who received at least two vaccine doses                              |
| `total_boosters`  | Total number of COVID-19 vaccination booster doses administered            |
| `new_vaccinations`  |  New COVID-19 vaccination doses administered                            |
| `new_vaccinations_smoothed`  | Smoothed new COVID-19 vaccination doses administered                               |
| `total_vaccinations_per_hundred`  | Total number of COVID-19 vaccination doses administered per hundred           |
| `people_vaccinated_per_hundred`  | Total number of people who received at least one vaccine dose per hundred                                     |
| `people_fully_vaccinated_per_hundred`  |  Total number of people who received at least two vaccine doses per hundred                          |
| `total_boosters_per_hundred`  | Total number of COVID-19 vaccination booster doses administered per hundred                         |
| `new_vaccinations_smoothed_per_million`  | Smoothed new COVID-19 vaccination doses administered per million           |
| `new_people_vaccinated_smoothed`  | Smoothed new number of people who have received at least one vaccine dose                                   |
| `new_people_vaccinated_smoothed_per_hundred` | Smoothed new number of people who have received at least one vaccine dose per hundred |

The file contains 3427977 observations and 26 variables

## SQL Exploration
To view the full SQL code for this project, [click here](https://github.com/jidafan/Covid19-Dashboard/blob/main/Covid%20SQL%20Query.sql).

**Viewing COVID-19 Deaths**
```sql
Select *
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Order by Location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/2efe4052-f976-4c3f-be76-3d8725fc1985)

**Viewing COVID-19 Vaccinations**
```sql
Select *
From [Portfolio Project]..CovidVaccinations
Order by Location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/1cad9a37-f76e-4523-8246-ab773e1eab83)


**Looking at cases and deaths in each country**
```sql
Select location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths
Order by location,date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/effdda73-a616-4737-abca-22947dad7710)

**Shows likelihood of dying if you contract covid in Canada**
```sql
Select location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
Where location like '%canada%' and total_cases is not NULL
Order by location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/ca6aa5bc-f17f-45f6-9cd9-e885c2c04420)

**Shows likelihood of dying if you  contract covid in any country**
```sql
Select location, date, total_cases, total_deaths, Round((CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as DeathPercentage
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and total_cases is not NULL
Order by location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/f44fadc5-644e-4f66-a96f-572e612f5ef4)

**Shows likelihood of dying/being in the hospital/icu in every country**
```sql
Select location, date, total_cases, total_deaths, Round((CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as DeathPercentage
, Round((CONVERT(float, hosp_patients) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as HospitalRate
, Round((CONVERT(float, icu_patients) / NULLIF(CONVERT(float, total_cases), 0))*100, 2) as ICURate
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and total_cases is not null
Order by location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/411cb040-feee-49c4-b71d-c336d7abb437)

**Looking at first cases worldwide**
```sql
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
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/9378dd01-df6e-40f1-b1d2-1dd110dfc106)

**Looking at first case in Canada**
```sql
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
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/fabbc094-0d04-471b-9f24-75b1b0ac8ace)

**Looking at the percentage of population who contracted COVID-19**
```sql
Select location, date, population, total_cases, Round((CONVERT(float, total_cases) / population)*100, 2) as InfectionPercentage
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Order by location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/b1b59b59-0c59-4fda-85bf-5a009bf33898)

**Looking at percentage of population who contracted COVID-19 in Canada**
```sql
Select location, date, population, total_cases, Round((CONVERT(float, total_cases) / population)*100, 2) as InfectionPercentage
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and location = 'Canada'
Order by location, date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/83fd5cb2-55fa-422c-92a5-e6e0bfb96f47)

**Looking at Countries with Highest Infection Rate compared to Population**
```sql
Select Location, Population, MAX(cast(total_cases as bigint)) as HighestInfectionCount,  Max((cast(total_cases as bigint)/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Group by Location, Population
order by PercentPopulationInfected desc
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/4cc07dbf-7c3e-474d-9418-2a17bfe195c0)

**Looking at Highest Infection Rate in Canada**
```sql
Select Location, Population, MAX(cast(total_cases as bigint)) as HighestInfectionCount,  Max((cast(total_cases as bigint)/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
Where continent is not NULL and location = 'Canada'
Group by Location, Population
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/3ef5214a-1570-4661-bab5-9f23a86cecfc)

**Looking at Countries with Highest Death Count compared to Population**
```sql
Select Location, MAX(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
Where continent is not NULL
Group by Location
order by TotalDeathCount desc
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/8c4bdff7-5a2a-4d3d-9f1e-4a6ba168dda0)

**Looking at Continents with Highest Death Count**
```sql
Select location, MAX(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
-- Where location like '%canada%'
Where continent is NULL 
AND location NOT LIKE '%union%'
AND location NOT LIKE '%world%'
Group by location
order by TotalDeathCount desc
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/e78839be-cc96-4866-8440-eb432315a14a)

**Looking at the global death rate and cases**
```sql
Select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as float))/sum(NULLIF(CONVERT(float, new_cases), 0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
where continent is not null
Group By date
Order by date, total_cases
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/78f76c9b-8ed5-4035-ac09-33488bf41fb6)

**Looking at total global death rate and cases**
```sql
Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as float))/sum(NULLIF(CONVERT(float, new_cases), 0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
-- Where location like '%canada%'
where continent is not null
-- Group By date
Order by total_cases, total_deaths
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/ce0b3c46-b0f0-4702-8de8-a3209ba7e3fd)

**Looking at global rolling vaccination**
```sql
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
Order by dea.location, dea.date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/e8f47d45-ce64-4dd0-924a-78ca870f37ae)

**Looking at Canada's Rolling vaccinations**
```sql
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.location='Canada'
Order by dea.location, dea.date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/c9d474cb-3d02-45e4-bcc8-4b4d5c079b00)

**Looking at relationship between total population, rolling vaccination and booster**
```sql
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
, vac.total_boosters
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
Order by dea.location, dea.date
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/a47bf803-defe-43bf-9e39-24cc7dfffa5c)

**Looking at rolling vaccinations and the percentage of vaccinated population using CTE**
```sql
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
```
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/3a9f2889-23d1-4eac-9ac5-73e413e1a10e)

**Looking at rolling vaccinations and the percentage of vaccinated population use TEMP Tables**
```sql
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
Select *, (RollingPopulationVaccinated/Population)*100 
From #PercentPopulationVaccinated
```

**Creating a view**
```sql
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPopulationVaccinated
--, (RollingPopulationVaccinated/dea.population)*100
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
```
## Tableau Dashboard
To view the tableau dashboard for this project, [click here](https://public.tableau.com/app/profile/scott.duong8287/viz/COVID19Dashboard_16955988107200/Dashboard1).
![image](https://github.com/jidafan/Covid19-Dashboard/assets/141703009/075d62dc-e75f-4849-a628-3ad7e4191fd0)
