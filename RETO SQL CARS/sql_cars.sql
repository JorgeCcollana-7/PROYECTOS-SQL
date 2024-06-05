#--1.¿Cuáles son los detalles de todos los coches vendidos en el año 2023?
select * from cars c join sales s on c.car_id=s.car_id where purchase_date BETWEEN "2023-01-01" and "2023-12-31";

#--2.¿Cuál es la cantidad total de autos vendidos por cada vendedor?
select  sp.name, COUNT(s.car_id) from salespersons sp join sales s on sp.salesman_id=s.salesman_id GROUP BY sp.name;
select  sp.name, COUNT(s.car_id) as cantidad from salespersons sp join sales s using(salesman_id) GROUP BY sp.name;

#--3.¿Cuál es el ingreso total generado por cada tipo de automóvil? Utilice la columna cost_$
select SUM(c.cost_$) as ingreso, c.type from cars c GROUP BY c.type;

#--4.Muestre el detalle de los autos vendidos en el año 2022 por el vendedor Tom Lee
select c.*,sp.name,s.purchase_date from cars c join sales s on c.car_id=s.car_id join salespersons sp on s.salesman_id=sp.salesman_id where s.purchase_date BETWEEN "2022-01-01" and "2022-12-31" and name="Tom Lee" 

#5.¿Cuál es el nombre y ciudad del vendedor que vendió la mayor cantidad de autos en el año 2023?
select sp.name, sp.city, COUNT(s.car_id) as cantidad, s.purchase_date from salespersons sp join sales s on sp.salesman_id=s.salesman_id 
where s.purchase_date BETWEEN "2023-01-01" and "2023-12-31" GROUP BY sp.name order by 3 DESC;

WITH max_vendedor as(
SELECT sp.salesman_id, count(s.car_id) as cantidad, sp.name, sp.city
from sales s 
join salespersons sp
on s.salesman_id = sp.salesman_id 
where extract(year from s.purchase_date) = 2023
group by 1,3,4
order by 2 desc  
limit 1)
SELECT name, city
from max_vendedor

#-6.¿Cuál es el nombre y la edad del vendedor que generó mayores ingresos en el año 2022?
select sp.name,sp.age, SUM(c.cost_$) as ingresos, s.purchase_date from salespersons sp join sales s on sp.salesman_id=s.salesman_id join cars c on 
s.car_id=c.car_id 
where s.purchase_date BETWEEN "2022-01-01" and "2022-12-31" GROUP BY sp.name, 2 ORDER BY 3 desc;

with max_vendedor_ingresos as (
select sp.name, sp.age, sum(cost_$) as cantidad
from sales s 
join salespersons sp
on s.salesman_id = sp.salesman_id 
join cars c 
on c.car_id = s.car_id
where extract(year from s.purchase_date) = 2022
group by 1,2
order by 3 desc  
limit 1)
select name, age, cantidad
from max_vendedor_ingresos