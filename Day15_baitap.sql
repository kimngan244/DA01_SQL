---ex1:
SELECT EXTRACT(year from transaction_date) as year,
product_id,
sum(spend) OVER(PARTITION BY product_id, transaction_date) as curr_year_spend,
lag(spend) OVER(PARTITION BY product_id) as prev_year_spend,
round(100*(((sum(spend) OVER(PARTITION BY product_id, transaction_date))-(lag(spend) OVER(PARTITION BY product_id)))/lag(spend) OVER(PARTITION BY product_id)),2) as yoy_rate
FROM user_transactions

---ex2:
SELECT DISTINCT card_name, 
first_value (issued_amount) OVER(PARTITION BY card_name order by issue_year, issue_month) as issued_amount
FROM monthly_cards_issued
order by issued_amount desc

---ex3:
with cte as
(SELECT *, 
row_number() OVER(PARTITION BY user_id ORDER BY transaction_date) as row_num
FROM transactions)
select user_id,spend,transaction_date from cte
where row_num=3

---ex4:
with cte as
(select product_id, transaction_date, user_id,
rank() over(PARTITION BY user_id ORDER BY transaction_date desc) as rank
from user_transactions)

select transaction_date, user_id, count(product_id) as purchase_count
from cte
WHERE rank=1
GROUP BY user_id,transaction_date
ORDER BY transaction_date

---ex6:
WITH cte as
(select merchant_id,credit_card_id,amount,transaction_timestamp,
lag(transaction_timestamp) over(PARTITION BY merchant_id,credit_card_id,amount) as previous_transaction_timestamp
from transactions)

select count(merchant_id) as payment_count
from cte
WHERE transaction_timestamp-previous_transaction_timestamp <= interval '10 minutes'

---ex7:
with cte as 
(SELECT category, product, sum(spend) as total_spend,
rank() over(PARTITION BY category ORDER BY sum(spend) desc) as spend_rank
from product_spend
where extract(year from transaction_date)=2022
group by category, product)

SELECT category, product, total_spend  
from cte
WHERE spend_rank<=2

---ex8:
with cte as
(SELECT artists.artist_name,
dense_rank() OVER(ORDER By count(songs.song_id) desc) as artist_rank
FROM artists
join songs on artists.artist_id=songs.artist_id	
join global_song_rank on songs.song_id=global_song_rank.song_id
where global_song_rank.rank<=10
group by artists.artist_name)

select artist_name, artist_rank
from cte
where artist_rank<=5

