/*
====================================================
DDL Scripts: Create Gold Views
====================================================
Scripts Purpose:
    This script creates views for the Gold Layer in the data warehouse.
    The Gold Layer represents the final dimension and fact tables (STAR SCHEMA)
    Each view performs transformation and combines data from Silver Layer to produce
    a clean, enriched, and business ready data

    These views can be used for analytical and reporting purposes.
====================================================
*/

-----BUILDING GOLD LAYER------------
----Integration
----*********************************************************
----CREATE DIMENSION FOR TABLE CUSTOMERS: gold.dim_customers
----*********************************************************
IF OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
	DROP VIEW gold.dim_customer;
CREATE VIEW gold.dim_customers AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
c1.cst_id AS customer_id,
c1.cst_key AS customer_number,
c1.cst_firstname AS first_name,
c1.cst_lastname AS last_name,
c3.cntry AS country,
c1.cst_marital_status AS marital_status,
CASE WHEN c1.cst_gndr != 'N/A' THEN c1.cst_gndr       ----CRM is the MASTER source for Gender Information
	 ELSE COALESCE(c2.gen, 'N/A')
END AS gender,
c2.bdate AS birth_date,
c1.cst_create_date AS create_date
FROM silver.crm_cust_info c1
LEFT JOIN silver.erp_cust_az12 c2
ON c1.cst_key = c2.cid 
LEFT JOIN silver.erp_loc_a101 c3
ON c1.cst_key = c3.cid;

----*******************************************************
----CREATE DIMENSION FOR TABLE PRODUCTS: gold.dim_products
----*******************************************************
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
CREATE VIEW gold.dim_products AS
SELECT
ROW_NUMBER() OVER (ORDER BY p1.prd_start_dt, p1.prd_key) AS product_key,
p1.prd_id AS product_id,
p1.prd_key AS product_number,
p1.prd_nm AS product_name,
p1.cat_id AS category_id,
p2.cat AS category,
p2.subcat AS sub_category,
p2.maintenance AS maintenance,
p1.prd_cost AS product_cost,
p1.prd_line AS product_line,
p1.prd_start_dt AS start_date
FROM silver.crm_prd_info p1
LEFT JOIN silver.erp_px_cat_g1v2 p2
ON p1.cat_id = p2.id
WHERE p1.prd_end_dt IS NULL;                   ---Filtering all Historical data

----*******************************************************
----CREATE FACT FOR TABLE SALES: gold.fact_sales
----*******************************************************
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
CREATE VIEW gold.fact_sales AS
SELECT 
s1.sls_ord_num AS order_number,
p.product_key AS product_key,
c.customer_key AS customer_key,
s1.sls_order_dt AS order_date,
s1.sls_ship_dt AS shipping_date,
s1.sls_due_dt AS due_date,
s1.sls_sales AS sales,
s1.sls_quantity AS quantity,
s1.sls_price AS price
FROM silver.crm_sales_details s1
LEFT JOIN gold.dim_products p
ON s1.sls_prd_key = p.product_number
LEFT JOIN gold.dim_customers c
ON s1.sls_cust_id = c.customer_id;
