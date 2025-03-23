# TABLE
Select * from pizza_sales;

# TOTAL REVENUE
select sum(total_price) As Total_Revenue
from pizza_sales;

#Total Orders
select count(*) As Orders
from pizza_sales;

#Total Distinct Orders
select count(Distinct order_id) As Orders
from pizza_sales;

# Pizza Categories
select distinct pizza_category from pizza_sales;

# Total Pizza Sold
Select sum(quantity) AS Total_Pizza_Sold
from pizza_sales;

# Distinct Order ID
select distinct order_id from pizza_sales;

# Average Order Value
select sum(total_price) /  count(distinct order_id) As Average_Order_Value
from pizza_sales;

# Average Pizza Per Order
select sum(quantity)  / count(distinct order_id) As Average_Pizza_Per_Order
from pizza_sales;

# Total Orders
select order_date as Order_Day , Count(Distinct order_id) As Total_Orders
from pizza_sales
group by order_date ;

# Total Orders Count
Select count(*)
from pizza_sales;

# Total Pizza Sold On Each Category
select distinct pizza_category , sum(quantity)
from pizza_sales
group by pizza_category;

# Daily Trend for Total Orders
select dayname(STR_TO_DATE(order_date,'%d-%m-%Y')) as Order_day , count(Distinct order_id) as Total_Orders
from pizza_sales
where order_date is not null
group by Order_day
order by field( Order_Day ,'Sunday' , 'Monday' , 'Tuesday' , 'Wednesday' , 'Thursday' ,'Friday' , 'Saturday');

# Hourly Trend for Total Orders
select hour(order_time) , count(Distinct order_id) as Total_Orders
from pizza_sales
where order_time is not null
group by hour(order_time)
order by hour(order_time);

# Monthly Trend for Total Orders
select date_format(STR_TO_DATE(order_date ,'%d-%m-%Y') , '%M') As Order_Month , count(Distinct order_id) as Total_Orders ,
Month(str_to_date(order_date , '%d-%m-%Y')) As Month_Number
from pizza_sales
where order_date is not null
group by Order_Month , Month_Number
order by  Month_Number;

# Most Sold Pizza On Week End
select pizza_category, sum(quantity) AS Total_Sold
FROM pizza_sales
where DAYNAME(STR_TO_DATE(order_date,'%d-%m-%Y')) in ('Saturday', 'Sunday')
group by pizza_category
order by Total_Sold desc;

# Month That Has the Highest Pizza Sold 
select date_format(STR_TO_DATE(order_date ,'%d-%m-%Y') , '%M') As Order_Month , count(Distinct order_id) as Total_Orders ,
Month(str_to_date(order_date , '%d-%m-%Y')) As Month_Number
from pizza_sales
where order_date is not null
group by Order_Month , Month_Number
order by  Total_Orders desc
limit 1;

# Revenue Based On Each Pizza
select pizza_name, round(sum(total_price)) AS Total_Revenue, 
round((sum(total_price) * 100) / (select sum(total_price) from pizza_sales))  AS Revenue_Percentage
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

# Percentage of Sales Based On Pizza Category
SELECT pizza_category , sum(total_price) As Total_Sales ,sum(total_price) * 100 / (select sum(total_price)
from pizza_sales 
where month(str_to_date(order_date ,'%d-%m-%Y'))  = 9) As Percentage_Of_Sales
from pizza_sales
where month(str_to_date(order_date ,'%d-%m-%Y'))  = 9
group by pizza_category;

# Percentage of Sales Based on Pizza Size
select pizza_size , sum(total_price) As Total_Sales ,sum(total_price) * 100 / (select sum(total_price)
from pizza_sales) As Percent_Of_Sales
from pizza_sales
group by pizza_size
order by Percent_Of_Sales;

# Total Pizza Sold Based On Pizza Category
select pizza_category ,sum(quantity) As Total_Sold 
from pizza_sales
group by pizza_category;

# Best Pizza
select  pizza_name , sum(quantity) As Total_Sold
from pizza_sales
group by pizza_name
Order by Total_Sold Desc
LIMIT 5;

# Worst Pizza
select  pizza_name , sum(quantity) As Total_Sold
from pizza_sales
group by pizza_name
Order by Total_Sold
LIMIT 5;
  
# Whether Most Pizza Sold In Week Days Or Week Ends
select case when dayname(str_to_date(order_date,'%d-%m-%Y')) in ('Saturday', 'Sunday') then 'Weekend'
else 'Weekday' 
end as Order_Type, 
count(distinct order_id) as Total_Orders
from pizza_sales
group by Order_Type;

# In Each Category the Most Sold Pizza
select pizza_category, pizza_name, SUM(quantity) AS Total_Sold
from pizza_sales
group by pizza_category, pizza_name
order by pizza_category, Total_Sold desc;

# Peak Order Hour
select hour(order_time) as Order_Hour, count(order_id) as Total_Orders
from pizza_sales
group by Order_Hour
order by Total_Orders desc
limit 1;

# Highest Revenue Generated Day
select order_date, round(sum(total_price)) as Total_Revenue
from pizza_sales
group by order_date
order by Total_Revenue desc
limit 1;






