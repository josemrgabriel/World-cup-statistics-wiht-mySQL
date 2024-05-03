CREATE DATABASE IF NOT EXISTS World_cup;

use world_cup;

select * from worldcups;
ALTER TABLE worldcups ADD cup_id int NOT NULL AUTO_INCREMENT primary key;
ALTER TABLE worldcups MODIFY cup_id int after year;
ALTER TABLE worldcups MODIFY year int after cup_id;

select * from matches;
ALTER TABLE matches MODIFY matchid INTEGER;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE matches RENAME COLUMN new_column_name TO home_team_name;
ALTER TABLE matches RENAME COLUMN `Home Team Goals` TO home_team_goals;
ALTER TABLE matches RENAME COLUMN `Away Team Goals` TO away_team_goals;
ALTER TABLE matches RENAME COLUMN `Away Team Name` TO away_team_name;
ALTER TABLE matches RENAME COLUMN `Win conditions` TO win_conditions;
ALTER TABLE matches RENAME COLUMN `Half-time Home Goals` TO half_time_home_goals;
ALTER TABLE matches RENAME COLUMN `Half-time Away Goals` TO half_time_away_goals;
ALTER TABLE matches RENAME COLUMN `Home Team Initials` TO home_team_initials;
ALTER TABLE matches RENAME COLUMN `Away Team Initials` TO away_team_initials;
ALTER TABLE matches RENAME COLUMN `Assistant 1` TO assistant_1;
ALTER TABLE matches RENAME COLUMN `Assistant 2` TO assistant_2;
ALTER TABLE matches MODIFY matchid int after year;
ALTER TABLE matches MODIFY year int after matchid;
ALTER TABLE matches ADD cup_id INT;
ALTER TABLE matches MODIFY cup_id int after matchid;

select * from players;
ALTER TABLE players RENAME COLUMN `Player Name` TO player_name;
ALTER TABLE players RENAME COLUMN `Team Initials` TO team_initials;
ALTER TABLE players DROP COLUMN MyUnknownColumn;
ALTER TABLE players
ADD FOREIGN KEY (matchid) REFERENCES matches(matchid);
ALTER TABLE players ADD pgpmatch_id int NOT NULL AUTO_INCREMENT primary key;
ALTER TABLE players MODIFY pgpmatch_id int after matchid;
ALTER TABLE players MODIFY matchid int after pgpmatch_id;

SET SQL_SAFE_UPDATES = 0;

update matches
join
(select m.matchid,
case when wc.year = m.year then wc.cup_id else null end as cup_id
from matches m
inner join worldcups wc
on wc.year = m.year) mc
on mc.matchid=matches.matchid
set matches.cup_id=mc.cup_id
where matches.cup_id is null;

ALTER TABLE matches
ADD FOREIGN KEY (cup_id) REFERENCES worldcups(cup_id);