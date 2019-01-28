USE company;


#PROBLEM 1 
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	WHERE e.salary > 35000
	ORDER BY e.first_name,e.last_name;
END $$


CALL usp_get_employees_salary_above_35000();

#PROBLEM 2

DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above(number INT(11))
BEGIN
SELECT e.first_name, e.last_name FROM employees AS e
WHERE e.salary >= number
ORDER BY e.first_name,e.last_name;
END $$


CALL usp_get_employees_salary_above(48100);

#PROBLEM 3

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(string VARCHAR(20))
BEGIN
SELECT t.name FROM towns AS t
WHERE LEFT(t.name,1) = string
ORDER BY t.name;
END $$


CALL usp_get_towns_starting_with('b');




#PROBLEM 4
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(30))
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	JOIN addresses AS a ON e.address_id = a.address_id
	JOIN towns AS t ON a.town_id = t.town_id
    WHERE t.name = town_name
    ORDER BY first_name,last_name;
		
END $$

CALL usp_get_employees_from_town('Sofia');


#PROBLEM 5

