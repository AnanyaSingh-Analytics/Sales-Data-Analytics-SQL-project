-- Sales Analytics SQL Project
/* -- Objective: To simulate data analysis tasks for an agri-tech startup focusing on 
VLE performance, retail sales, inventory optimization, and farmer feedback.
*/
/* -- Data Source: Mock data created to resemble real rural sales and agri-business activities
 in UP districts.
*/
/*️ Tables Used:
 1. district : district name and id
 2. vle_data: Basic info about Village Level Entrepreneurs (VLEs)
 3. vle_sales: Product sales handled by VLEs
 4. inventory_stock: Current inventory levels in each district
 5. farmer_feedback: Ratings and comments from farmers
*/
-- creating and using databse
CREATE DATABASE Gramik_project;
USE Gramik_project;

-- Creating tables and inserting values
CREATE TABLE district (
    district_id INT PRIMARY KEY,
    district_name VARCHAR(100)
);

INSERT INTO district VALUES
(1, 'Lucknow'),
(2, 'Kanpur'),
(3, 'Varanasi'),
(4, 'Ayodhya'),
(5, 'Bareilly'),
(6, 'Gorakhpur'),
(7, 'Allahabad'),
(8, 'Noida'),
(9, 'Agra'),
(10, 'Jaunpur');

SELECT * FROM district;

CREATE TABLE vle_data (
    vle_id INT PRIMARY KEY,
    vle_name VARCHAR(100),
    district_id INT,
    joined_date DATE,
    FOREIGN KEY (district_id) REFERENCES district(district_id)
);

INSERT INTO vle_data VALUES
(101, 'Ravi Kumar', 1, '2021-05-10'),
(102, 'Sita Devi', 2, '2022-03-15'),
(103, 'Amit Singh', 3, '2023-01-20'),
(104, 'Geeta Patel', 4, '2021-07-25'),
(105, 'Deepak Yadav', 5, '2022-10-05'),
(106, 'Pooja Verma', 6, '2023-03-18'),
(107, 'Mukesh Sharma', 7, '2021-11-11'),
(108, 'Anjali Rana', 8, '2022-12-30'),
(109, 'Vikas Gupta', 9, '2023-06-08'),
(110, 'Neha Mishra', 10, '2021-09-17');

CREATE TABLE vle_sales (
    sale_id INT PRIMARY KEY,
    vle_id INT,
    product VARCHAR(50),
    sale_date DATE,
    quantity_kg DECIMAL(10,2),
    sale_price_per_kg DECIMAL(5,2),
    FOREIGN KEY (vle_id) REFERENCES vle_data(vle_id)
);
DROP TABLE vle_sales;
INSERT INTO vle_sales VALUES
(1, 101, 'Quality seed', '2023-01-10', 15.5,80.00),
(2, 102, 'Fertilizer', '2022-05-12', 10.0,90.00),
(3, 103, 'Agrochem', '2021-11-18', 5.5,60.00),
(4, 104, 'Fertilizer', '2023-03-22', 8.0,90.00),
(5, 105, 'Others', '2022-09-25', 12.5,50.00),
(6, 106, 'Agrochem', '2021-06-10', 9.0,60.00),
(7, 107, 'Quality seed', '2023-07-14', 20.0,80.00),
(8, 108, 'Fertilizer', '2022-01-05', 18.5,90.00),
(9, 109, 'Others', '2021-12-15', 6.0,50.00),
(10, 110, 'Agrochem', '2023-05-27', 11.0,60.00);


CREATE TABLE farmer_feedback (
    feedback_id INT PRIMARY KEY,
    district_id INT,
    rating DECIMAL(2,1),
    feedback_date DATE,
    FOREIGN KEY (district_id) REFERENCES district(district_id)
);

INSERT INTO farmer_feedback VALUES
(1, 1, 4.5, '2023-01-15'),
(2, 2, 3.0, '2022-05-16'),
(3, 3, 4.2, '2021-11-22'),
(4, 4, 2.8, '2023-03-26'),
(5, 5, 4.7, '2022-09-29'),
(6, 6, 3.5, '2021-06-14'),
(7, 7, 2.9, '2023-07-18'),
(8, 8, 4.8, '2022-01-10'),
(9, 9, 2.0, '2021-12-19'),
(10, 10, 3.6, '2023-06-01');

