/*
==================================================
QUALITY CHECKS FOR GOLD LAYER
==================================================
Script Purpose:
This script performs various quality checks for data integrity, accuracy, and consistency across
the 'Gold layer' schemas. It also includes checks for:
    --Uniqueness of the surrogate keys in the dimension tables
    --Referential integrity between fact and dimension tables
    --Validation of relationships in the data model for analytical purposes
=================================================
*/

----*********************************************************
----CHECK QUALITY FOR TABLE CUSTOMERS: gold.dim_customers
----*********************************************************
--Check for uniqueness of Customer Key in gold.dim_customers
--Expectation: No Results
SELECT customer_key, COUNT(*) AS count_duplicates
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

----*********************************************************
----CHECK QUALITY FOR TABLE PRODUCTS: gold.dim_products
----*********************************************************
--Check for uniqueness of Product Key in gold.dim_products
--Expectation: No Results
SELECT product_key, COUNT(*) AS count_duplicates
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

----*********************************************************
----CHECK QUALITY FOR TABLE PRODUCTS: gold.dim_products
----*********************************************************
--Check for the data model connectivity between the fact and dimension views
--Foreign integrity check
--Expectation: No Results
SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
on c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL;

----*********************************************************
----*********************************************************
