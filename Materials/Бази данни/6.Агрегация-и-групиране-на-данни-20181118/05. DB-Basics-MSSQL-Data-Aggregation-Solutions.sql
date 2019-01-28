#Problem 1. Records’ Count
SELECT COUNT(*) FROM wizzard_deposits AS w;

#Problem 2. Longest Magic Wand
SELECT MAX(magic_wand_size) AS longest_magic_wand FROM wizzard_deposits AS w;

#Problem 3. Longest Magic Wand per Deposit Groups
SELECT deposit_group, MAX(magic_wand_size) AS longest_magic_wand
  FROM wizzard_deposits AS w
 GROUP BY deposit_group
 ORDER BY longest_magic_wand, deposit_group;
 
#Problem 4. Smallest Deposit Group per Magic Wand Size
 CREATE TABLE wizzard_deposits_average_size AS
 SELECT deposit_group, AVG(magic_wand_size) AS average_magic_wand_size
   FROM wizzard_deposits AS w
  GROUP BY deposit_group;

 SELECT deposit_group
   FROM wizzard_deposits_average_size AS wdas
  WHERE wdas.average_magic_wand_size =
(SELECT MIN(average_magic_wand_size) AS LowestAveragemagic_wand_size
   FROM wizzard_deposits_average_size AS wdas);

 DROP TABLE wizzard_deposits_average_size;

 #Problem 5. Deposits Sum
 SELECT w.deposit_group, SUM(deposit_amount) AS total_deposit_amount 
   FROM wizzard_deposits AS w
  GROUP BY w.deposit_group
  ORDER BY 2;

 #Problem 6. Deposits Sum for Ollivander family
  SELECT w.deposit_group, SUM(deposit_amount) AS total_deposit_amount 
   FROM wizzard_deposits AS w
  WHERE w.magic_wand_creator = 'Ollivander family'
  GROUP BY w.deposit_group
  ORDER BY w.deposit_group;

 #Problem 7. Deposits Filter
  SELECT w.deposit_group, SUM(deposit_amount) AS total_deposit_amount 
   FROM wizzard_deposits AS w
  WHERE w.magic_wand_creator = 'Ollivander family'
  GROUP BY w.deposit_group
 HAVING SUM(deposit_amount) < 150000
  ORDER BY total_deposit_amount DESC;

 #Problem 8. Deposit charge
  SELECT w.deposit_group, w.magic_wand_creator, MIN(w.deposit_charge) AS min_deposit_charge 
   FROM wizzard_deposits AS w
  GROUP BY w.deposit_group, w.magic_wand_creator
  ORDER BY w.magic_wand_creator ASC, w.deposit_group ASC;

#Problem 9. age Groups
  SELECT CASE
			WHEN w.age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN w.age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN w.age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN w.age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN w.age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN w.age BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN w.age >= 61 THEN '[61+]'
		END AS 'SizeGroup'
		,COUNT(*) as wizzard_count
  FROM wizzard_deposits AS w
 GROUP BY `SizeGroup`
 order by `SizeGroup`;

#Problem 10. Magic Size Groups
SELECT SUBSTRING(w.first_name,1,1) AS first_letter
  FROM wizzard_deposits AS w
 WHERE deposit_group = 'Troll Chest'
 GROUP BY SUBSTRING(w.first_name,1,1)
 ORDER BY first_letter ASC;
  
#Problem 11. Average Interest 1
SELECT w.deposit_group, is_deposit_expired, AVG(w.deposit_interest) AS average_interest
  FROM wizzard_deposits AS w
 WHERE w.deposit_start_date > '19850101'
 GROUP BY w.deposit_group, is_deposit_expired
 ORDER BY w.deposit_group DESC, w.is_deposit_expired ASC;

#Problem 12. Rich Wizard, Poor Wizard
CREATE TABLE rich_wizard_poor_wizard AS
SELECT w1.first_name AS host_wizard
	   ,w1.deposit_amount AS host_deposit
	   ,w2.first_name AS guest_wizard
	   ,w2.deposit_amount AS guest_deposit
  FROM wizzard_deposits AS w1
  JOIN wizzard_deposits AS w2
    ON w1.id = w2.id-1;

SELECT SUM(r.host_deposit-r.guest_deposit) AS sum_difference FROM rich_wizard_poor_wizard AS r;

  DROP TABLE rich_wizard_poor_wizard;

#Problem 13. Employees Minimum Salaries
SELECT department_id
      ,MIN(salary) AS min_salary
  FROM employees AS e
 WHERE e.department_id IN (2,5,7)
   AND e.hire_date > '20000101'
 GROUP BY department_id
 ORDER BY department_id;

#Problem 14. Employees Average Salaries
CREATE TABLE high_paid_employees AS
SELECT * 
  FROM employees AS e
 WHERE e.salary > 30000;
 

DELETE FROM high_paid_employees 
 WHERE manager_id = 42;

UPDATE high_paid_employees
   SET salary = salary + 5000
 WHERE department_id = 1;

SELECT department_id
      ,AVG(salary) AS avg_salary
  FROM high_paid_employees AS e
 GROUP BY department_id
 ORDER BY department_id;

DROP TABLE high_paid_employees;

#Problem 15. Employees Maximum Salaries
SELECT department_id
      ,MAX(salary) AS max_salary
  FROM employees AS e
 GROUP BY department_id
HAVING MAX(salary) NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

#Problem 16. Employees Count Salaries
SELECT COUNT(*) AS employee_count
  FROM employees AS e
 WHERE e.manager_id IS NULL;

#Problem 17. 3rd Highest salary
SELECT e.department_id
  		,MAX(e.salary) AS max_salary
  FROM employees AS e
  JOIN
		(SELECT e.department_id
			   ,MAX(e.salary) AS max_salary
		  FROM employees AS e
		  JOIN 
				(SELECT e.department_id
					    ,MAX(e.salary) AS max_salary
				  FROM employees AS e
				 GROUP BY e.department_id) AS fms
		    ON e.department_id = fms.department_id
			AND e.salary < fms.max_salary
		 GROUP BY e.department_id) AS sms
    ON e.department_id = sms.department_id
	AND e.salary < sms.max_salary
 GROUP BY e.department_id
 ORDER BY department_id;

#Problem 18. salary Challenge
SELECT e.first_name
      ,e.last_name 
	   ,e.department_id
  FROM employees AS e
 INNER JOIN (SELECT department_id
			       ,AVG(salary) AS average_salary
			   FROM employees
			  GROUP BY department_id) AS d
	ON d.department_id = e.department_id
 WHERE e.salary > d.average_salary
 ORDER BY e.department_id
 LIMIT 10;
 
 # Problem 19.	Departments Total Salaries
 
 SELECT e.department_id, sum(e.salary)
 FROM employees e
 GROUP BY e.department_id
 ORDER BY e.department_id;