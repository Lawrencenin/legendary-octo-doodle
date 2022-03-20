--SELECT *
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--ORDER BY 3,4

----SELECT *
----FROM portfolioproject.dbo.CovidVaccination
----ORDER BY 3,4

----�qCovidDeath��ƪ�����һ����

--SELECT location,date,total_cases,new_cases,total_deaths,population
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--ORDER BY 1,2

----�d���`�T�E�H�ƻP�`���`�H�ƪ����Y
----�i�@�B�d�ݦb����a�ϽT�ECoivd-19�����`�v

--SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
--FROM portfolioproject.dbo.CovidDeath
--WHERE location LIKE '%state%'
--ORDER BY 1,2

----�d���`�T�E�H�ƻP����H�f�ƪ����Y
----�F�Ѭ���H�f���T�E�v

--SELECT location,date,population,total_cases,(total_cases/population)*100 AS PercentagePopulationInfected
--FROM portfolioproject.dbo.CovidDeath
--WHERE location LIKE '%state%'
--ORDER BY 1,2

----�d�ݰ��T�E�v����a�H�Ψ�H�f��
--SELECT location,population,MAX(total_cases) AS HighestInfectionCount ,MAX((total_cases/population))*100 AS PercentagePopulationInfected
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--GROUP BY location,population
--ORDER BY PercentagePopulationInfected DESC

----�d�ݦ��`�v����a�H�Ψ�H�f��
--SELECT location,MAX(cast(total_deaths as int)) AS TotalDeathCount 
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--GROUP BY location
--ORDER BY TotalDeathCount DESC

----�d�ݦU�{���p
--SELECT continent,MAX(cast(total_deaths as int)) AS TotalDeathCount 
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
--GROUP BY continent
--ORDER BY TotalDeathCount DESC

----��X���`�H�Ƥ�v�]�۹��`�H�f�ơ^�̦h���{

----�d�ݥ��y���p
--SELECT SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS int)) AS total_deaths,(SUM(CAST(new_deaths AS int)))/SUM(new_cases)*100 AS DeathPercentage
--FROM portfolioproject.dbo.CovidDeath
--WHERE continent is not null
----GROUP BY date
--ORDER BY 1,2

----�N���y�T�E���`��ƻP���y�̭]���ظ�ƾ�X

--SELECT *
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date

----�d�ݥ��y�H�f�P�̭]���ؤH�ƪ����Y

--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location,dea.date) AS RollingPeopleVanccinated
----,(RollingPeopleVanccinated/population)*100
--FROM portfolioproject.dbo.CovidDeath dea
--JOIN portfolioproject.dbo.CovidVaccination vac
--ON dea.location=vac.location
--AND dea.date=vac.date
--WHERE dea.continent is not null
--ORDER BY 2,3;

----�ϥ�CTE���j�d��
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

----�Ы�View�H�@�������Ƶ�ı�ƨϥ�
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

