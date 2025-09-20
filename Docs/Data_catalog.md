# Data Dictionary for Gold Layer
---

## OverView
---
The Gold layer contains business-ready, curated datasets that are aggregated, standardized, and optimized for analytics and reporting. 
Data in this layer is transformed into meaningful metrics and structured in a way 
that can be easily consumed by business users, data analysts, and BI tools such as Power BI or Tableau.
It consist of dimension tables and fact table.

---
### 1. Customer Dimension Table>> gold.dim_customers
 --**Purpose: It stores customers information that consist of their demographic and geographic data.
 --**The Columns are explained below. 
 - **Bronze Layer**: Raw data ingested from source systems with minimal transformation.  
- **Silver Layer**: Cleaned, standardized, and joined data ready for analysis.  
- **Gold Layer**: Curated, aggregated, business-ready data optimized for analytics and reporting.  

| Column Name    | Data Type   | Description                                                                                                    |
|----------------|-------------|----------------------------------------------------------------------------------------------------------------|
| customer_key   | INT         | Surrogate key generated using ROW_NUMBER for unique identification.                                            |
| customer_id    | INT         | Original customer ID from CRM system.                                                                          |
| customer_number| NVARCHAR(50)| Unique customer number from CRM.                                                                               |
| first_name     | NVARCHAR(50)| Customer’s first name.                                                                                         |
| last_name      | NVARCHAR(50)| Customer’s last name.                                                                                          |
| country        | NVARCHAR(50)| Customer’s country from ERP system, example: : 'Canada'                                                        |
| marital_status | NVARCHAR(50)| Customer’s marital status from CRM, for example: 'Married', 'Single'.                                          |
| gender         | NVARCHAR(50)| Customer’s gender (from CRM as master source, ERP as fallback if not found), example: 'Male', 'Female', 'N/A'. |
| birth_date     | DATE        | Customer’s birth date from ERP, formmated as YYYY-MM-DD.                                                       |
| create_date    | DATE        | Date the customer record was created in CRM.                                                                   |
---
### 2. Product Dimension Table>> gold.dim_products
 --**Purpose: It provides information about the products and their attributes
 --**The Columns are explained below.

| Column Name    | Data Type   | Description                                                                        |
|----------------|-------------|------------------------------------------------------------------------------------|
| product_key    | INT         | Surrogate key generated using ROW_NUMBER for unique identification.                |
| product_id     | INT         | Original product ID from CRM system.                                               |
| product_number | NVARCHAR(50)| Unique product number from CRM.                                                    |
| product_name   | NVARCHAR(50)| Name of the product.                                                               |
| category_id    | NVARCHAR(50)| Identifier for product category from CRM.                                          |
| category       | NVARCHAR(50)| Product category from ERP system.                                                  |
| sub_category   | NVARCHAR(50)| Product sub-category from ERP system.                                              |
| maintenance    | NVARCHAR(50)| Indicates if the product is under maintenance category.                            |
| product_cost   | NT          | Cost of the product.                                                               |
| product_line   | NVARCHAR(50)| Line or group the product belongs to.                                              |
| start_date     | DATE        | Start date of product availability (active products only, since end date is NULL). |
---
### 3. Sales Fact Table>> gold.fact_products
 --**Purpose: It stores transactional sales data for analytics
 --**The Columns are explained below.

| Column Name   | Data Type     | Description                                                                 |
|---------------|--------------|-----------------------------------------------------------------------------|
| order_number  | NVARCHAR(50) | Unique sales order number from CRM system.                                   |
| product_key   | INT          | Foreign key referencing Product Dimension (dim_products).                    |
| customer_key  | INT          | Foreign key referencing Customer Dimension (dim_customers).                  |
| order_date    | DATE         | Date when the sales order was created.                                       |
| shipping_date | DATE         | Date when the sales order was shipped.                                       |
| due_date      | DATE         | Due date for the sales order.                                                |
| sales         | INT          | Total sales amount for the order line.                                       |
| quantity      | INT          | Number of product units sold.                                                |
| price         | INT          | Unit price of the product at the time of sale.                               |
---











