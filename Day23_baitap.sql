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

5)
with cte as
(select customername,
current_date-max(orderdate) as R,
count(distinct ordernumber) as F,
sum(sales) as M
from public.sales_dataset_rfm_prj_clean
group by customername)
	
, cte2 as (select customername, 
ntile(5) over(order by R desc) as R_score,
ntile(5) over(order by F desc) as F_score,
ntile(5) over(order by M desc) as M_score
from cte)

,cte3 as 
(select customername,
cast(R_score as varchar)||cast(F_score as varchar)||cast(M_score as varchar) as RFM_score
from cte2)

,cte4 as 
(select a.customername, b.segment, a.RFM_score
from cte3 a
join segment_score b
on a.RFM_score=b.scores)

select segment, count(distinct customername) as count
from cte4
group by segment
order by count(distinct customername) desc
