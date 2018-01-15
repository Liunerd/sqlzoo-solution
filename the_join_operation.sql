/*
	https://sqlzoo.net/wiki/The_JOIN_operation
*/

-- 1.

/* The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER' */

select matchid,player from goal where teamid='GER'

-- 2.

/* From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012 */

select id,stadium,team1,team2 from game where id=1012

-- 3.

/* You can combine the two steps into a single query with a JOIN.

SELECT *
  FROM game JOIN goal ON (id=matchid)

The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the id from goal must match matchid from game. (If we wanted to be more clear/specific we could say
ON (game.id=goal.matchid)

The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.

Modify it to show the player, teamid, stadium and mdate for every German goal. */

select player,teamid,stadium,mdate from game join goal on id=matchid where teamid='GER'

-- 4.

/* Use the same JOIN as in the previous question.

Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'*/

select team1,team2,player from game join goal on matchid=id where player like 'Mario%'

-- 5.

/* The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */

select player, teamid, coach, gtime from goal join eteam on teamid = id where gtime <= 10

-- 6.

/* To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */

select mdate,teamname from game join eteam on team1=eteam.id where coach = 'Fernando Santos'

-- 7.

/* List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */

select player from goal join game on goal.matchid = game.id where stadium='National Stadium, Warsaw'

-- 8.

/* The example query shows all goals scored in the Germany-Greece quarterfinal.

Instead show the name of all players who scored a goal against Germany. */

select distinct player from goal join game on goal.matchid=game.id where (team1='GER' or team2='GER') and goal.teamid <> 'GER'

-- 9.

/* Show teamname and the total number of goals scored. */

select teamname,count(teamid) from goal join eteam on teamid=id group by teamname

-- 10.

/* Show the stadium and the number of goals scored in each stadium. */

select stadium, count(stadium) from goal join game on matchid=id group by stadium

-- 11.

/* For every match involving 'POL', show the matchid, date and the number of goals scored. */

select matchid,mdate,count(*) from goal join game on id=matchid where team1='POL' or team2 = 'POL' group by matchid,mdate

-- 12.

/* For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' */

select matchid,mdate,count(*) from goal join game on game.id=goal.matchid where teamid='GER' group by matchid,mdate

-- 13.

/* List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA 	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...

Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2. */

select mdate,team1,sum(case when team1=teamid then 1 else 0 end) as score1, team2, sum(case when team2=teamid then 1 else 0 end) as score2 from game left join goal on matchid=id group by mdate,team1,team2 order by mdate,matchid,team1,team2
