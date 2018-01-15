/*
	https://sqlzoo.net/wiki/More_JOIN_operations
*/

-- 1. 1962 movies

/* List the films where the yr is 1962 [Show id, title] */

SELECT id, title
 FROM movie
 WHERE yr=1962

-- 2. When was Citizen Kane released?

/* Give year of 'Citizen Kane'. */

select yr from movie where title = 'Citizen Kane'

-- 3. Star Trek movies

/* List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. */

select id, title, yr from movie where title like '%Star Trek%' order by yr

-- 4. id for actor Glenn Close

/* What id number does the actor 'Glenn Close' have? */

select id from actor where name = 'Glenn Close'

-- 5. id for Casablanca

/* What is the id of the film 'Casablanca' */

select id from movie where title = 'Casablanca'

-- 6. Cast list for Casablanca

/* Obtain the cast list for 'Casablanca'.

Use movieid=11768, (or whatever value you got from the previous question) */

select name from casting join actor on actorid=id where movieid=(select id from movie where title = 'Casablanca')

-- 7. Alien cast list

/* Obtain the cast list for the film 'Alien' */

select name from casting join actor on actorid=id where movieid=(select id from movie where title='Alien')

-- 8. Harrison Ford movies

/* List the films in which 'Harrison Ford' has appeared */

select title from casting join movie on movieid=id where actorid=(select id from actor where name='Harrison Ford')

-- 9. Harrison Ford as a supporting actor

/* List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] */

select title from casting join movie on movieid=id where actorid=(select id from actor where name='Harrison Ford') and ord <> 1

-- 10. Lead actors in 1962 movies

/* List the films together with the leading star for all 1962 films */

select title,name from movie join casting on movie.id=movieid join actor on actorid=actor.id where ord=1 and yr=1962

-- 11. Busy years for John Travolta

/* Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies. */

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

-- 12. Lead actor in Julie Andrews movies

/* List the film title and the leading actor for all of the films 'Julie Andrews' played in. */

select title, name from movie join casting on movie.id = movieid join actor on actor.id = actorid where movieid in (select movieid from casting join actor on actor.id = actorid where name = 'Julie Andrews') and ord = 1

-- 13. Actors with 30 leading roles

/* Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. */

select name from casting join actor on actor.id=actorid where ord = 1 group by name having count(actorid) >= 30

-- 14.

/* List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */

select title,count(actorid) from casting join movie on movie.id = movieid where yr = 1978 group by title order by count(actorid) desc, title

-- 15.

/* List all the people who have worked with 'Art Garfunkel'. */

select distinct name from casting join actor on actorid=id where movieid in(select movieid from casting where actorid=(select id from actor where name = 'Art Garfunkel')) and name <> 'Art Garfunkel'
