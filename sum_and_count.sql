/*
	https://sqlzoo.net/wiki/SUM_and_COUNT
*/

-- 1. Total world population

/* Show the total population of the world.

world(name, continent, area, population, gdp) */

SELECT SUM(population)
FROM world

-- 2. List of continents

/* List all the continents - just once each. */

select distinct continent from world

-- 3. GDP of Africa

/* Give the total GDP of Africa */

select sum(gdp) from world where continent = 'Africa'

-- 4. Count the big countries

/* How many countries have an area of at least 1000000 */

select count(name) from world where area >= 1000000

-- 5. Baltic states population

/* What is the total population of ('Estonia', 'Latvia', 'Lithuania') */

select sum(population) from world where name in ('Estonia', 'Latvia', 'Lithuania') 

-- 6. Counting the countries of each continent

/* For each continent show the continent and number of countries. */

select continent, count(name) from world group by continent

-- 7. Counting big countries in each continent

/* For each continent show the continent and number of countries with populations of at least 10 million. */

select continent, count(name) from world where population >= 10000000 group by continent

-- 8. Counting big continents

/* List the continents that have a total population of at least 100 million. */

select continent from world group by continent having sum(population) > 100000000
