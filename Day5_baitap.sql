---EX1:
select DISTINCT CITY from STATION
WHERE ID%2=0
ORDER BY CITY

---EX2:
select count(CITY)-count(distinct CITY) from STATION

---EX4:
SELECT ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL),1) AS MEAN 
FROM items_per_order

---EX5:
ELECT candidate_id
FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(SKILL)=3

---EX6:
SELECT user_id, MAX(DATE(post_date))-MIN(DATE(post_date)) AS days_between
FROM posts
WHERE post_date>='2021-01-01' AND post_date <'2022-01-01'
GROUP BY user_id
HAVING COUNT(user_id)>=2

---EX7:
SELECT card_name, MAX(issued_amount)-MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC

---EX8:
SELECT manufacturer, COUNT(drug) AS drug_count, ABS(SUM(total_sales-cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales<cogs
GROUP BY manufacturer
ORDER BY total_loss DESC

---EX9:
SELECT * FROM Cinema
WHERE ID%2<>0 AND description<>'boring'
ORDER BY rating DESC

  ---EX10:
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id
ORDER BY teacher_id ASC

---EX11:
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id

---EX12:
SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student)>=5
ORDER BY class



