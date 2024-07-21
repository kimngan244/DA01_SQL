---1. Số lượng đơn hàng và số lượng khách hàng mỗi tháng
select 
concat(extract(year FROM created_at),'-',extract(month FROM created_at)) as month_year,
count(distinct order_id) as total_order,
count(distinct user_id) as total_user
from bigquery-public-data.thelook_ecommerce.orders
where concat(extract(year FROM created_at),'-',extract(month FROM created_at)) between '2019-1' and '2022-4'
group by 1
order by 1
Insight: Tổng số lượng người mua và số lượng đơn hàng đã hoàn thành mỗi tháng ( Từ 1/2019-4/2022)
Số lượng người mua và số lượng đơn hàng tăng vào cuối năm, giảm vào đầu năm sau rồi tăng vào cuối năm

---2. Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
select 
concat(extract(year FROM created_at),'-',extract(month FROM created_at)) as month_year,
sum(sale_price)/count(distinct order_id) as average_order_value,
count(distinct user_id) as distinct_users
from bigquery-public-data.thelook_ecommerce.order_items
where concat(extract(year FROM created_at),'-',extract(month FROM created_at)) between '2019-1' and '2022-4'
group by 1
order by 1
Insight: Giá trị đơn hàng trung bình và số lượng khách hàng mỗi tháng tăng vào cuối năm, giảm vào đầu năm sau rồi tăng vào cuối năm

---3. Nhóm khách hàng theo độ tuổi
with cte as
((select 
concat(extract(year FROM created_at),'-',extract(month FROM created_at)) as month_year,
first_name,last_name, age,gender,
from bigquery-public-data.thelook_ecommerce.users
where concat(extract(year FROM created_at),'-',extract(month FROM created_at)) between '2019-1' and '2022-4'
AND gender='M'
order by 1)

UNION ALL

(select 
concat(extract(year FROM created_at),'-',extract(month FROM created_at)) as month_year,
first_name,last_name, age,gender,
from bigquery-public-data.thelook_ecommerce.users
where concat(extract(year FROM created_at),'-',extract(month FROM created_at)) between '2019-1' and '2022-4'
AND gender='F'
order by 1))
  
select * FROM cte

---4.Top 5 sản phẩm mỗi tháng.
  
with cte as
(SELECT 
concat(extract(year FROM b.created_at),'-',extract(month FROM b.created_at)) as month_year,
a.name, a.cost, b.product_id, b.sale_price as sales,
b.sale_price-a.cost as profit
FROM bigquery-public-data.thelook_ecommerce.products a
join bigquery-public-data.thelook_ecommerce.order_items b
on a.id=b.id
order by b.created_at)
, cte2 as
(select *,
dense_rank() over (partition by month_year order by profit) as rank_per_month
from cte)
select * from cte2
where rank_per_month<=5

---5. Doanh thu tính đến thời điểm hiện tại trên mỗi danh mục
















