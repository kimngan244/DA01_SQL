---ex2:
WITH cte AS 
(SELECT player_id, MIN(event_date) AS first_login_date
FROM Activity 
GROUP BY player_id)
SELECT 
ROUND(
SUM(DATEDIFF(Activity.event_date, cte.first_login_date) = 1) / COUNT(DISTINCT Activity.player_id),2) AS fraction
FROM Activity 
JOIN cte ON Activity.player_id = cte.player_id

---ex3:
SELECT 
CASE
WHEN id % 2 <> 0 AND id = (SELECT COUNT(*) FROM Seat) THEN id
WHEN id % 2 = 0 THEN id - 1
ELSE id + 1 
END AS id,
student
FROM Seat  
ORDER BY id

---ex4:
