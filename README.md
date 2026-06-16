# Case Study: TheLook eCommerce Data Analysis

### Project Overview
TheLook is a fictional eCommerce clothing retailer. This case study presents an end-to-end data audit of the store's operations using public BigQuery datasets. The analysis focuses on macro revenue trends, customer purchasing profiles, product category profit margins, and event-tracking funnel integrity.

**Interactive Dashboard:** [Looker Studio Dashboard](https://datastudio.google.com/reporting/a4d08419-9994-4a56-8c89-f08bf666aad0)

### Data Stack
- **Data Warehouse:** Google BigQuery
- **Languages Used:** Standard SQL (Common Table Expressions, Window Functions, Aggregations)
- **Visualization:** Looker Studio

---

## Deep-Dive Analysis & Key Findings

### 1. Macro Health & Month-over-Month (MoM) Growth
*(SQL Query: [mom_revenue_growth.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/mom_revenue_growth.sql))*

To evaluate high-level business growth, monthly revenue was calculated alongside Month-over-Month growth rates using the `LAG()` window function. 

Rather than focusing on early-stage launch data from 2019 (where extremely low volumes caused high percentage fluctuations, such as a +18.17% growth in April 2019 resulting from a small increase from 11 to 12 orders), the table below highlights mature-phase performance from early 2026.

| Month | Current Revenue | Previous Month Revenue | MoM Growth (%) |
| :--- | :--- | :--- | :--- |
| May 2026 | ₹129,058.48 | ₹108,889.22 | +18.52% |
| Apr 2026 | ₹108,889.22 | ₹95,500.74 | +14.02% |
| Mar 2026 | ₹95,500.74 | ₹91,603.80 | +4.25% |
| Feb 2026 | ₹91,603.80 | ₹83,019.42 | +10.34% |
| Jan 2026 | ₹83,019.42 | ₹81,213.19 | +2.22% |

**Analysis:**
The mature-phase performance shows a steady upward trend in monthly revenue, growing from ₹83,019.42 in January to ₹129,058.48 in May 2026. This range of growth (2.22% to 18.52%) represents a stabilizing storefront. Focusing on these mature timelines provides a more reliable foundation for sales and inventory planning than early-stage launch volatility.

---

### 2. New vs. Returning Customer Split
*(SQL Query: [user_retention.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/user_retention.sql))*

Understanding customer repurchase rates is critical for assessing customer lifetime value and acquisition costs. This section profiles the distribution of first-time versus repeat purchasers across the entire completed transaction history (27,470 total unique customers).

| Customer Type | Total Customers | % of Customer Base |
| :--- | :--- | :--- |
| New Customer (1 Order) | 24,215 | 88.15% |
| Returning Customer (2+ Orders) | 3,255 | 11.85% |

**Analysis:**
With 88.15% of the customer base placing only one order, the business exhibits a heavy reliance on initial customer acquisition. High single-purchase rates put constant upward pressure on Customer Acquisition Cost (CAC). 
**Recommendation:** Implement automated email marketing flows (such as post-purchase check-ins and secondary product recommendations within 30 days) and loyalty incentives to encourage first-time buyers to place a second order.

---

### 3. Inventory Performance & Return Margins
*(SQL Query: [products.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/products.sql))*

Net profits and return rates were analyzed by joining the `order_items` and `products` tables. This enables the business to isolate top-margin categories and identify profit leaks.

**Top Categories by Profit:**
1. Outerwear & Coats (₹183,554 net profit, all-time)
2. Jeans (₹146,248 net profit, all-time)

**Category Return Rates:**
- **Clothing Sets:** 13.00% return rate
- **Plus Sizes:** 10.50% return rate

**Analysis:**
Outerwear and Jeans represent the primary profit drivers for the storefront. Conversely, Clothing Sets and Plus Sizes experience elevated return rates of 13.00% and 10.50% respectively. Sizing and fit inconsistencies are the primary drivers of returns in eCommerce apparel.
**Recommendation:** Perform a sizing audit for products in these two categories. Displaying clearer size guides, comparison tables, and user-generated fit feedback (e.g., "fits true to size", "fits small") on product detail pages can help align customer expectations and reduce return volumes.

---

### 4. Customer Funnel Integrity Audit
*(SQL Query: [customer_funnel.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/customer_funnel.sql))*

The user journey was mapped from homepage visits to checkout events to evaluate funnel health and identify potential tracking anomalies.

| Funnel Event | Unique Users |
| :--- | :--- |
| Visited Home Page | 63,206 |
| Added to Cart | 80,151 |
| Completed Purchase | 80,151 |

> [!NOTE]
> **Data Scope Clarification:** 
> The customer count in the repeat-purchase analysis (27,470 total customers) is sourced from the `orders` table filtered strictly for completed transactions (`status = 'Complete'`). Conversely, the customer funnel analysis tracks raw user sessions in the unfiltered `events` table (80,151 purchasers). These numbers come from different systems and tables and are not expected to tie out, as the web events log captures all checkout actions regardless of downstream transaction status.

**Analysis:**
The funnel metrics reveal a clear anomaly: the number of unique users who added items to their cart (80,151) is identical to the number who completed a purchase (80,151), and both metrics exceed homepage visits (63,206). 

In a production web analytics setup, this pattern would suggest:
1. **Instrumentation Errors:** An event tracking bug where cart actions and purchase completions are tied together on a single click or script, or a double-firing of tracking pixels.
2. **Direct Product Entry:** Traffic arriving directly on product detail pages from external referral links, search ads, or social media campaigns, bypassing the homepage entirely and checking out immediately.

In this context, it represents a data generation artifact in the synthetic public dataset, where cart and purchase events are generated in a strict 1:1 ratio. Conducting validation audits of this type is a necessary step to confirm data quality before performing deeper business analysis.

---

### Repository Structure
All queries used to generate this case study are located in the [sql_queries/](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries) directory:
- [mom_revenue_growth.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/mom_revenue_growth.sql): Calculates monthly MoM growth using window functions.
- [user_retention.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/user_retention.sql): Measures the distribution of new versus returning buyers.
- [products.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/products.sql): Evaluates profit margins and return rates by product category.
- [customer_funnel.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/customer_funnel.sql): Maps user events to identify tracking anomalies.
- [revenue_order.sql](file:///d:/thelook%20ecommerce%20analysis/thelook-ecommerce-analysis/sql_queries/revenue_order.sql): Tracks high-level order volume, AOV, and revenue.