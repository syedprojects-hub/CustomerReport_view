# Customer Analytics View (`customer_report`)

## Project Overview

This project creates a SQL analytical view named **`customer_report`** designed to consolidate and evaluate customer behavior using transactional sales data.
The view brings together customer demographics, purchase behavior, revenue contribution, lifecycle duration, and customer segmentation to enable deeper customer insights across the business.

---

## Business Objective

Organizations need a reliable and automated way to understand their customers’ value, engagement levels, and purchasing behavior.
Manually calculating metrics such as lifetime revenue, order history, product diversity, or recency is time-consuming and error-prone.

The **`customer_report`** view solves this by delivering a **Customer360 analytical layer** that supports:

* customer segmentation
* churn and recency analysis
* marketing strategy
* customer value prediction
* cross-sell/upsell planning

---

## Methodology

1. **Data Integration**
   Joined `sales` and `customers` tables using `customer_key` to form a unified dataset.

2. **Data Cleaning**
   Filtered out invalid order records by ensuring `order_date` is present.

3. **Customer-Level Aggregation**
   Computed key metrics such as total purchases, lifetime sales, product diversity, and order activity windows.

4. **Lifecycle Metrics**
   Measured customer lifespan based on first and last purchase months.

5. **Segmentation Logic**
   Built segmentation rules to classify customers by age group and customer lifecycle value (VIP, Regular, New).

6. **KPI Calculations**
   Calculated revenue-based metrics including average order value and average monthly spending.

---

## Key Metrics

### **Behavioral Metrics**

* **total_orders** – Number of unique orders placed
* **total_sales** – Total revenue contributed
* **total_quantity** – Total items purchased
* **total_products** – Number of distinct products bought

### **Lifecycle Metrics**

* **lifespan** – Months between first and last purchase
* **last_order_date** – Most recent transaction
* **recency** – Months since the last purchase

### **Demographic Metrics**

* **age** – Real-time age of the customer
* **age_group** – Under 20, Young (20–39), Old (40+)

### **Performance Metrics**

* **avg_order_value** – Revenue per order
* **avg_monthly_spend** – Average spend across active months
* **customer_group** – VIP, Regular, or New

---

## SQL Highlights

* Used **CTEs** (`base_query`, `customer_aggregation`) for clarity and modularity.
* Joined **sales** and **customer** datasets to create a unified analytics layer.
* Applied **TIMESTAMPDIFF**, date logic, and conditional segmentation with `CASE WHEN`.
* Calculated KPI-grade metrics such as AOV and monthly spend.
* Ensured data robustness by filtering invalid orders and controlling division errors.

---

## Results and Impact

* Provides a **single source of truth** for customer behavior and segmentation.
* Enables **churn prediction**, **marketing targeting**, and **lifetime value analysis**.
* Reduces repetitive analytical work by offering a ready-made customer insights layer.
* Supports BI dashboards for customer profiling, retention, and sales strategy.
* Helps identify **top customers**, **new customers**, **returning customers**, and **VIP segments**.

---

## Skills Demonstrated

SQL Data Engineering • Analytical Modeling • CTEs • Customer Segmentation • KPI Design
MySQL Functions • Business Analytics • Reporting Automation • Data Warehousing Concepts

---

## Next Steps

1. Integrate with BI tools (Power BI, Tableau, Looker) for visualization.
2. Automate refresh by embedding this view in ETL pipelines.
3. Add **RFM scoring (Recency, Frequency, Monetary)** for deeper segmentation.
4. Combine with `products_report` for joint product–customer profitability analysis.
5. Extend model to calculate **Customer Lifetime Value (LTV)** and churn probability.
---
