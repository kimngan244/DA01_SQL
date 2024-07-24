---Tạo dataset như mô tả

with cte as (
select format_date('%Y-%m',b.created_at) as month_year,
sum(b.sale_price) as TPV,
count(b.order_id) as TPO,
sum(a.cost) as Total_cost
from bigquery-public-data.thelook_ecommerce.products a
join bigquery-public-data.thelook_ecommerce.order_items b
on a.id=b.id
group by 1
order by 1
)
,
cte2 as
(select *,
TPV-Total_cost as Total_profit,
(TPV-Total_cost)/Total_cost as Profit_to_cost_ratio,
lag(TPV,1) over(order by month_year) as pre_TPV,
lag(TPO,1) over(order by month_year) as pre_TPO
from cte
order by month_year)
,
cte3 as
(select 
month_year,
TPV,
TPO,
round(100.00*((TPV-pre_TPV)/pre_TPV),2)||'%' as Revenue_growth,
round(100.00*((TPO-pre_TPO)/pre_TPO),2)||'%' as Order_growth,
Total_cost,Total_profit,Profit_to_cost_ratio
from cte2
order by 1)
select * from cte3

  2) Cohort_customer
 ---Có 181420 bản ghi
---Check duplicate
with cte as (select 
row_number() over(partition by id,order_id, user_id,product_id order by created_at) as stt
from bigquery-public-data.thelook_ecommerce.order_items)
select * from cte
where stt >1

--- Customer_cohort
with cte as
(select user_id,
min(created_at) over(partition by user_id) as first_purchase_date,
created_at,
sale_price
from bigquery-public-data.thelook_ecommerce.order_items)

, cte2 as (select 
user_id, sale_price,
format_date('%Y-%m',first_purchase_date) as cohort_date,
created_at,
((extract(year from created_at) - extract(year from first_purchase_date))*12 ) + (extract(month from created_at) - extract(month from first_purchase_date))+1 as index
from cte)

,cte3 as(select cohort_date,
index,
count(distinct user_id) as count,
sum(sale_price) as revenue
from cte2
group by cohort_date, index)

,cte4 as
(select cohort_date,
sum(case when index=1 then count else 0 end) as m1,
sum(case when index=2 then count else 0 end) as m2,
sum(case when index=3 then count else 0 end) as m3,
sum(case when index=4 then count else 0 end) as m4
from cte3
group by cohort_date
order by cohort_date)

select cohort_date,
round((100.00*(m1/m1)),2)||'%' as m1,
round((100.00*(m2/m1)),2)||'%' as m2,
round((100.00*(m3/m1)),2)||'%' as m3,
round((100.00*(m4/m1)),2)||'%' as m4
from cte4




