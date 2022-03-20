--SELECT *
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--ORDER BY 3,4

----SELECT *
----FROM portfolioproject.dbo.CovidVaccination
----ORDER BY 3,4

----從CovidDeath資料表中選取所需欄位

--SELECT location,date,total_cases,new_cases,total_deaths,population
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--ORDER BY 1,2

----查看總確診人數與總死亡人數的關係
----進一步查看在美國地區確診Coivd-19的死亡率

--SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
--FROM portfolioproject.dbo.CovidDeath
--WHERE location LIKE '%state%'
--ORDER BY 1,2

----查看總確診人數與美國人口數的關係
----了解美國人口的確診率

--SELECT location,date,population,total_cases,(total_cases/population)*100 AS PercentagePopulationInfected
--FROM portfolioproject.dbo.CovidDeath
--WHERE location LIKE '%state%'
--ORDER BY 1,2

----查看高確診率的國家以及其人口數
--SELECT location,population,MAX(total_cases) AS HighestInfectionCount ,MAX((total_cases/population))*100 AS PercentagePopulationInfected
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--GROUP BY location,population
--ORDER BY PercentagePopulationInfected DESC

----查看死亡率的國家以及其人口數
--SELECT location,MAX(cast(total_deaths as int)) AS TotalDeathCount 
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--GROUP BY location
--ORDER BY TotalDeathCount DESC

----查看各州狀況
--SELECT continent,MAX(cast(total_deaths as int)) AS TotalDeathCount 
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--GROUP BY continent
--ORDER BY TotalDeathCount DESC

----找出死亡人數比率（相對總人口數）最多的州

----查看全球概況
--SELECT SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS int)) AS total_deaths,(SUM(CAST(new_deaths AS int)))/SUM(new_cases)*100 AS DeathPercentage
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
----GROUP BY date
--ORDER BY 1,2

----將全球確診死亡資料與全球疫苗接種資料整合

--SELECT *
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date

----查看全球人口與疫苗接種人數的關係

--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location,dea.date) AS RollingPeopleVanccinated
----,(RollingPeopleVanccinated/population)*100
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date
--WHERE dea.continent is not null
--ORDER BY 2,3;

----使用CTE遞迴查詢
--With PopvsVac (continent,location,date,population,new_vaccinations,RollingPeopleVanccinated)
--AS
--(
--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location,dea.date) AS RollingPeopleVanccinated
----,(RollingPeopleVanccinated/population)*100
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date
--WHERE dea.continent is not null
----ORDER BY 2,3
--)
--SELECT * ,(RollingPeopleVanccinated/population)*100
--FROM PopvsVac

----TEMP TABLE

--DROP TABLE if exists #PercentagePopulationVacinnated
--CREATE TABLE #PercentagePopulationVacinnated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--RollingPeopleVanccinated numeric
--)


--INSERT INTO #PercentagePopulationVacinnated

--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location,dea.date) AS RollingPeopleVanccinated
----,(RollingPeopleVanccinated/population)*100
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date
--WHERE dea.continent is not null
----ORDER BY 2,3

--SELECT * ,(RollingPeopleVanccinated/population)*100
--FROM #PercentagePopulationVacinnated

----創建View以作為後續資料視覺化使用
--GO
--CREATE VIEW PercentagePopulationVacinnated1 AS
--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location,dea.date) AS RollingPeopleVanccinated
----,(RollingPeopleVanccinated/population)*100
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date
--WHERE dea.continent is not null;

SELECT*
FROM PercentagePopulationVacinnated1

