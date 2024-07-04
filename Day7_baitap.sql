---ex1:
select Name 
from STUDENTS
WHERE Marks >75
order by right(Name,3),ID

---ex2:
select user_id,
concat(upper(left(name,1)),lower(right(name,length(name)-1))) as name
from Users
order by user_id

---ex3:
SELECT manufacturer, concat('$',round(sum(total_sales)/1000000,0),' ','million') as sale
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) desc

---ex4:
SELECT extract(month from submit_date) as mth, product_id, round(avg(stars),2) as avg_stars 
FROM reviews
group by mth, product_id
order by mth, product_id

---ex5:
SELECT sender_id, count(message_id) as message_count
from messages
where extract(month from sent_date)=8 and extract(year from sent_date)=2022
group by sender_id
order by message_count desc
limit 2

---ex6:
select tweet_id from Tweets
where length(content)

---ex8:
select count(id) as number_employee
from employees
where extract(year from joining_date)=2022 and extract(month from joining_date) between 1 and 7

---ex9:
select position('a' in first_name) from worker
where first_name='Amitah'

---ex10:
select substring(title, length(winery)+2,4)
from winemag_p2
where country='Macedonia'
