USE world_cup;

SELECT * FROM matches;
SELECT * FROM players;
SELECT * FROM worldcups;
#More goals in one single match
SELECT player_name, MAX(Goals) AS goals
FROM players
GROUP BY player_name
ORDER BY goals DESC
LIMIT 10;
#More goals in the competition
SELECT player_name, SUM(Goals) AS goals
FROM players
GROUP BY player_name
ORDER BY goals DESC
LIMIT 10;
#Players who scored most goals in one world cup
SELECT distinct(p.player_name) AS player, m.year, SUM(Goals) AS goals
FROM players p
INNER JOIN matches m
ON p.matchid = m.matchid
GROUP BY player_name, year
ORDER BY goals DESC
LIMIT 10;
#Wich Team won most world cups
SELECT Winner, COUNT(Winner) AS Times #,COUNT(Runners-Up) AS Second
FROM worldcups
GROUP BY Winner #,Runners-Up
ORDER BY Times DESC
LIMIT 10;
#most 2nd places
SELECT `Runners-Up`, COUNT(`Runners-Up`) AS Times
FROM worldcups
GROUP BY `Runners-Up`
ORDER BY Times DESC
LIMIT 10;
#edition wiht most goals and ratio matches/goals
SELECT year, MatchesPlayed AS Matches, SUM(GoalsScored) AS Goals, SUM(GoalsScored)/MatchesPlayed AS ratio
FROM worldcups
GROUP BY year, Matches
ORDER BY ratio DESC
LIMIT 10;




