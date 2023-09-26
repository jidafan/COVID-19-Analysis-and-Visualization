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
              |
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


## Tableau Dashboard
To view the tableau dashboard for this project, [click here](https://public.tableau.com/app/profile/scott.duong8287/viz/COVID19Dashboard_16955988107200/Dashboard1).
