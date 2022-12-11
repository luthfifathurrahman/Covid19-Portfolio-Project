# Covid-19 Portfolio Project

<p align="justify">Coronavirus disease, or COVID-19, is an infectious disease caused by the SARS-CoV-2 virus. Most people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment. However, some will become seriously ill and require medical attention.</p>

<p align="justify">The virus can spread from an infected person’s mouth or nose in small liquid particles when they cough, sneeze, speak, sing or breathe. These particles range from larger respiratory droplets to smaller aerosols. You can be infected by breathing in the virus if you are near someone with COVID-19 or by touching a contaminated surface and your eyes, nose, or mouth. The virus spreads more easily indoors and in crowded settings. (source: https://www.who.int/news-room/questions-and-answers/item/coronavirus-disease-covid-19-how-is-it-transmitted).</p>

<p align="justify">So, I will analyze data regarding Covid-19. The data I use contains a list of countries, the number of cases, the number of deaths, the number of people vaccinated, and much more. In addition, this data starts from January 1, 2020, to October 18, 2022.</p>


## What I Do in This Project

- Analyzing Using Microsoft SQL.
	- Data Profiling.
		- Looking All The Data from The CovidDeaths Table.
		- Counting How Many Rows in The CovidDeaths Table.
		- Showing The Data Type For Every Column in The CovidDeaths Table.
		- Looking All The Data from The CovidVaccinations Table.
		- Counting How Many Rows in The CovidVaccinations Table.
		- Showing The Data Type For Every Column in The CovidVaccinations Table.
	- Data Cleansing.
		- CovidDeaths Table.
			- iso_code Column.
				- Checking The iso_code Column.
				- Removing The iso_code Column.
			- continent Column.
				- Checking The Amount of Unique Value in continent Column.
				- Checking Missing Value on continent Column.
				- Removing Row That Has A Null Value in continent Column and North America, Asia, World, 
Africa, Oceania, European Union, South America, International, Europe.
				- Replacing Null Values in continent Column into Undefined.
			- location Column.
				- Checking Missing Value on location Column.
				- Checking The Amount of Unique Value in location Column.
			- date Column.
				- Checking Missing Value on date Column.
				- Changing The Format Date on date Column.
				- Removing date column From The CovidDeaths Column.
			- population Column.
				- Checking Missing Value on population Column.
				- Handling Missing Value on population Column.
			- total_cases Column.
				- Checking Missing Value on total_cases Column.
				- Handling Missing Value on total_cases Column.
			- new_cases Column.
				- Checking Missing Value on new_cases Column.
				- Handling Missing Value on new_cases Column.
			- total_deaths Column.
				- Checking Missing Value on total_deaths Column.
				- Handling Missing Value on total_deaths Column.
			- new_deaths Column.
				- Checking Missing Value on new_deaths Column.
				- Handling Missing Value on new_deaths Column.
			- Removing Unused Column.
			- Changing The Data Type.
		- CovidVaccinations Table.
			- iso_code Column.
				- Checking The iso_code Column.
				- Removing The iso_code Column.
			- continent Column.
				- Checking The Amount of Unique Value in continent Column.
				- Checking Missing Value on continent Column.
				- Removing Row That Has A Null Value in continent Column and North America, Asia, World, 
Africa, Oceania, European Union, South America, International, Europe.
				- Replacing Null Values in continent Column into Undefined.
			- location Column.
				- Checking Missing Value on location Column.
				- Checking The Amount of Unique Value in location Column.
			- date Column.
				- Checking Missing Value on date Column.
				- Changing The Format Date on date Column.
				- Removing date column From The CovidDeaths Column.
			- people_fully_vaccinated Column.
				- Checking Missing Value on people_fully_vaccinated Column.
				- Handling Missing Value on people_fully_vaccinated Column.
			- total_boosters Column.
				- Checking Missing Value on total_boosters Column.
				- Handling Missing Value on total_boosters Column.
			- Removing Unused Column.
			- Changing The Data Type.
	- Data Exploration
		- Looking For The Highest Total Cases in ASEAN Country.
			- Creating View For The Highest Total Cases in ASEAN Country.
		- Looking For The Highest Total Deaths in ASEAN Country.
			- Creating View For The Highest Total Deaths in ASEAN Country.
		- Looking For The Highest CFR in ASEAN Country.
			- Creating View For The Highest CFR in ASEAN Country.
		- Looking For The Highest AR in ASEAN Country.
			- Creating View For The Highest AR in ASEAN Country.
		- Looking For a Continent with The Highest Total Cases.
			- Creating View For The Highest Total Cases in Continent.
		- Looking For a Continent with The Highest Total Deaths.
			- Creating View For The Highest Total Deaths in Continent.
		- Looking For The Highest Total Cases By The Level of Income.
			- Creating View For The Highest Total Cases By The Level of Income.
		- Looking For The Highest Total Deaths By The Level of Income.
			- Creating View For The Highest Total Deaths By The Level of Income.
		- Looking For Global CFR.
			- Creating View For The Global CFR.
		- Looking For Percentage of Population That Has Fully Received Covid-19 Vaccine in ASEAN Country.
			- Creating View For The Number of Population That Has Fully Received Covid-19 Vaccine in ASEAN Country.
		- Using CTE to Perform Calculation on Percent Poppulation Vaccinated in ASEAN Country.
		- Using Temp Table to Perform Calculation on Percent Poppulation Vaccinated in ASEAN Country

## Data Source
Source: https://ourworldindata.org/
