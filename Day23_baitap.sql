1)
SELECT PRODUCTLINE, YEAR_ID, DEALSIZE,
sum(sales) as REVENUE	
FROM SALES_DATASET_RFM_PRJ_CLEAN
group by PRODUCTLINE, YEAR_ID, DEALSIZE
order by YEAR_ID, PRODUCTLINE,DEALSIZE

2)
with cte as
(select
year_id,MONTH_ID, 
sum(sales) as revenue
from public.sales_dataset_rfm_prj_clean
group by year_id,MONTH_ID
order by year_id,MONTH_ID)

select year_id,MONTH_ID,revenue,
rank() over(order by revenue desc) as rank
from cte

->Tháng 11 năm 2004, tháng 11 năm 2003, tháng 5 năm 2005

3)
select MONTH_ID, sales as revenue,productline, ORDERNUMBER, row_number() over(order by sales desc) as rank
from public.sales_dataset_rfm_prj_clean
where MONTH_ID=11

-> Vintage cars

4)
with cte as
(select YEAR_ID, PRODUCTLINE, COUNTRY, sum(SALES) as revenue
from public.sales_dataset_rfm_prj_clean
WHERE country='UK'
group by YEAR_ID, PRODUCTLINE,COUNTRY
order by YEAR_ID, PRODUCTLINE)
, cte2 as
(select YEAR_ID, PRODUCTLINE, revenue, rank() over(partition by year_id order by revenue desc) as rank
from cte)
select YEAR_ID, PRODUCTLINE, revenue, rank
from cte2
where rank=1
