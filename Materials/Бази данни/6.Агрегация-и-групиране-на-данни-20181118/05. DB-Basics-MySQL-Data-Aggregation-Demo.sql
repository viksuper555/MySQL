-- MySQL
-- Data Aggregation
SELECT e.department_id, YEAR(e.hire_date) AS 'hire_year', SUM(e.salary) AS 'total_salary' 
  FROM employees AS e
 GROUP BY e.department_id, YEAR(e.hire_date)
 ORDER BY e.department_id, 'hire_year'
 
SELECT e.department_id, YEAR(e.hire_date) AS HireYear, SUM(e.salary) AS 'total_salary'
  FROM employees AS e
 GROUP BY e.department_id, YEAR(e.hire_date)
 ORDER BY e.department_id, YEAR(e.hire_date)
 
SELECT e.department_id, SUM(e.salary) AS total_salary
  FROM employees AS e
 GROUP BY e.department_id
 ORDER BY total_salary DESC
 LIMIT 5
 
SELECT e.department_id, e.employee_id, e.first_name, e.salary 
  FROM employees AS e
  JOIN 
(SELECT e.department_id, MAX(e.salary) AS max_salary
  FROM employees AS e
 GROUP BY e.department_id) AS max_salaries
    ON e.department_id = max_salaries.department_id
   AND e.salary = max_salaries.max_salary
 ORDER BY e.department_id
 
SELECT AVG(world_wide_profit) AS average_profit, 
       SUM(world_wide_profit)/COUNT(*) AS average_profit_final
  FROM movies
 WHERE rank <= 5
 
 
SELECT COUNT(m.rank) AS new_column
  FROM movies AS m
  
-- Comment 1
/*Comment 2 */
#Comment 3\


SELECT m.year, MAX(overseas_profit) AS max_overseas_profit 
  FROM movies AS m
 WHERE m.studio NOT LIKE 'F%'
 GROUP BY m.year
HAVING MAX(overseas_profit) > 500000
   AND MIN(overseas_profit) > 100000
 ORDER BY max_overseas_profit
 LIMIT 5

 

 
