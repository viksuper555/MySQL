#PROBLEM 2
SELECT repository_id,contributor_id FROM repositories_contributors
WHERE  repository_id = contributor_id
ORDER BY id ASC;

#PROBLEM 3
SELECT i.id, CONCAT(u.username, ' : ', i.title) AS 'issue_assignee' FROM users AS u
JOIN issues AS i
WHERE u.id = i.assignee_id
ORDER BY i.id DESC;

#PROBLEM 4
SELECT f.id, f.name as Name, CONCAT(f.size, 'KB') as size FROM files AS f
WHERE NOT EXISTS( SELECT p.parent_id FROM files AS p
				   WHERE p.parent_id = f.id
				)
ORDER BY f.id;

#PROBLEM 5
SELECT r.id, r.name, COUNT(DISTINCT i.id) AS `issues` FROM repositories AS r
JOIN issues AS i
ON i.repository_id = r.id
GROUP BY r.id
ORDER BY `issues` DESC, r.id ASC
LIMIT 5;

#PROBLEM 6
SELECT 
    rc.repository_id,
	r.name, 
	COUNT(DISTINCT c.id) AS `commits`, 
	COUNT(DISTINCT rc.contributor_id) AS `contributors` 
FROM repositories_contributors AS rc
JOIN repositories AS r
ON rc.repository_id = r.id
JOIN commits AS c
ON r.id = c.repository_id
GROUP BY rc.repository_id
ORDER BY `contributors` DESC, r.id ASC
LIMIT 1;


#PROBLEM 7	
SELECT r.id, r.name, COUNT(DISTINCT c.contributor_id)  AS `users` FROM commits AS c
RIGHT JOIN repositories AS r
ON c.repository_id = r.id
GROUP BY r.id
ORDER BY `users` DESC,r.id ASC;
