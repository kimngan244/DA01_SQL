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






