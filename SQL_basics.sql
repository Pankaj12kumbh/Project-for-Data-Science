select * from customer

--Where CONDITION 

select * from Customer 
where state = 'SP'

--Order by condition
select * from Customer 
where state = 'SP'
order by CustomerId desc 

--Groupby
select country, count(1) from Customer 
group by Country 
order by count(1) desc

---Group by + HAVING 
select country, count(1) from Customer 
where country != 'Brazil'
group by Country 
having count(1) > 4
order by count(1) desc

--Upper/Lower
select * from customer 
where lower(country) = 'brazil'

---Like Operator
select * from Customer
where upper(FirstName) like 'D%N'

--vowels - a,e,i,o,u
SELECT * FROM Customer 
WHERE UPPER(FirstName) LIKE 'A%' 
or UPPER(FirstName) LIKE 'E%' 
or UPPER(FirstName) LIKE 'I%' 
or UPPER(FirstName) LIKE 'O%' 
or UPPER(FirstName) LIKE 'U%'

---Common Table Expression
with brl as (
	select * from customer 
where lower(country) = 'brazil' 
)
, usa as (
	select * from customer 
where lower(country) = 'usa'  
)
select * from usa

---Window Functions (rank, dense_rank, row_number, lead, lag, over, partition by)

with cte as (
	select customerid, sum(total) as total_invoice from Invoice 
	group by CustomerId 
	order by sum(Total) DESC 
)
--Rank of customerID based on total_invoice
select * from (
	select *, 
	ROW_NUMBER () over(order by total_invoice desc) as rnk
	from cte
) where rnk < 44

---Lead/Lag
with cte as (
	select customerid, sum(total) as total_invoice from Invoice 
	group by CustomerId 
	order by sum(Total) DESC 
)
--Rank of customerID based on total_invoice
select * from (
	select *, 
	lag(total_invoice,1,1) over(order by total_invoice desc) as pre_val, --(columnname, stepup/stepdown, defualt value)
	lag(total_invoice,4,1) over(order by total_invoice desc) as pre_val2,
	lead(total_invoice,1,1) over(order by total_invoice desc) as post_val
	from cte
)

--Joins (Left, Right, Inner, Outer)


select al.Title, al.ArtistId, ar.Name from Album al 
inner join Artist ar
on al.ArtistId = ar.ArtistId 



Select * from artist
