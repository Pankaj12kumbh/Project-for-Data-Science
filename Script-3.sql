--Joins
create table table1 (id int, name varchar);
create table table2 (id int, city varchar);
drop table table1 ;

insert into table1 values (1, 'Tea'),
(2, 'Coffee'),
(5, 'Flex Seeds')
;

insert into table2 values (1, 'Delhi'),
(1, 'Jaipur'),
(1, 'BLR'),
(2, 'Delhi'),
(2, 'Jaipur'),
(2, 'Hyderabad'),
(3, 'Bikaner'),
(4, 'Udaipur')
;

select * from table1 

select * from table2

select t2.id as ID2,t1.id as ID1, t1.name, t2.city
from table1 t1 full outer join table2 t2
on t1.id = t2.id


--- Self Join

create table emp_manager(emp_id int,emp_name varchar(50),salary int(20),manager_id int(10));
insert into emp_manager values(	1	,'Ankit',	10000	,4	),
(	2	,'Mohit',	15000	,5	),
(	3	,'Vikas',	10000	,4	),
(	4	,'Rohit',	5000	,2	),
(	5	,'Mudit',	12000	,6	),
(	6	,'Agam',	12000	,2	),
(	7	,'Sanjay',	9000	,2	),
(	8	,'Ashish',	5000	,2	);

select e1.*, e2.emp_name  from emp_manager e1 
left join emp_manager e2
on e1.manager_id = e2.emp_id 

---Partition by
create table revenue(geo varchar, region varchar, revenue int);
insert into revenue values('AMER','Global',20000),
('AMER','Federal',30000),
('AMER','SLED',40000),
('EMEA','CEMEA',33000),
('EMEA','SEMEA',44000),
('EMEA','LEMEA',42000),
('APAC','IND',50000),
('APAC','CHN',20000),
('APAC','HKG',40000)
;

select *
, rank() over (PARTITION by geo order by revenue desc) as rnk
,sum(revenue) over (partition by geo order by revenue desc) as cum_sum
,sum(revenue) over() as overall_sum
,sum(revenue) over(partition by geo) as overall_geo_sum
,sum(revenue) over(order by revenue desc) as cum_sum_val
from revenue 




---New and Repeat Customers
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,'2022-01-01',2000),(2,200,'2022-01-01',2500),(3,300,'2022-01-01',2100)
,(4,100,'2022-01-02',2000),(5,400,'2022-01-02' ,2200),(6,500,'2022-01-02',2700)
,(7,100,'2022-01-03',3000),(8,400,'2022-01-03',1000),(9,600,'2022-01-03',3000)
;

drop table customer_orders ;

select * from customer_orders

with cte as (
	select customer_id, min(order_date) as min_order_date from customer_orders 
	group by customer_id
	)
select 
	co.*
	, c.min_order_date
	, case when co.order_date = c.min_order_date then 'New Customer' else 'Repeat Customer' end as Cust_category
	---case when <column name> = <column_value> then 'Logic Value'
	--- when <column name> = <column_value> then 'Logic Value',
	--- when <column name> = <column_value> then 'Logic Value'
	--- else 'Another Logic Value' 
	--- end as <new_column_name>
from customer_orders co
	left join cte c
	on co.customer_id = c.customer_id



---Google question
create table users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

select * from users 

-- Distinct users who speaks english

select user_id, language from users 
where language in ('English')

--- Only those users which speak both language - English, German

select user_id from users 
where language in ('English','German')
group by user_id
having count(language) = 2

SELECT ADDDATE("2017-06-15", INTERVAL 10 DAY)

select now

t1 inner join t2
on t1.id = t2.id
inner join t3
on t2.name = t3.name
left join t4
on t3.product_id = t4.product_id