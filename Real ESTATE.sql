create database realtor;
use realtor;
select * from agents;
select * from buyers;
select * from transactions;
select * from properties;
-- find the most popuar cities for property sales
select city,count(*) as num_sales from properties group by city order by num_sales desc limit 10;
-- top expensive property 
select property_id,address,city,price from properties order by price desc limit 10;
-- identify the top performing agent
select agent_id, count(property_id) as num_properties_sold,sum(price) as total_revenue from properties group by agent_id order by total_revenue desc;
-- total revenue generated from properties sales
select sum(sale_price) as revenue_generated from transactions;
-- How many properties were sold by each agent
select agent_id , count(property_id) as num_properties_sold from properties
group by agent_id
order by num_properties_sold desc;
-- AVERAGE PROPERTY SALE PRICE IN EACH CITY
select city , avg(price) as avg_sales_price from properties 
group by city order by avg_sales_price desc;
-- which buyer purchased multiple properties
select transactions.buyer_id ,count(property_id) as num_properties from transactions
join buyers on transactions.buyer_id = buyers.buyer_id
group by transactions.buyer_id
order by num_properties desc;
-- Highest priced property sold and who was the buyer
select properties.property_id,properties.address,properties.city,transactions.sale_price,
buyers.first_name as buyer_first,buyers.last_name as buyer_last
from properties
join transactions on properties.property_id = transactions.property_id
join buyers on transactions.buyer_id = buyers.buyer_id
order by transactions.sale_price desc
limit 1;
-- which agent had the highest total sales revenue
select agents.agent_id,agents.first_name,agents.last_name,sum(transactions.sale_price) as agent_total_revenue from agents
left join properties on agents.agent_id = properties.agent_id
left join transactions on properties.property_id = transactions.property_id
group by agents.agent_id,agents.first_name,agents.last_name
order by agent_total_revenue desc
limit 1
