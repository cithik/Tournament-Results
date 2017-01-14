-- Table definitions for the tournament project.



-- Drop database if exists
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;

-- Connect to the database tournament
\c tournament;


--TABLES
--Create table for players
CREATE TABLE players(
  id SERIAL PRIMARY KEY ,
  name TEXT
);


--Create table for matches
CREATE TABLE matches(
  id SERIAL PRIMARY KEY ,
  winner INTEGER REFERENCES players(id),
  loser INTEGER REFERENCES players(id)
);


--VIEWS
--Create View to record player standings
CREATE VIEW standings AS
  SELECT
    p.id,
    p.name,
    (SELECT count(*) FROM matches WHERE matches.winner = p.id) AS win_total,
    (SELECT count(*) FROM matches WHERE (matches.winner = p.id OR matches.loser = p.id)) AS match_total
  FROM players p ORDER BY win_total DESC;

--Create View to record standings with row number to identify each row
CREATE VIEW standings_with_row AS
  SELECT row_number() OVER (ORDER BY win_total) AS row_id,
    id,
    name,
    win_total,
    match_total
  FROM standings;

--Create view to pair players for the next match
CREATE VIEW pairs AS
  SELECT s.id AS player1_id, s.name AS player1, s1.id AS player2_id, s1.name AS player2_name
  FROM standings_with_row s JOIN standings_with_row s1 ON s.row_id % 2 != 0 AND s1.id =
                                                        (SELECT id FROM standings_with_row WHERE row_id = s.row_id + 1);


-- Show tables
\dt;

-- Show views
\dv;