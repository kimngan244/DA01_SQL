---EX1:
SELECT 
SUM(CASE WHEN device_type='laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type IN('tablet','phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership

---EX2:
SELECT x,y,z,
CASE
 WHEN x+y>z and y+z>x and x+z>y THEN 'Yes' ELSE 'No'
END as triangle
FROM Triangle

---EX3:
SELECT 
COUNT(case_id) AS uncategorised_call_pct
FROM callers
WHERE call_category='n/a' OR call_category='NULL'

---EX4:
select name from Customer
where referee_id is null or referee_id !=2

---EX5:
select survived,
sum(case when pclass=1 then 1 else 0 end) as first_class,
sum(case when pclass=2 then 1 else 0 end) as second_class,
sum(case when pclass=3 then 1 else 0 end) as third_class
from titanic
group by survived
