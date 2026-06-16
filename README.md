# 📊 Case Study: TheLook eCommerce Data Analysis

### 📌 Project Overview
**TheLook** is a fictional eCommerce clothing site featuring a massive, highly detailed dataset provided by Google BigQuery. As a Data Analyst, my objective was to perform an end-to-end audit of the business's health. I analyzed macro revenue trends, evaluated product performance, built user cohorts to track retention, and uncovered major anomalies in the customer purchasing funnel.

**📊 Live Interactive Dashboard:** [View the Looker Studio Dashboard Here](https://datastudio.google.com/reporting/a4d08419-9994-4a56-8c89-f08bf666aad0)

### 🛠️ Data Architecture & Stack
- **Data Warehouse:** Google BigQuery
- **Languages Used:** Standard SQL (CTEs, Window Functions, Aggregations)
- **Visualization:** Looker Studio

---

## 🔍 Deep-Dive Analysis & Key Findings

### 📈 1. Macro Health & Month-over-Month (MoM) Growth
*(SQL Query: [`mom_revenue_growth.sql`](sql%20notes%20dashboard/mom_revenue_growth.sql))*

Before digging into specifics, I needed to know if the business was actually growing. I wrote an advanced query utilizing the `LAG()` window function to calculate the exact Month-over-Month revenue growth percentage.

| Month | Current Revenue | Previous Month Revenue | MoM Growth (%) |
| :--- | :--- | :--- | :--- |
| May 2019 | ₹1,906.47 | ₹1,670.17 | +14.15% |
| Apr 2019 | ₹1,670.17 | ₹739.59 | +125.82% |
| Mar 2019 | ₹739.59 | ₹528.78 | +39.87% |

**Actionable Insight:** The company experienced a massive surge in April (+125% growth) and sustained that momentum into May. The overall trajectory is incredibly healthy, indicating strong upper-funnel marketing acquisition.

### 👥 2. Customer Retention & Repeat Purchases
*(SQL Query: [`user_retention.sql`](sql%20notes%20dashboard/user_retention.sql))*

Acquiring customers is expensive; retaining them is where profit happens. I grouped the users into behavioral cohorts to see how many customers were returning to make a second or third purchase.

| Customer Type | Total Customers | % of Customer Base |
| :--- | :--- | :--- |
| New Customer (1 Order) | 45,120 | 68.5% |
| Returning Customer (2+ Orders) | 20,750 | 31.5% |

**Actionable Insight:** With nearly 70% of the customer base being "one-and-done" buyers, the business is heavily reliant on new acquisition. **Recommendation:** Implement a 30-day post-purchase email drip campaign offering a 10% discount to convert first-time buyers into loyal, returning customers.

### 🧥 3. Inventory Performance & Profit Leaks
*(SQL Query: [`products.sql`](sql%20notes%20dashboard/products.sql))*

Revenue doesn't equal profit. I joined the `order_items` and `products` tables to isolate the exact profit margins per category, and then ran a secondary query to find out where we were losing money to returns.

**Top Categories by Profit:**
1. Outerwear & Coats (₹183,554 Profit)
2. Jeans (₹146,248 Profit)

**The Return Rate Problem:**
I discovered that **"Clothing Sets" have an alarming 13% return rate**, followed closely by "Plus" sizes at 10.5%.
**Actionable Insight:** High return rates in specific sizing categories indicate a customer expectation mismatch. **Recommendation:** Audit the sizing charts on the website for Clothing Sets and Plus sizes, and encourage user reviews featuring customer height/weight to help future buyers pick the right size the first time.

### 🕵️‍♂️ 4. The Customer Funnel Anomaly
*(SQL Query: [`customer_funnel.sql`](sql%20notes%20dashboard/customer_funnel.sql))*

Finally, I mapped out the core user journey from the landing page to the checkout screen. 

| Action | Unique Users |
| :--- | :--- |
| Visited Home Page | 63,206 |
| Added to Cart | 80,151 |
| Made a Purchase | 80,151 |

**Actionable Insight:** This is a classic data anomaly. A 100% Cart-to-Purchase conversion rate combined with the fact that Purchasers exceed Home Page visitors tells a distinct technical story. 
Because this is a synthetic dataset, it proves the existence of a 1:1 backend data generation script (every purchase automatically generated a cart event). In a real-world scenario, this would indicate that thousands of users are bypassing the homepage entirely via external deep-links (landing directly on Product pages) and using a "Buy it Now" feature that instantly triggers a cart+purchase backend event.

---

### 📂 Repository Structure
All queries used to generate this case study are located in the `sql_queries/` folder. They feature modular CTEs, window functions, and clean formatting standard in modern data stacks.