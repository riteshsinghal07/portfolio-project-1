select *
from Portfolioproject.dbo.COVIDDEATH
where continent is not null
order by 3,4

--select *
--from Portfolioproject.dbo.COVIDVACCINE
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from Portfolioproject.dbo.COVIDDEATH
where continent is not null
order by 1,2

-- looking at total case vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from Portfolioproject.dbo.COVIDDEATH
where location like '%states%'
and continent is not null
order by 1,2

--looking at total case vs population

select location, date, population, total_cases, (total_cases/population)*100 as infectedpopulation
from Portfolioproject.dbo.COVIDDEATH
where continent is not null
--where location like '%states%'
order by 1,2

--looking at countries with high infection rates

select location, population, max(total_cases) as highestinfection, max(total_cases/population)*100 as infectedpopulation
from Portfolioproject.dbo.COVIDDEATH
where continent is not null
--where location like '%states%'
group by location, population
order by 1,2
 --looking countreies with highest death rates

 select location, max(cast(total_cases as int)) as totaldeathcount
 from Portfolioproject.dbo.COVIDDEATH
--where location like '%states%'
where continent is not null
group by location
order by totaldeathcount desc

--looking by continent

select continent, max(cast(total_cases as int)) as totaldeathcount
 from Portfolioproject.dbo.COVIDDEATH
--where location like '%states%'
where continent is not null
group by continent
order by totaldeathcount desc

--global numbers

select sum(new_cases) as totalcases, sum(cast(new_deaths as int)) as totaldeaths, sum(cast(new_deaths as int))/sum(new_cases)*100
as deathpercentage
from Portfolioproject.dbo.COVIDDEATH
where continent is not null
order by 1,2

--loooking at total populations vs vaccations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date)
as rollingpeoplevaccinated
--(rollingpeoplevaccinated/population)*100

from Portfolioproject.dbo.COVIDDEATH dea
join Portfolioproject.dbo.COVIDVACCINE vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
order by 2,3

--   --temp table
--   create table #percentpopulationvaccinated
--   (
--   continent nvarchar(255),
--   location nvarchar(255),
--   data datetime,
--   population numeric,
--   new_vaccinations numeric,
--   rollingpeoplevaccinated numeric
--   )
--   insert into #percentpopulationvaccinated
--   select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date)
--as rollingpeoplevaccinated
----(rollingpeoplevaccinated/population)*100

--from Portfolioproject.dbo.COVIDDEATH dea
--join Portfolioproject.dbo.COVIDVACCINE vac
--   on dea.location = vac.location
--   and dea.date = vac.date
--where dea.continent is not null
--order by 2,3





--select * from percentpopulationvaccinated

  

