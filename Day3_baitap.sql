---ex1
select NAME from CITY
where COUNTRYCODE = 'USA' AND POPULATION >= 120000

---ex2
select * from CITY
where COUNTRYCODE = 'JPN'

---ex3
select CITY, STATE from STATION

---ex4
select CITY from STATION
where CITY LIKE 'a%' OR CITY LIKE 'i%' OR  CITY LIKE 'e%' OR  CITY LIKE 'o%' OR CITY LIKE 'u%'

---ex5
select distinct CITY from STATION
where CITY like '%a' OR CITY like '%e' OR CITY like '%i' OR CITY like '%o' OR CITY like '%u'

---ex6
select distinct CITY from STATION
where not (CITY LIKE 'a%' or (CITY LIKE 'i%' or  CITY LIKE 'e%' or CITY LIKE 'o%' or CITY LIKE 'u%'))

---ex7
select name from Employee
order by name asc

---ex8
select name from Employee
where (salary >2000 and months <10)
order by employee_id asc

---ex9
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y'

---ex10
select name from Customer
where referee_id is null or referee_id !=2

---ex11
select name, area, population from World
where area >=3000000 or population >=25000000

---ex12
select distinct author_id as 'id' from Views
where author_id = viewer_id
order by id asc

---ex13
SELECT part, assembly_step FROM parts_assembly
where finish_date is null

---ex14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary >=70000

---ex15
select advertising_channel from uber_advertising
where money_spent >100000 and year =2019





