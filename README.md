# 🛒 TheLook eCommerce: End-to-End Data Analysis

## 📌 Project Overview
This project analyzes the sales, product performance, and user behavior of **TheLook**, a fictional eCommerce clothing site. The goal is to identify revenue trends, pinpoint where users drop off in the purchasing funnel, and recommend actionable strategies to improve profitability.

---

## 🏗️ Data Architecture & Tools
- **Database:** Google BigQuery (Public Dataset)
- **Languages:** Standard SQL

---

## 🔍 Key Business Questions & Findings

### 1. Macro Health: Revenue & Order Trends
* **Query:** [`revenue_order.sql`](sql%20notes%20dashboard/revenue_order.sql)
* **Goal:** Calculate monthly order volume, total revenue, and average order value (AOV) for completed transactions.

#### 📊 Query Output (2019 Snapshot)
| order_month | total_orders | total_revenue | average_order_value |
| :--- | :--- | :--- | :--- |
| 2019-01-01 | 3 | $329.97 | $109.99 |
| 2019-02-01 | 7 | $528.78 | $75.54 |
| 2019-03-01 | 7 | $739.59 | $105.66 |
| 2019-04-01 | 13 | $1,670.17 | $128.47 |
| 2019-05-01 | 21 | $1,906.47 | $90.78 |

*Finding:* Consistent month-over-month growth in total orders and revenue throughout early 2019, while Average Order Value (AOV) fluctuates between $75 and $128.

### 2. Inventory: Product Category Performance
* **Query:** [`products.sql`](sql%20notes%20dashboard/products.sql)
* **Goal:** Identify the Top 5 Product categories by total profit, total revenue, and average retail price.

#### 📊 Query Output (Top 5 Categories)
| category | revenue | avg_retail_price | profit |
| :--- | :--- | :--- | :--- |
| Outerwear & Coats | $331,073.49 | $149.27 | $183,554.17 |
| Jeans | $313,829.25 | $97.04 | $146,248.92 |
| Sweaters | $201,565.42 | $73.97 | $104,353.67 |
| Swim | $166,008.77 | $56.89 | $81,737.49 |
| Suits & Sport Coats | $161,670.98 | $122.02 | $96,282.19 |

*Finding:* "Outerwear & Coats" is the biggest driver for both top-line revenue and bottom-line profit, heavily influenced by its high average retail price ($149.27).

---

## 🛠️ Repository Structure
1. `sql_queries/`: Contains all the SQL scripts used to extract and transform the data.