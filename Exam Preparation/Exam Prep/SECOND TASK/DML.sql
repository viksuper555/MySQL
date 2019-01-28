#PROBLEM 1
INSERT INTO travel_cards 
	(card_number, job_during_journey, colonist_id, journey_id)
SELECT
	(
    CASE 
	WHEN c.birth_date > '1980-01-01'	
		THEN CONCAT(YEAR(c.birth_date), DAY(c.birth_date), LEFT(c.ucn,4)) 
	ELSE 
		CONCAT(YEAR(c.birth_date), MONTH(c.birth_date), RIGHT(c.ucn,4))
    END
	) AS `card_number`,
    (
    CASE
    WHEN c.id % 2 = 0 THEN  'Pilot'
	WHEN c.id % 3 = 0 THEN  'Cook'
    ELSE 'Engineer'
    END
    ) AS `job_during_journey`,
    c.id,
    (
    LEFT(c.ucn,1)
    ) AS `journey_id`
FROM colonists AS c
WHERE c.id >= 96 AND c.id <= 100;



#PROBLEM 2
UPDATE journeys AS j
SET purpose =
(
CASE
WHEN j.id % 2 = 0
	THEN 'Medical'
WHEN j.id % 3 = 0
	THEN 'Technical'  
WHEN j.id % 5 = 0
	THEN 'Educational'
WHEN j.id % 7 = 0
	THEN 'Military'
ELSE purpose
END
);

#PROBLEM 3
DELETE FROM colonists
WHERE id NOT IN(SELECT colonist_id FROM travel_cards);