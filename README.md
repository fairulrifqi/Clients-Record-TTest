# Clients-Record-TTest

# 📄 README – SQL Query Usage Guide

This project is prepared for a **technical test for the Data Analyst position at Mandiri Sekuritas**.  
It demonstrates the use of SQL to analyze client transaction behavior, card usage, and financial risk levels using three provided datasets.

---

## 🧠 Overview

The SQL queries analyze and summarize data from the following tables:

- `transactions_data`
- `users_data`
- `cards_data`

These were joined and cleaned to produce a new summarized table called **`clients_record_data`**, combining selected information from all three sources for each client.

---

## 🔍 What the Queries Do

1. **Preview Tables**  
   Show the first 10 rows of each table for quick inspection.

2. **Transaction Insights**
   - Total amount transacted per client  
   - Number of transactions per merchant city  
   - Merchant and client distribution across states

3. **Card Analysis**
   - Card counts and credit limits per client  
   - Cards opened per month  
   - First open date per client

4. **User Financial Profiles**
   - Identify users with more debt than income  
   - Select users with credit scores above the average

5. **Final Aggregated Table (`clients_record_data`)**
   - Combines transactions, user, and card data  
   - Calculates total and average transaction amounts  
   - Captures card usage, credit score, income, and risk level per client  
   - Classifies clients into **Low Risk** or **High Risk** based on credit score (threshold = 650)

---

## ⚙️ How to Use

- Ensure all three source tables are available in your SQL environment.  
- Run the queries in order or individually, depending on your analysis needs.  
- Currency fields (`amount`, `credit_limit`, `yearly_income`) are stored as text and converted to numeric during processing.  
- Use the final query to generate the `clients_record_data` table for further exploration.

---

## 📁 Data & Dashboard Access

- **Google Drive Folder (Data & Docs)**  
  [Access here](https://drive.google.com/drive/folders/1OxA-EaAzESfIIhCVD8whrdGgcPIaTF5n?usp=drive_link)

- **Looker Studio Dashboard (Interactive Report)**  
  [View Dashboard](https://lookerstudio.google.com/reporting/165ba107-2d05-4cc7-9a25-ffb4c0309507)

---

## ✅ Use Cases

- Credit risk assessment  
- Client profiling and segmentation  
- Behavioral trend analysis  
- Executive reporting and dashboards
