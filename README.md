# Enterprise Workforce Productivity & Employee Attrition Analytics System

## 📌 Project Overview

The **Enterprise Workforce Productivity & Employee Attrition Analytics System** is an end-to-end HR Analytics project designed to analyze employee productivity, workforce performance, engagement, satisfaction, and employee attrition.

The project combines **Python, SQL, Excel, and Power BI** to transform raw employee data into meaningful business insights and interactive dashboards that can help HR teams make data-driven workforce decisions.

---

## 🎯 Business Objective

The main objective of this project is to understand:

* Employee attrition patterns
* Workforce productivity
* Employee engagement and satisfaction
* Department-wise performance
* Job satisfaction and career growth
* Work-life balance
* Employee demographics
* Factors associated with employee turnover
* High-risk employee segments
* Overall workforce trends

The analysis helps HR management identify potential attrition drivers and improve employee retention and workforce productivity.

---

## 🛠️ Technologies Used

| Technology           | Purpose                                        |
| -------------------- | ---------------------------------------------- |
| **Python**           | Data cleaning, analysis & statistical analysis |
| **Pandas**           | Data manipulation                              |
| **NumPy**            | Numerical analysis                             |
| **Matplotlib**       | Data visualization                             |
| **Seaborn**          | Exploratory data analysis                      |
| **SQL**              | Data querying and business analysis            |
| **Microsoft Excel**  | Data preparation and validation                |
| **Power BI**         | Interactive dashboards and KPI reporting       |
| **Jupyter Notebook** | Python-based analysis                          |

---

## 📂 Project Structure

```text
Enterprise-Workforce-Productivity-Employee-Attrition-Analytics/
│
├── Dataset/
│   └── Employee_Data.csv
│
├── Python/
│   └── Workforce_Attrition_Analysis.ipynb
│
├── SQL/
│   └── Workforce_Attrition_Analysis.sql
│
├── Excel/
│   └── Employee_Data.xlsx
│
├── PowerBI/
│   └── Workforce_Attrition_Analytics.pbix
│
├── Screenshots/
│   ├── Dashboard_1.png
│   ├── Dashboard_2.png
│   ├── Dashboard_3.png
│   ├── Dashboard_4.png
│   ├── Dashboard_5.png
│   └── Dashboard_6.png
│
└── README.md
```

---

# 🔄 Project Workflow

```text
Raw Employee Data
        ↓
Data Cleaning & Validation
        ↓
Exploratory Data Analysis
        ↓
Python Analysis
        ↓
SQL Business Analysis
        ↓
Excel Data Validation
        ↓
Power BI Data Modeling
        ↓
Interactive HR Dashboards
        ↓
Business Insights & Recommendations
```

---

# 🐍 Python Analysis

Python was used for data preparation, exploratory analysis, statistical analysis, and identifying relationships between workforce variables.

### Major Analysis Performed

* Data inspection
* Missing-value analysis
* Duplicate detection
* Data type validation
* Descriptive statistics
* Attrition analysis
* Department-wise analysis
* Employee satisfaction analysis
* Productivity analysis
* Correlation analysis
* Outlier analysis
* Employee segmentation
* Workforce trend analysis

