# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository
This project demonstrates a comprehensive data warehousing and analytics solution, from bulding a datawarehouse to generating actionable insignts to help business with decision making process. This is designed a portfolio project in order to highlight industry's best practices in data engineering and analytics.

----
## Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![Data Architecture]

1. **Bronze Layer**: This stores raw data as it is from the source systems. Data is taken from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes i9n order to prepare the data for analysis.
3. **Gold Layer**: It houses business-ready data that is modeled into a star schema required for reporting and analytics.

---
## Project Overview

This project involves the following:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

---
## Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---
### BI: Analytics & Reporting (Data Analysis)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights will assits stakeholders with key business metrics, enabling strategic decision-making for the business.  

## Repository Structure
```
SQL_data-warehouse-project_1/
│
├── Datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── Docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file shows all different techniquies and methods of ETL
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── Scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── Tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
```
---
## About Me

Hi there! I'm **Nonkosi Kutyiswayo**. I am an Honours students in Information Sytems at the University of Johannesburg. This is my 1st project and I wanted to start with this one especiallyu using SQL because I enjoy working with SQL server and also to make it can be easy for me to learn other ways of Building a datawarehouse with a clue of how it is supposed to look like. 

Let's stay in touch! Feel free to connect with me on the following platform:
[![LinkedIn](https://www.linkedin.com/in/nonkosi-kutyiswayo-1b109a268/)


