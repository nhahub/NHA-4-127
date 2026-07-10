# 📊 Sales Performance Analysis using AdventureWorks2019

> An interactive Power BI dashboard designed to analyze sales performance using the AdventureWorks2019 database. The project transforms raw sales data into actionable business insights through SQL, Power Query, DAX, and interactive visualizations.

---

## 📌 Overview

This project analyzes sales data from the **AdventureWorks2019** database to help stakeholders monitor business performance, identify sales trends, evaluate profitability, and make data-driven decisions.

The data was extracted and prepared using **SQL Server**, transformed in **Power Query**, modeled in **Power BI**, and enhanced with **DAX measures** to build an interactive dashboard.

Unlike traditional multi-page reports, this solution uses a **single-page dashboard** with **Bookmark Navigation**, allowing users to seamlessly switch between **Sales**, **Quantity**, and **Profit** views while maintaining a clean and intuitive user experience.

---

## 🎯 Business Problem

Business stakeholders often struggle to monitor sales performance from multiple perspectives without navigating through several reports. They need a centralized dashboard that provides clear insights into:

- Overall sales performance
- Profitability
- Sales quantity
- Product performance
- Regional performance
- Customer metrics
- Monthly trends

The objective is to enable faster decision-making through an interactive and user-friendly analytical dashboard.

---

## 🎯 Project Objectives

- Analyze overall sales performance.
- Monitor profit and profit margin.
- Track product sales and quantities.
- Compare performance across sales territories.
- Identify the best-performing product categories.
- Analyze monthly performance trends.
- Build an interactive dashboard with dynamic navigation.
- Provide decision-makers with clear and actionable insights.

---

## 🛠 Tech Stack

- SQL Server
- SQL Server Management Studio (SSMS)
- Power BI Desktop
- Power Query
- DAX (Data Analysis Expressions)
- Git
- GitHub

---
## 🔄 Project Workflow

The project was completed through the following stages:

1. **Database Exploration**
   - Explored the AdventureWorks2019 database and identified the required tables.

2. **Data Preparation using SQL**
   - Cleaned and joined the required tables.
   - Created a unified SQL View (`vw_FactSalesAnalysis`) for reporting and analysis.

3. **Data Import into Power BI**
   - Imported the SQL View into Power BI Desktop.

4. **Data Transformation**
   - Performed additional data preparation using Power Query.
   - Created a Calendar table to support time-based analysis.

5. **Data Modeling**
   - Built relationships between tables.
   - Optimized the data model for reporting.

6. **DAX Measures**
   - Created business KPIs such as Sales, Profit, Quantity, Orders, Customers, Profit Margin, Average Order Value, YTD, MTD, and YoY Growth.

7. **Dashboard Development**
   - Designed a single-page interactive dashboard with Bookmark Navigation for Sales, Quantity, and Profit views.

---
## ✨ Dashboard Features

The dashboard includes the following interactive features:

- **Single-Page Dashboard** with Bookmark Navigation.
- **Dynamic Dashboard Title** that changes based on the selected view.
- **KPI Cards** displaying:
  - Total Sales
  - Total Profit
  - Average Order Value
  - Profit Margin
  - Total Orders
  - Total Customers
- **Territory Performance Analysis** using interactive bar charts.
- **Top 10 Products** visualization.
- **Category Performance** analysis.
- **Monthly Trend Analysis** using area charts.
- **Year** and **Color** slicers for dynamic filtering.
- **Cross-filtering** between visuals for interactive exploration.
- **Clear Filters** button to quickly reset all applied filters.

---
## 📷 Dashboard Preview

### Sales Dashboard

![Sales Dashboard](./Sales%20Performance%20Analysis/5_Images/Sales_Dashboard.png)

---

### Quantity Dashboard

![Quantity Dashboard](./Sales%20Performance%20Analysis/5_Images/Quantity_Dashboard.png)

---

### Profit Dashboard

![Profit Dashboard](./Sales%20Performance%20Analysis/5_Images/Profit_Dashboard.png)

---

## 📈 Key Insights

- Generated **$109.8M** in total sales.
- Achieved **$9.4M** in total profit with an **8.5% profit margin**.
- Processed over **31.5K orders** from **19.1K customers**.
- Bikes generated the highest profit among all product categories.
- Australia recorded the highest profit across all sales territories.
- The dashboard enables users to analyze Sales, Quantity, and Profit through interactive bookmark navigation.

---

## 📁 Project Structure

```text
Sales Performance Analysis/
│
├── README.md
│
├── 0_Data Source/
│   └── Source.text
│
├── 1_SQL/
│   ├── 01_Create_View.sql
│   ├── 02_Data_Validation.sql
│   └── 03_Business_Analysis.sql
│
├── 2_Python/
│   ├── 1_notebooks/
│   │   └── 01_Data_Validation_EDA.ipynb
│   │
│   └── 2_images/
│       └── requirements.txt
│
├── 3_Power BI/
│   └── Dashboard.pbix
│
├── 4_Presentation/
│
└── 5_Images/
    └── DataModel.png
```

## 🚀 How to Run

1. Restore the AdventureWorks2019 database in SQL Server.
2. Execute the SQL scripts to create the `vw_FactSalesAnalysis` view.
3. Open the Power BI `.pbix` file.
4. Update the SQL Server connection if required.
5. Refresh the data to load the latest records.
6. Explore the dashboard using the bookmarks and slicers.

---

## 👤 Author

**Nour**

- GitHub: https://github.com/nour-1928
- LinkedIn: https://www.linkedin.com/in/noureldeenmohammad

---