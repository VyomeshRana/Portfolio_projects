## Importing data from csv file
# creating table 1 

CREATE table covid_vac (
iso_code varchar(50),
continent varchar(50),
location varchar(50),
date date,
population int,
total_cases int,
new_cases int,
new_cases_smoothed dec(12,3),
total_deaths int,
new_deaths int,
new_deaths_smoothed dec(12,3),
total_cases_per_million dec(12,3),
new_cases_per_million dec(12,3),
new_cases_smoothed_per_million dec(12,3),
total_deaths_per_million dec(12,3),
new_deaths_per_million dec(12,3),
new_deaths_smoothed_per_million dec(12,3),
reproduction_rate dec(12,3),
icu_patients int,
icu_patients_per_million dec(12,3),
hosp_patients int,
hosp_patients_per_million dec(12,3),
weekly_icu_admissions int,
weekly_icu_admissions_per_million dec(12,3),
weekly_hosp_admissions int,
weekly_hosp_admissions_per_million dec(12,3)
);

# importing data (just change the path and table name for different data )

load data local infile 'C:/Users/sonny/Desktop/covid_project/covid_deaths.csv'
into table covid_t1
fields terminated by ','
ignore 1 rows ;

## creating table 2

create table covid_t2 (
iso_code varchar(50),
continent varchar(50),
location varchar(50),
date date,
population int,
total_tests int,
new_tests int,
total_tests_per_thousand dec(12,3),
new_tests_per_thousand dec(12,3),
new_tests_smoothed int,
new_tests_smoothed_per_thousand dec(12,3),
positive_rate dec(12,4),
tests_per_case dec(12,3),
tests_units varchar(50),
total_vaccinations int,
people_vaccinated int,
people_fully_vaccinated int,
total_boosters int,
new_vaccinations int,
new_vaccinations_smoothed int,
total_vaccinations_per_hundred dec(12,3),
people_vaccinated_per_hundred dec(12,3),
people_fully_vaccinated_per_hundred dec(12,3),
total_boosters_per_hundred dec(12,3),
new_vaccinations_smoothed_per_million int,
new_people_vaccinated_smoothed int,
new_people_vaccinated_smoothed_per_hundred dec(12,3),
stringency_index dec(12,3),
population_density dec(12,3),
median_age dec(12,3),
aged_65_older dec(12,3),
aged_70_older dec(12,3),
gdp_per_capita dec(12,3),
extreme_poverty dec(12,3),
cardiovasc_death_rate dec(12,3),
diabetes_prevalence dec(12,3),
female_smokers dec(12,3),
male_smokers dec(12,3),
handwashing_facilities dec(12,3),
hospital_beds_per_thousand dec(12,3),
life_expectancy dec(12,3),
human_development_index dec(12,3),
excess_mortality_cumulative_absolute dec(12,3),
excess_mortality_cumulative dec(12,3),
excess_mortality dec(12,3),
excess_mortality_cumulative_per_million dec(12,6)
);

## to import data 

load data local infile 'C:/Users/sonny/Desktop/covid_project/covid_vaccination.csv'
into table covid_vac
fields terminated by ','
ignore 1 rows ;
## creating table 2

