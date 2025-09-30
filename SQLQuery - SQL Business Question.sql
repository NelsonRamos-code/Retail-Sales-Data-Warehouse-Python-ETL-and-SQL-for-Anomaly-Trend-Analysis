-- SQL BUSINESS QUESTIONS

--find top 10 highest revenue generating products 
SELECT TOP 10 product_id,SUM(sales_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY SUM(sales_price) DESC

--find top 5 highest selling products in each region
WITH cte AS(
SELECT product_id, SUM(sales_price) AS sales, region 
FROM df_orders
GROUP BY product_id, region)

SELECT * FROM(
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY region ORDER BY sales DESC) AS rn
FROM cte) A
WHERE rn <= 5


--find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
WITH cte1 AS(SELECT MONTH(order_date) AS month,
       YEAR(order_date) AS year,
       SUM(sales_price) AS sales
FROM df_orders
WHERE YEAR(order_date) IN ('2022','2023')
GROUP BY YEAR(order_date), MONTH(order_date)
)

SELECT month,
       SUM(CASE WHEN year = 2022 THEN sales else 0 END) AS sales_2022,
       SUM(CASE WHEN year = 2023 THEN sales else 0 END) AS sales_2023
FROM cte1
GROUP BY month
ORDER BY month

--for each category which month had highest sales 
WITH cte AS(
SELECT format(order_date, 'yyyyMM') as order_year_month, 
       SUM(sales_price) AS sales,
       category
FROM df_orders
GROUP BY category, format(order_date, 'yyyyMM') 
)

SELECT * FROM(
select *,
       ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) AS rn
FROM cte ) AS A
WHERE rn = 1


--which sub category had highest growth by profit in 2023 compare to 2022

WITH cte1 AS(SELECT sub_category,
       YEAR(order_date) AS year,
       SUM(sales_price) AS sales
FROM df_orders
WHERE YEAR(order_date) IN ('2022','2023')
GROUP BY sub_category, YEAR(order_date)
),
cte2 AS (    
SELECT sub_category,
       SUM(CASE WHEN year = 2022 THEN sales else 0 END) AS sales_2022,
       SUM(CASE WHEN year = 2023 THEN sales else 0 END) AS sales_2023
FROM cte1
GROUP BY sub_category) 

SELECT TOP 1 *,
       (sales_2023-sales_2022)*100/sales_2022 AS growth
FROM cte2
ORDER BY  (sales_2023-sales_2022)*100/sales_2022 DESC