CREATE TABLE inventory_stock (
    stock_id INT PRIMARY KEY,
    district_id INT,
    product VARCHAR(50),
    stock_quantity_kg DECIMAL(10,2),
    stock_date DATE,
    FOREIGN KEY (district_id) REFERENCES district(district_id)
);
INSERT INTO inventory_stock VALUES
(1, 1, 'Quality seed', 500.00, '2023-01-05'),
(2, 2, 'Fertilizer', 300.00, '2022-05-10'),
(3, 3, 'Agrochem', 200.00, '2021-11-15'),
(4, 4, 'Fertilizer', 350.00, '2023-03-18'),
(5, 5, 'Others', 400.00, '2022-09-20'),
(6, 6, 'Agrochem', 250.00, '2021-06-08'),
(7, 7, 'Quality seed', 600.00, '2023-07-10'),
(8, 8, 'Fertilizer', 450.00, '2022-01-01'),
(9, 9, 'Others', 150.00, '2021-12-10'),
(10, 10, 'Agrochem', 375.00, '2023-05-22');


SHOW TABLES;
SELECT * FROM district;
SELECT * FROM vle_data; 
SELECT * FROM vle_sales;
SELECT * FROM inventory_stock;
SELECT * FROM farmer_feedback;

-- This project is divided into 3 sections answering : Foundational , Intermediate and lastly Advanced Level queries

-- FOUNDATIONAL LEVEL QUESTIONS
-- 1. Count of the number of VLE per district
SELECT d.district_name , COUNT(V.vle_id) AS Total_vle
FROM district d
JOIN vle_data V ON V.district_id = d.district_id
GROUP BY d.district_name;

-- 2. Total sales quantity for each product by VLEs
SELECT product, SUM(quantity_kg) AS total_sales
FROM vle_sales
GROUP BY Product;

-- 3.  Total stock per product available in inventory
SELECT product , SUM(stock_quantity_kg) AS Stock 
FROM inventory_stock
GROUP BY product;

-- 4.  Average feedback rating by district , give least 5
SELECT D.district_name , F.district_id , AVG(F.rating) AS AVG_Feedback_out_of_5
FROM district D
JOIN farmer_feedback F ON F.district_id = D.district_id
GROUP BY D.district_name , F.district_id;

-- 5. Which VLEs made no sales in the latest data of 1 year?

SELECT vle_id , vle_name
FROM vle_data
WHERe vle_id NOT IN (select 
						vle_id 
                        from vle_sales 
                        WHERE sale_date > '2022-12-31')
;

--  INTERMEDIATE LEVEL QUESTIONS

-- 6. Top Performing VLEs by Revenue in Each District
SELECT D.district_name , S.vle_id , SUM(S.quantity_kg * sale_price_per_kg) AS Revenue
FROM vle_sales S 
JOIN vle_data V ON V.vle_id = S.vle_id 
JOIN district D ON D.district_id = V.district_id
GROUP BY D.district_name , S.vle_id
ORDER BY Revenue DESC;

-- 7.  Products with Below-Average Inventory Across All VLEs
WITH inventory_avg AS (
  SELECT 
    product,
    AVG(stock_quantity_kg) AS avg_quantity
  FROM inventory_stock
  GROUP BY product
)
SELECT 
  V.vle_id,
  I.product,
  I.stock_quantity_kg,
  A.avg_quantity
FROM inventory_stock I
JOIN inventory_avg A ON I.product = A.product
JOIN vle_data V ON I.district_id = V.district_id
WHERE I.stock_quantity_kg < A.avg_quantity;

-- 8. Calculate month-over-month change in total quantity sold across all products.

WITH Monthly_sales AS (
  SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(quantity_kg) AS total_quantity
  FROM vle_sales
  GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)

SELECT 
  sale_month,
  total_quantity,
  LAG(total_quantity) OVER(ORDER BY sale_month) AS prev_month_quantity,
    (total_quantity - LAG(total_quantity) OVER(ORDER BY sale_month)) * 100
    / LAG(total_quantity) OVER(ORDER BY sale_month)
   AS percentage_change
FROM Monthly_sales;

-- 9. Which product category had the highest total sales quantity across all VLEs?
SELECT product , SUM(quantity_kg) AS total_quantity
FROM vle_sales
GROUP BY product 
ORDER BY SUM(quantity_kg) DESC
LIMIT 1
;

