
SELECT * FROM pizza_sales;

-- Total Revenue

SELECT SUM(total_price) as Total_Revenue from pizza_sales;

-- Average Total VALUE

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_value
FROM pizza_sales;

-- Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

-- Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

-- Daily Trend for Total Orders

SELECT 
	date_format(order_date, '%W') AS order_day,
    COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY date_format(order_date, '%W');

--  Hourly Trend for Orders

SELECT 
	hour(order_time) AS orders_huors,
	COUNT(DISTINCT order_id) AS total_roders
FROM pizza_sales
GROUP BY hour(order_time)
ORDER BY hour(order_time);

-- % of Sales by Pizza Category

SELECT 
	pizza_category,
    CAST(SUM(total_price)  AS DECIMAL(10, 2)) AS TOTAL_REVENUE,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Prec_Total
FROM pizza_sales
GROUP BY pizza_category;

-- % of Sales by Pizza Size

SELECT
	pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10, 2)) AS TOTAL_REVENUE,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10, 2)) AS pizaa_size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Total Pizzas Sold by Pizza Category

SELECT
	pizza_category,
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Top 5 Best Sellers by Total Pizzas Sold

SELECT 
	pizza_name,
    SUM(quantity) AS Total_Pizza_Slod
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Slod DESC
LIMIT 5;

-- Bottom 5 Best Sellers by Total Pizzas Sold

SELECT 
	pizza_name,
    SUM(quantity) AS Total_Pizza_Slod
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Slod ASC
LIMIT 5;
