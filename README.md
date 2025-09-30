<h1>Project Summary: Python & SQL Data Pipeline</h1>



<h2>Description</h2>
The project focuses on building a functional pipeline to extract, transform, and load a retail sales dataset, followed by data analysis to answer key business questions.

<h2>Project walk-through</h2>

## Step 1 – Extraction

**Source:** Use the Kaggle API via Python to automatically download a raw E-Commerce retail orders dataset.

## Step 2 – Transformation in Python (Pandas)

**Clean Data:** Handle messy data, specifically treating values like "not available" and "unknown" as null values. 
**Standardize Data:** Clean and format column names (e.g., converting to lowercase and replacing spaces with underscores).  
**Feature Engineering:**  Create new analytical columns like discount, sale_price, and profit.

## Step 3 –  Loading to SQL
 <br />Connect to SQL Server using Python libraries like SQL Alchemy and load the cleaned, transformed data into a relational table. This involves ensuring proper data types are used in the destination table.<br />

## Step 4 – Analysis in SQL
- <b>Use SQL queries to solve five business intelligence questions</b>
- <b>Finding top revenue-generating products</b>
- <b>Month-over-month sales growth</b>
- <b>Identifying the highest-selling subcategories</b>
