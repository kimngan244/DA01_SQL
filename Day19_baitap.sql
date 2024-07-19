1)
ALTER TABLE sales_dataset_rfm_prj
ALTER column priceeach TYPE numeric USING (trim(priceeach)::numeric),
	
ALTER TABLE sales_dataset_rfm_prj
ALTER column sales TYPE numeric USING (trim(sales)::numeric)
	
SET datestyle='iso,mdy';
ALTER TABLE sales_dataset_rfm_prj
ALTER column orderdate TYPE date USING (trim(orderdate)::date)

ALTER TABLE sales_dataset_rfm_prj
ALTER column ordernumber TYPE numeric USING (trim(ordernumber)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER column quantityordered TYPE numeric USING (trim(quantityordered)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER column orderlinenumber TYPE numeric USING (trim(orderlinenumber)::numeric)

SELECT * FROM sales_dataset_rfm_prj

3)
---CONTACTLASTNAME
ALTER TABLE sales_dataset_rfm_prj
ADD column CONTACTLASTNAME Varchar
	
UPDATE sales_dataset_rfm_prj
SET CONTACTLASTNAME=SUBSTRING (contactfullname FROM (POSITION ('-' IN contactfullname)+1) FOR (LENGTH(contactfullname)-POSITION ('-' IN contactfullname)+1))
WHERE CONTACTLASTNAME=contactfullname
  
---CONTACTFIRSTNAME
ALTER TABLE sales_dataset_rfm_prj
ADD column CONTACTFIRSTNAME Varchar
	
UPDATE sales_dataset_rfm_prj
SET CONTACTFIRSTNAME=SUBSTRING (contactfullname FROM 1 FOR (POSITION ('-' IN contactfullname)-1)
WHERE CONTACTFIRSTNAME=contactfullname

4)
---QTR_ID
ALTER TABLE sales_dataset_rfm_prj
ADD column QTR_ID 

UPDATE sales_dataset_rfm_prj
SET QRT_ID=(SELECT case 
		when extract(month from ORDERDATE) in (1,2,3) then '1'
		when extract(month from ORDERDATE) in (4,5,6) then '2'
		when extract(month from ORDERDATE) in (7,8,9) then '3'
		else 4 END
	FROM sales_dataset_rfm_prj)

---MONTH_ID
ALTER TABLE sales_dataset_rfm_prj
ADD column MONTH_ID numeric

UPDATE sales_dataset_rfm_prj
SET MONTH_ID=(select extract(month from ORDERDATE) FROM sales_dataset_rfm_prj)

---YEAR_ID
ALTER TABLE sales_dataset_rfm_prj
ADD column YEAR_ID numeric

UPDATE sales_dataset_rfm_prj
SET YEAR_ID=(select extract(year from ORDERDATE) FROM sales_dataset_rfm_prj)

5)
---Cach 1: IQR
With cte as
(select Q1-1.5*IQR as min_value,
	   Q3+1.5*IQR as max_value	
FROM
(SELECT 
	percentile_cont(0.25) WITHIN GROUP(ORDER BY QUANTITYORDERED) as Q1,
	percentile_cont(0.75) WITHIN GROUP(ORDER BY QUANTITYORDERED) as Q3,
	percentile_cont(0.75) WITHIN GROUP(ORDER BY QUANTITYORDERED)-percentile_cont(0.25) WITHIN GROUP(ORDER BY QUANTITYORDERED) as IQR
FROM sales_dataset_rfm_prj) as a)

SELECT * FROM sales_dataset_rfm_prj
where quantityordered <(select min_value from cte)
or quantityordered >(select max_value from cte)

---Cach 2: Zscore
select avg(quantityordered), 
stddev(quantityordered)
from sales_dataset_rfm_prj

with cte as

(select orderdate, quantityordered,
		(select avg(quantityordered) from sales_dataset_rfm_prj) as avg, 
	   (select stddev(quantityordered) from sales_dataset_rfm_prj) as stddev 
		from sales_dataset_rfm_prj),
	
twt_outlier as (
	
select orderdate, quantityordered, (quantityordered-avg)/stddev as z-score
from cte
where abs((quantityordered-avg)/stddev)>3

UPDATE sales_dataset_rfm_prj
SET quantityordered=(select avg(quantityordered) from sales_dataset_rfm_prj)
WHERE quantityordered IN(SELECT quantityordered FROM twt_outlier)










