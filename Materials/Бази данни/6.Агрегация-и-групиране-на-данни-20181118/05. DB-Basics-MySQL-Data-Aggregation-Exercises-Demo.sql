-- Data Funtions

USE soft_uni;

SELECT town_id
      ,name
  FROM towns
 WHERE name LIKE 'M%'
    OR name LIKE 'K%'
    OR name LIKE 'B%'
    OR name LIKE 'E%'
 ORDER BY name ASC;
 
 -- 
 
 USE geography;
 
 SELECT country_name, iso_code
  FROM countries
 WHERE LENGTH(country_name) - LENGTH(REPLACE(country_name, 'a','')) >= 3
 -- CountryName LIKE '%a%a%a%'
 ORDER BY iso_code ASC;
 
 USE diablo;
 
 -- 12
 SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS new_date
  FROM games
 WHERE YEAR(start) IN (2011, 2012)
 ORDER BY start, name
 LIMIT 50;
 
 -- 13
SELECT user_name, substr(email,locate('@', email) + 1,length(email)) AS email_provider
  FROM users 
 ORDER BY email_provider, user_name;


use gringotts;
 -- Data Aggregations
  SELECT CASE
			WHEN age <= 10 THEN '[0-10]'
			WHEN age <= 20 THEN '[11-20]'
			WHEN age <= 30 THEN '[21-30]'
			WHEN age <= 40 THEN '[31-40]'
			WHEN age <= 50 THEN '[41-50]'
			WHEN age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS age_group,
        COUNT(*) AS wizzard_count
   FROM wizzard_deposits
  GROUP BY CASE
			WHEN age <= 10 THEN '[0-10]'
			WHEN age <= 20 THEN '[11-20]'
			WHEN age <= 30 THEN '[21-30]'
			WHEN age <= 40 THEN '[31-40]'
			WHEN age <= 50 THEN '[41-50]'
			WHEN age <= 60 THEN '[51-60]'
			ELSE '[61+]'
	END;
	
-- 04
  SELECT deposit_group FROM
(SELECT deposit_group, AVG(magic_wand_size) AS avrage_magic_wand_size
   FROM wizzard_deposits
  GROUP BY deposit_group) as avgm
  WHERE avrage_magic_wand_size = ( SELECT MIN(avrage_magic_wand_size) min_average_magic_wand_size 
								   FROM
								(SELECT deposit_group, AVG(magic_wand_size) AS avrage_magic_wand_size
								   FROM wizzard_deposits
								  GROUP BY deposit_group) AS av);
use soft_uni;						  
-- 17

-- 1. MAX Salary
-- 2. Salaries < Max Salary = Second Highest Salary
-- 3. Salaries < Second Highest Salary = Third Highest Salary
SELECT e.department_id, MAX(salary) AS third_max_salary
 FROM employees AS e
 JOIN
(SELECT e.department_id, MAX(salary) as second_max_salary 
  FROM employees AS e
JOIN
(SELECT department_id, MAX(salary) as max_salary 
   FROM employees
  GROUP BY department_id) AS max_salary
    ON e.department_id = max_salary.department_id
   AND e.salary < max_salary.max_salary
 GROUP BY e.department_id) second_max_salary
    ON e.department_id = second_max_salary.department_id
   AND e.salary < second_max_salary.second_max_salary
GROUP BY e.department_id;