---ex1:
with job_count_cte as

(SELECT company_id, title, description, count(job_id) AS job_count
FROM job_listings
group by company_id, title, description)

select count(DISTINCT company_id) from job_count_cte
where job_count>1

---ex2:
SELECT category, product, sum(spend) as total_spend
FROM product_spend
where extract(year from transaction_date)=2022
group by category, product
ORDER BY total_spend DESC

---ex3:
with caseid_count_cte as
(SELECT policy_holder_id, count(case_id) as caseid_count
FROM callers
group by policy_holder_id)
select count(policy_holder_id) as policy_holder_count
from caseid_count_cte
where caseid_count>=3

---ex4:
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes
on pages.page_id=page_likes.page_id
WHERE page_likes.liked_date is NULL
ORDER BY pages.page_id ASC

---ex5:
select EXTRACT(month from event_date), count(DISTINCT user_id)
from user_actions
where user_id in (select distinct user_id 
from user_actions 
where EXTRACT(month from event_date)=6)
and EXTRACT(month from event_date)=7
group by EXTRACT(month from event_date)

---ex6:
select substring(trans_date from 1 for 7) as month, country, 
count(id)as trans_count, 
sum(case when state='approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount, 
sum(case when state='approved' then amount else 0 end) as approved_total_amount
from Transactions
group by month, country

---ex7:
with cte as

(select product_id, min(year) as first_year
from Sales
group by product_id)

select Sales.quantity, Sales.price, cte.product_id, cte.first_year
from Sales
inner join cte
on Sales.product_id=cte.product_id
and Sales.year=cte.first_year

---ex8:
WITH CTE1 AS 
(SELECT COUNT(*) AS product_count
FROM Product),

CTE2 AS 
(SELECT customer_id, COUNT(DISTINCT product_key) AS customer_product_count
FROM Customer
GROUP BY customer_id)
    
SELECT customer_id
FROM CTE1, CTE2
WHERE customer_product_count=product_count

---ex9:
select employee_id 
from Employees
where salary<30000 and manager_id not in (select employee_id from Employees)
order by employee_id

---ex10:
with job_count_cte as

(SELECT company_id, title, description, count(job_id) AS job_count
FROM job_listings
group by company_id, title, description)

select count(DISTINCT company_id) from job_count_cte
where job_count>1

---ex11:
Question1.
with cte as
(select Movies.movie_id, Movies.title, MovieRating.user_id, MovieRating.rating
from Movies
join MovieRating 
on Movies.movie_id=MovieRating.movie_id)
select cte.title, Users.name
from cte
join Users
on cte.user_id=Users.user_id
order by cte.rating desc
limit 1

Question2.
with cte as
(select Movies.movie_id, Movies.title, MovieRating.user_id, MovieRating.rating, MovieRating.created_at
from Movies
join MovieRating 
on Movies.movie_id=MovieRating.movie_id)
select cte.title, Users.name
from cte
join Users
on cte.user_id=Users.user_id
where month(created_at)=2
order by cte.rating desc
limit 1

---ex12:
with cte as
((select accepter_id as id, 
count(*) as num 
from RequestAccepted
group by accepter_id)

UNION ALL

(select requester_id as id, 
count(*) as num 
from RequestAccepted
group by requester_id))

select id, sum(num) as num 
from cte
group by id
order by num desc 
limit 1



