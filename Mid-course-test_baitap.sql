---Q1. 
select distinct min(replacement_cost)
from film

---Q2.
Query
select
case
  when replacement_cost between 9.99 and 19.99 then 'low'
  when replacement_cost between 20.00 and 24.99 then 'medium'
  else 'high'
end as category,
count(*)
from film
group by category
Answer: 154
select
count(case
  when replacement_cost between 9.99 and 19.99 then 1 end) 
from film

---Q3.
Query
select film.film_id, film.title as film_title, film.length, film_category.category_id, category.name as category_name
from film
join film_category on film.film_id=film_category.film_id
join category on film_category.category_id=category.category_id
where category.name='Sports' or category.name='Drama'
order by length desc
limit 1
Answer: Sports : 184
  
--- Q4.
select category.name, count(film.title) as title_count 
from film
join film_category on film.film_id=film_category.film_id
join category on film_category.category_id=category.category_id
group by category.name
order by title_count desc
limit 1
Answer: Sports :74 titles

---Q5.
select concat(actor.first_name,' ', actor.last_name) as name, 
	count(film_actor.film_id) as film_count
from actor
join film_actor on actor.actor_id=film_actor.actor_id
group by actor.first_name, actor.last_name
order by film_count desc
limit 1
Answer: Susan Davis : 54 movies

---Q6.
select address.address, customer.customer_id
from customer
left join address on customer.address_id=address.address_id
where address.address is null

---Q7.
select city.city, sum(payment.amount) as total_amount
from city
join address on city.city_id=address.city_id
join customer on address.address_id=customer.address_id
join payment on customer.customer_id=payment.customer_id
group by city.city
order by total_amount desc
limit 1
Answer: Cape Coral : 221.55

---Q8.
select city.city, country.country, sum(payment.amount) as total_amount
from city
join country on city.country_id=country.country_id
join address on city.city_id=address.city_id
join customer on address.address_id=customer.address_id
join payment on customer.customer_id=payment.customer_id
group by country.country, city.city
order by total_amount asc
limit 1
Answer: United States, Tallahassee : 50.85.