-- 10. Find the top 3 VLEs with the highest total sales value in each product category.
SELECT * 
FROM (SELECT 
		vle_id , 
		product , 
		SUM(quantity_kg* sale_price_per_kg) AS Total_sales ,
		RANK() OVER(PARTITION BY product ORDER BY SUM(quantity_kg* sale_price_per_kg) DESC) AS ranking
	  FROM vle_sales
      GROUP BY vle_id ,product  ) Sub
WHERE ranking <= 3
ORDER BY  product, ranking;

-- ADVANCED LEVEL QUESTION
-- 11. Find VLEs whose total sales value is in the top 25% but whose average feedback rating is below 3.
WITH  total_sales_CTE AS(
	SELECT 
		S.vle_id, V.vle_name,
        SUM(quantity_kg* sale_price_per_kg) AS total_sale,
        AVG(F.rating) AS avg_rating
	FROM vle_sales S
    JOIN vle_data V ON V.vle_id = S.vle_id
    JOIN farmer_feedback F ON F.district_id = V.district_id
    GROUP BY S.vle_id, V.vle_name
    ),
quartile_cte AS (
	SELECT * , NTILE(4) OVER(ORDER BY total_sale DESC) AS sale_quartile
    FROM total_sales_CTE)
SELECT vle_id , total_sale , avg_rating
FROM quartile_cte 
WHERE sale_quartile = 1 AND avg_rating < 3;

-- 12. Calculate Inventory Turnover Ratio for Each VLE 
 -- Inventory Turnover = Total Quantity Sold / Average Inventory Quantity
    
WITH SUM_AVG AS (
SELECT S.vle_id, SUM(S.quantity_kg) AS Total_Quantity_sold , AVG(I.stock_quantity_kg) AS AVG_inventory_quantity
FROM vle_sales S 
JOIN vle_data V ON V.vle_id = S.vle_id
JOIN  inventory_stock I ON I.district_id = V.District_id
GROUP BY S.vle_id)

SELECT 
	vle_id , Total_Quantity_sold, ROUND(AVG_inventory_quantity,2) AS avg_inventory ,
    ROUND(Total_Quantity_sold / AVG_inventory_quantity , 2) AS Inventory_turnover
FROM SUM_AVG;

-- 13. Trend of Sales Per Product Across Months with Cumulative Sales
-- Track monthly and cumulative sales quantity per product.
    
WITH monthly_sales AS (
    SELECT 
        product,
        DATE_FORMAT(sale_date, '%Y-%m') AS months,
        SUM(quantity_kg) AS monthly_sales
    FROM vle_sales
    GROUP BY product, DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT 
    product,
    months,
    monthly_sales,
    SUM(monthly_sales) OVER (PARTITION BY product ORDER BY months) AS cumulative_sales
FROM monthly_sales
ORDER BY product, months;


-- 14.  Detect Inventory Overstock Situations
-- List VLEs where average inventory quantity exceeds their average monthly sales.
WITH Inventory_sales AS(
	SELECT S.vle_id , DATE_FORMAT(S.sale_date, '%Y-%m') AS months ,AVG(I.stock_quantity_kg) AS Avg_inventory , AVG(S.quantity_kg * S.sale_price_per_kg) AS Avg_sale
	FROM vle_sales S 
	JOIN vle_data V ON V.vle_id = S.vle_id
	JOIN inventory_stock I ON I.district_id = V.district_id
	GROUP BY S.vle_id , DATE_FORMAT(S.sale_date, '%Y-%m'))
    
SELECT vle_id,months, Avg_inventory, Avg_sale
FROM Inventory_sales
WHERE Avg_inventory > Avg_sale;

-- 15. Identify Underperforming Products by District
/*Objective:
Find products in each district whose total sales (in kg) are below the 
district's average product sales. */
WITH SALES AS (
	SELECT 
		S.product ,
        D.district_name , 
        SUM(S.quantity_kg) AS total_sales 
	FROM vle_sales S
	JOIN vle_data V ON v.vle_id = S.vle_id
	JOIN district D ON D.district_id = V.district_id
	GROUP BY S.product , D.district_name) ,
    district_avg AS (
    SELECT 
		district_name,
        AVG(total_sales) AS District_avg
	FROM SALES 
    GROUP BY district_name)
    
SELECT S.product , S.district_name , S.total_sales , D.District_avg
FROM SALES S
JOIN district_avg D ON D.district_name = S.district_name
WHERE  S.total_sales < D.District_avg ;