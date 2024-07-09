---ex1:
SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION))
FROM COUNTRY
INNER JOIN CITY
ON COUNTRY.CODE=CITY.COUNTRYCODE
GROUP BY COUNTRY.CONTINENT

---ex2:
SELECT
round(count(texts.email_id)*1.0/count(DISTINCT emails.email_id),2) as confirm_rate
FROM emails
left join texts
on emails.email_id=texts.email_id
and texts.signup_action='Confirmed'

---ex3:
SELECT age.age_bucket,
round(100.0*(sum(case when activities.activity_type='send' then time_spent end)/sum(activities.time_spent)),2) as send_perc,
round(100.0*(sum(case when activities.activity_type='open' then time_spent end)/sum(activities.time_spent)),2) as open_perc
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket

---ex4:
SELECT customer_contracts.customer_id
FROM customer_contracts
INNER JOIN products
ON customer_contracts.product_id=products.product_id
GROUP BY customer_contracts.customer_id

---ex5:
select mng.employee_id, mng.name, count(emp.employee_id) as reports_count, round(avg(emp.age)) as average_age
from Employees emp
join Employees mng
on emp.reports_to=mng.employee_id
group by employee_id
order by employee_id

---ex6:
select Products.product_name, sum(Orders.unit) as unit
from Products
inner join Orders
on Products.product_id=Orders.product_id
where month(order_date)=02 and year(order_date)=2020
group by Products.product_name
having sum(Orders.unit)>=100

---ex7:
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes
on pages.page_id=page_likes.page_id
WHERE page_likes.liked_date is NULL
ORDER BY pages.page_id ASC
