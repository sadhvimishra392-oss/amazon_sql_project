USE amazon_project;
SELECT COUNT(*)
FROM amazon_sales_dataset;
SELECT *
FROM amazon_sales_dataset
LIMIT 10;
-- CHECK NULL
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS product_category_nulls,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_nulls,
    SUM(CASE WHEN quantity_sold IS NULL THEN 1 ELSE 0 END) AS quantity_sold_nulls,
    SUM(CASE WHEN customer_region IS NULL THEN 1 ELSE 0 END) AS customer_region_nulls,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS payment_method_nulls,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS rating_nulls,
    SUM(CASE WHEN total_revenue IS NULL THEN 1 ELSE 0 END) AS total_revenue_nulls
FROM amazon_sales_dataset;
-- CHECK DUPLICATES
SELECT order_id,
       COUNT(*) AS duplicate_count
FROM amazon_sales_dataset
GROUP BY order_id
HAVING COUNT(*) > 1;
-- TOTAL RECORDS
SELECT COUNT(*) AS total_records
FROM amazon_sales_dataset;
-- TOTAL REVENUE
SELECT SUM(Price)
FROM amazon_sales_dataset;
-- REVENUE BY CATEGORY
SELECT product_category,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY revenue DESC;
-- AVERAGE REVENUE PER ORDER
SELECT AVG(Price)
FROM amazon_sales_dataset;
-- TOTAL QUANTITY SOLD
SELECT SUM(Quantity_sold)
FROM amazon_sales_dataset;
-- TOP 10 PRODUCTS BY REVENUE
SELECT product_id,
	   SUM(Price) AS Revenue
FROM amazon_sales_dataset
GROUP BY product_id
ORDER BY Revenue DESC
LIMIT 10;
-- REVENUE REGION
SELECT customer_region,
	   SUM(Price) AS Revenue
FROM amazon_sales_dataset
GROUP BY customer_region
ORDER BY Revenue DESC;
-- PAYMENT METHOD ANALYSIS
SELECT payment_method,
       COUNT(*) AS total_orders
FROM amazon_sales_dataset
GROUP BY payment_method
ORDER BY total_orders DESC;
-- RATING ANALYSIS
SELECT rating,
	   COUNT(*) AS total_orders
FROM amazon_sales_dataset
GROUP BY rating
ORDER BY total_orders DESC;	
-- TOP PRODUCT
SELECT order_id,product_category,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY order_id,product_category
ORDER BY revenue DESC
LIMIT 10;
-- CATEGORY WISE RATING
SELECT product_category,
       ROUND(AVG(rating),2) AS avg_rating
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY avg_rating DESC;
-- REVENUE BY PAYMENT METHOD
SELECT payment_method,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY payment_method
ORDER BY revenue DESC;
-- AVERAGE DISCOUNT
SELECT product_category,
       ROUND(AVG(discount_percent),2) AS avg_discount
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY avg_discount DESC;
-- MONTHLY SALES TREND
SELECT MONTH(order_date) AS month_no,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY month_no
ORDER BY month_no;
-- PRODUCT REVENUE RANKING
SELECT product_id,product_category,
       SUM(total_revenue) AS revenue,
       RANK() OVER(ORDER BY SUM(total_revenue) DESC) AS product_rank
FROM amazon_sales_dataset
GROUP BY product_id,product_category;