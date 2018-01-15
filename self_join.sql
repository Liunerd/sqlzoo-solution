/*
	https://sqlzoo.net/wiki/Self_join
*/

-- 1.

/* How many stops are in the database. */

select count(*) from stops;

-- 2.

/* Find the id value for the stop 'Craiglockhart' */

select id from stops where name = 'Craiglockhart'

-- 3.

/* Give the id and the name for the stops on the '4' 'LRT' service. */

select id,name from stops join route on stop=id where num=4 and company='LRT'

-- 4.

/* The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes. */

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num having count(*)=2

-- 5.

/* Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road. */

select a.company,a.num,a.stop,b.stop from route a join route b on (a.company=b.company and a.num = b.num and a.stop=53 and b.stop=149)

-- 6.

/* The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' */

select a.company, a.num, c.name, d.name from route a
join route b on a.company = b.company and a.num = b.num and a.stop <> b.stop
join stops c on c.id = a.stop
join stops d on d.id = b.stop
where c.id = (select id from stops e where e.name = 'Craiglockhart')
and d.id = (select id from stops f where f.name = 'London Road')

-- 7.

/* Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') */

select a.company,a.num from route a join route b on a.company = b.company and a.num = b.num and a.stop = 115 and b.stop = 137 group by a.company,a.num

-- 8.

/* Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' */

select a.company,a.num from route a
join route b on a.company = b.company and a.num = b.num and a.stop = (select id from stops where name = 'Craiglockhart') and b.stop = (select id from stops where name = 'Tollcross')

-- 9.

/* Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services. */

select c.name, a.company, a.num from route a
join route b on a.company = 'LRT' and a.company = b.company and a.num = b.num and a.stop = (select id from stops where name = 'Craiglockhart')
join stops c on c.id = b.stop

-- 10.

/* Find the routes involving two buses that can go from Craiglockhart to Sighthill.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus. */

select distinct
    route1.num, route1.company, s.name, route2.num, route2.company
from (
    select a.num, a.company, b.stop from route a join route b on
        a.company = b.company and a.num = b.num
    where a.stop = (select id from stops where name = 'Craiglockhart')
) as route1 join (
    select c.num, c.company, d.stop from route c join route d on
        c.company = d.company and c.num = d.num
    where c.stop = (select id from stops where name = 'Sighthill')
) as route2 on route1.stop = route2.stop
join stops s on s.id = route1.stop
