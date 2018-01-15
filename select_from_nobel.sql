/*
	https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial
*/

-- 1. Winners from 1950

/* Change the query shown so that it displays Nobel prizes for 1950. */

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

-- 2. 1962 Literature

/* Show who won the 1962 prize for Literature. */

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

-- 3. Albert Einstein

/* Show the year and subject that won 'Albert Einstein' his prize. */

select yr, subject from nobel where winner = 'Albert Einstein'

-- 4. Recent Peace Prizes

/* Give the name of the 'Peace' winners since the year 2000, including 2000. */

select winner from nobel where yr >= 2000 and subject = 'Peace'

-- 5. Literature in the 1980's

/* Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. */

select * from nobel where yr >= 1980 and yr <= 1989 and subject = 'Literature'

-- 6. Only Presidents

/* Show all details of the presidential winners:

    Theodore Roosevelt
    Woodrow Wilson
    Jimmy Carter
    Barack Obama */

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

-- 7. John

/* Show the winners with first name John */

select winner from nobel where winner like 'John %'

-- 8. Chemistry and Physics from different years

/* Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984. */

select yr, subject, winner from nobel where (subject = 'Physics' and yr = 1980) or (subject = 'Chemistry' and yr = 1984)

-- 9. Exclude Chemists and Medics

/* Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine */

select yr, subject, winner from nobel where yr = 1980 and subject <> 'Chemistry' and subject <> 'Medicine'

-- 10. Early Medicine, Late Literature

/* Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) */

select yr, subject, winner from nobel where (yr < 1910 and subject = 'Medicine') or (yr >= 2004 and subject = 'Literature')

-- 11. Umlaut

/* Find all details of the prize won by PETER GRÜNBERG */

select * from nobel where winner = 'PETER GRÜNBERG'

-- 12. Apostrophe

/* Find all details of the prize won by EUGENE O'NEILL */

select * from nobel where winner = 'EUGENE O''NEILL'

-- 13. Knights of the realm

/* Knights in order

List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order. */

select winner, yr, subject from nobel where winner like 'Sir %' order by yr desc, winner

-- 14. Chemistry and Physics last

/* The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last. */

select winner, subject from nobel where yr = 1984 order by subject in ('Chemistry', 'Physics'), subject, winner