### Libraries Used

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```

---

# 🗄️ SQL Analysis

SQL was used to perform structured business analysis and extract HR insights from employee data.

### Key SQL Analysis

* Total employees
* Active employees
* Attrition count
* Attrition rate
* Department-wise attrition
* Job-role analysis
* Average employee satisfaction
* Average performance rating
* Employee tenure analysis
* Salary analysis
* Overtime analysis
* Workforce segmentation

Example:

```sql
SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM Employee_Data
GROUP BY Department;
```

---

# 📊 Power BI Dashboard

The Power BI component converts the analytical results into an interactive HR analytics solution.

### Dashboard Areas

### 1. Workforce Overview

Provides a high-level overview of the workforce including:

* Total Employees
* Active Employees
* Attrition Count
* Attrition Rate
* Average Age
* Average Salary
* Department Distribution

### 2. Employee Attrition Analysis

Analyzes employee turnover using:

* Attrition Rate
* Department-wise Attrition
* Job Role-wise Attrition
* Age Group Analysis
* Gender Analysis
* Tenure Analysis
* Overtime Analysis

### 3. Workforce Productivity

Focuses on employee productivity and performance:

* Performance Rating
* Productivity indicators
* Department performance
* Job-role performance
* Employee workload
* Overtime patterns

### 4. Employee Engagement

Analyzes employee experience through:

* Engagement Score
* Job Satisfaction
* Manager Satisfaction
* Career Growth
* Work-Life Balance
* Department Engagement

### 5. Workforce Performance

Provides insights into:

* Performance ratings
* Department performance
* Employee productivity
* Experience
* Compensation
* Performance distribution

### 6. Attrition Risk & Insights

Identifies workforce segments that may have higher attrition risk using factors such as:

* Job satisfaction
* Work-life balance
* Overtime
* Tenure
* Compensation
* Career growth
* Employee engagement

---

# 📈 Key KPIs

The project tracks important HR KPIs such as:

* **Total Employees**
* **Active Employees**
* **Attrition Count**
* **Attrition Rate**
* **Average Employee Age**
* **Average Salary**
* **Average Job Satisfaction**
* **Average Performance Rating**
* **Average Engagement Score**
* **Average Work-Life Balance**
* **Average Career Growth Score**

---

# 🔍 Key Insights

The analysis focuses on identifying:

* Departments with comparatively higher employee attrition
* Employee groups with lower engagement
* Job roles with higher turnover
* Relationship between overtime and attrition
* Relationship between satisfaction and employee retention
* Impact of career growth on employee retention
* Workforce productivity patterns
* Employee performance trends
* Potential employee attrition-risk segments

---

# 💡 Business Recommendations

Based on the analysis, organizations can consider:

1. **Improve Employee Engagement**
   Develop targeted engagement programs for departments with lower engagement scores.

2. **Strengthen Career Growth Opportunities**
   Provide clearer career-development paths, training, and internal mobility.

3. **Monitor Overtime**
   Identify employees consistently working overtime and evaluate workload distribution.

4. **Improve Manager Support**
   Strengthen manager-employee communication and feedback mechanisms.

5. **Focus on High-Risk Employee Segments**
   Use workforce analytics to identify employees or groups showing multiple attrition-risk indicators.

6. **Improve Work-Life Balance**
   Introduce policies and workload-management practices that support sustainable productivity.

7. **Data-Driven HR Decision Making**
   Use the Power BI dashboard regularly to monitor workforce KPIs and identify changing trends.

---

# 📸 Dashboard Preview

Add your Power BI dashboard screenshots inside the `Screenshots` folder.

Example:

```markdown
## Dashboard 1 – Workforce Overview

![Workforce Overview](Screenshots/Dashboard_1.png)

## Dashboard 2 – Employee Attrition

![Employee Attrition](Screenshots/Dashboard_2.png)

## Dashboard 3 – Workforce Productivity

![Workforce Productivity](Screenshots/Dashboard_3.png)

## Dashboard 4 – Employee Engagement

![Employee Engagement](Screenshots/Dashboard_4.png)

## Dashboard 5 – Workforce Performance

![Workforce Performance](Screenshots/Dashboard_5.png)

## Dashboard 6 – Attrition Risk & Insights

![Attrition Risk](Screenshots/Dashboard_6.png)
```

---

# 🚀 Skills Demonstrated

This project demonstrates practical skills in:

* Data Cleaning
* Data Analysis
* Exploratory Data Analysis
* Statistical Analysis
* Correlation Analysis
* SQL
* Excel
* Python
* Pandas
* NumPy
* Data Visualization
* Power BI
* Dashboard Development
* KPI Development
* Business Intelligence
* HR Analytics
* Business Problem Solving
* Data-Driven Decision Making

---

# 👨‍💻 Project Type

**Domain:** Human Resources Analytics
**Project Type:** End-to-End Data Analytics Project
**Focus:** Workforce Productivity & Employee Attrition
**Tools:** Python | SQL | Excel | Power BI

---

# 📌 Conclusion

The **Enterprise Workforce Productivity & Employee Attrition Analytics System** demonstrates how multiple data analytics technologies can be integrated to solve real-world HR business problems.

The solution provides HR teams with a centralized analytical view of workforce productivity, employee engagement, performance, satisfaction, and attrition, enabling better workforce planning and data-driven decision-making.

---

## ⭐ Author

**Ashok Kamble**

**Data Analyst | Python | SQL | Excel | Power BI**

---

⭐ If you find this project useful, consider giving the repository a star!
