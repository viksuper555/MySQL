#PROBLEM 1
SELECT card_number, job_during_journey FROM travel_cards
ORDER BY card_number ASC;


#PROBLEM 2
SELECT id, CONCAT(first_name,' ', last_name) AS `full_name`, ucn FROM colonists
ORDER BY first_name,last_name,id;

#PROBLEM 3
SELECT id, journey_start,journey_end FROM journeys
WHERE purpose = 'Military'
ORDER BY journey_start ASC;

#PROBLEM 4
SELECT c.id, CONCAT(c.first_name, ' ', c.last_name) as `full name` FROM travel_cards AS tc
JOIN colonists AS c
ON c.id = tc.colonist_id
WHERE job_during_journey = 'Pilot'
ORDER BY c.id;

#PROBLEM 5 
SELECT s.name AS `spaceship_name`, sp.name AS `spaceport_name` FROM journeys AS j
JOIN spaceports AS sp
ON sp.id = j.destination_spaceport_id
JOIN spaceships AS s
ON s.id = j.spaceship_id
ORDER BY s.light_speed_rate DESC
LIMIT 1;

#PROBLEM 6
SELECT p.name AS 'planet_name', s.name AS 'spaceport_name' FROM journeys AS j
JOIN spaceports AS s
ON s.id = j.destination_spaceport_id
JOIN planets AS p
ON p.id = s.planet_id
WHERE j.purpose = 'Educational'
ORDER BY s.name DESC;

#PROBLEM 7
SELECT p.name AS `p_name` , COUNT(DISTINCT j.id) AS `journeys_count` FROM journeys AS j
JOIN spaceports AS s
ON s.id = j.destination_spaceport_id
JOIN planets AS p
ON p.id = s.planet_id
GROUP BY s.planet_id
ORDER BY `journeys_count` DESC , p.name ASC;
