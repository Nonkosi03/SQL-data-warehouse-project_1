/*
==================================================
QUALITY CHECKS
==================================================
Script Purpose:
This script performs various quality checks for data consistency, accuracy, and standardization across
the 'silver layer' schemas. It also includes checks for:
    --Null or duplicate in Primary Keys
    --Unwanted Spaces in String values
    --Data Standardization and consistency
    --Invalid date ranges and orders(NB:: There are fileds that are older than the check date '1920-01-01'
    --Data consistency between related fields
=================================================
*/

--************************************************
-----Checking for: silver.crm_cust_info-----
--************************************************
---Check for Nulls OR Duplicates in Primary Key
---EXPECTATIONS: NO RESULTS
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 or cst_id IS NULL;

---Check for Unwanted Spaces in String Values
---EXPECTATIONS: NO RESULTS
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

---Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

--************************************************
-----CHECKING FOR: silver.crm_prd_info------
--************************************************
---Check for Null or Duplicates in Primary Key
---EXPECTATIONS: NO RESULTS
SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 or prd_id IS NULL;

---Check for Unwanted Spaces in String Values 
---EXPECTATIONS: NO RESULTS
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

---Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

---Check for Invalid Date Orders
SELECT * FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--************************************************
----CHECKING FOR: silver.crm_sales_details
--************************************************
---Check for invalid dates
---Expectation: No Invalid Dates
SELECT NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 OR LEN(sls_due_dt) != 8 OR sls_due_dt > 20500101 OR sls_due_dt < 19000101;

SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0;

---Check for Invalid Date orders (Order date> Shipping/Due Dates
SELECT * FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

---Check Data Consistency Between Sales, Quantity, and Price 
--->> Sales = Quantity * Price
--->> Values must not be Null, Zero or Negative
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

---RULES TO ENFORCE FOR THE ABOVE QUERY ARE:
--->> IF SALES IS NEGATIVE, ZERO, OR NULL, DERIVE IT USIG QUANTITY AND PRICE\
--->> IF PRICE IS ZERO OR NULL, CALCULATE IT USING SALES AND QUANTITY
--->> IF PRICE IS NEGATIVE, CONVERT IT TO A POSITIVE VALUE

--************************************************
----CHECKING FOR: silver.erp_cust_az12----
--************************************************
---Identify Out of Range Dates
---Expectation: Birthdates between 1920-01-01 and Today
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
where bdate < '1920-01-01' OR bdate > GETDATE();
--NB:::There are records that are older than 1920

---Data Standardization & Consistency
SELECT DISTINCT gen 
FROM silver.erp_cust_az12;

--************************************************
----CHECIKING FOR: silver.erp_loc_a101----
--************************************************
---Data Standardization & Consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

--************************************************
----CHECKING FOR: silver.erp_px_cat_g1v2----
--************************************************
---Check for Unwanted Spaces 
---EXPECTATION: NO RESULTS
SELECT * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

---Data Standardization
SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;

--************************************************
--************************************************
