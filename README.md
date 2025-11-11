# HR-Analysis

<details>
<summary><b>📚 Table of Contents</b></summary>

1. [Project Overview](#project-overview)  
2. [Data Source, Tools and Methodology](#data-source-tools-and-methodology)  
   - [Data Source](#data-source)  
   - [🧭 Methodology](#-methodology)  
3. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)  
4. [🧰 Data Analytics Tools & Techniques](#-data-analytics-tools--techniques)  
5. [Summarized Results](#summarized-results)  
   - [👥 Workforce Demographics](#-workforce-demographics)  
   - [🏢 Departmental Insights](#-departmental-insights)  
   - [🌍 Geographic & Location Insights](#-geographic--location-insights)  
6. [💡 Recommendations](#-recommendations)
7. [⚙️ Limitations](#-limitations) 
8. [🧠 Conclusion](#-conclusion)
9. [🧮 Selected SQL Queries](#-selected-sql-queries)  


</details>


## Project Overview


The goal of this analysis is to understand workforce distribution, diversity, and retention patterns across 
departments and by distinct distributions within the organization.
The dashboard enables HR and leadership teams to identify key demographic trends, 
high-turnover departments, and employee tenure insights 
that can drive strategic workforce planning, diversity improvement, and retention initiatives.

## Data Source, Tools and Methodology

### Data Source
The dataset used in this analysis is the HR_Data.csv file, containing detailed information on employees within the organization. Key attributes include:

Employee Information: Employee ID, Name (anonymized), Age, Gender
Organizational Data: Department, Job Title, Manager, Location, Employment Type, Hire Date
Compensation: Salary, Bonus
Work Metrics: Attendance Days, Leave Days, Performance Ratings, Training Completed, Tenure
HR Outcomes: Employment Status, Attrition Flag
This dataset provides a comprehensive view of the workforce and is suitable for analyzing employee demographics, performance, engagement, and retention trends. 
All sensitive information has been anonymized to maintain privacy.

## 🧭 Methodology  

1. **Data Cleaning (Excel)**  
   - Removed duplicates and corrected inconsistent entries.  
   - Handled missing values and standardized formats (e.g., dates, departments).  
   - Created new calculated columns like *Age_group* and *term_date*.  

2. **Data Processing & Analysis (SQL Server Management Studio)**  
   - Imported the cleaned dataset into **SQL Server**.  
   - Designed and populated HR tables.  
   - Wrote SQL queries to calculate KPIs 
   

3. **Visualization & Reporting (Power BI)**  
   - Connected Power BI to SQL Server for live data.  
   - Built interactive dashboards highlighting:  
     - Workforce composition by department and gender  
     - Attrition trends by tenure and department  
     - Salary distribution and performance correlation  

---

xploratory Data Analysis (EDA)

The EDA focused on understanding employee demographics, departmental structures, retention patterns, and diversity levels across the organization.  
Key steps included:

1. **Data Cleaning & Preparation**
   - Removed duplicates and nulls in employee and department datasets.  
   - Standardized column names and data types.  
   - Derived new columns (e.g., *Tenure Years*, *Termination Rate*, *Age Group*).

2. **Feature Engineering**
   - Calculated gender, race, and age distributions.  
   - Computed termination rates per department.  
   - Categorized employees into on-site vs remote roles.

3. **Exploratory Visualization**
   - Used Power BI for interactive dashboards.  
   - Plotted demographic breakdowns, tenure trends, and departmental KPIs.  
   - Analyzed employee distribution by state, location, and race.

---

## 🧰 Data Analytics Tools & Techniques

| Tool | Purpose |
|------|----------|
| **SQL Server Management Studio (SSMS)** | Data extraction, transformation, and KPI computation. |
| **Power BI** | Visualization of workforce demographics, tenure, and departmental insights. |
| **Excel / CSV Files** | Initial data review and structure validation. |
| **DAX & SQL Queries** | Used for aggregations, measures, and derived metrics. |

## Summarized Results

### 👥 Workforce Demographics
- **Average Tenure:** 10 years — strong retention across most departments.  
- **Gender Distribution:** Males (9.3K), Females (8.5K), Non-Conforming (0.5K).  
- **Age Distribution:**  
  - Majority between **25–54 years**, indicating mid-career dominance.  
  - Least represented: **18–24 years (0.9K)** → limited entry-level intake.  
- **Race Distribution:**  
  - Predominantly **White (5.2K)**.  
  - Black or African American and Two or More Races (3K each).  
  - Lower representation among Asian, Hispanic, and Native groups.

### 🏢 Departmental Insights
- **Highest Termination Rates:**  
  - Auditing (23.1%), Legal (20.3%), R&D (19.6%).  
- **Highest Average Tenure:**  
  - Sales (11.1 yrs), R&D (10.9 yrs), Support/Services (10.6 yrs).  
- **Gender by Department:**  
  - Engineering leads in headcount with balanced gender mix.  
  - Accounting & HR show female dominance; Legal & Auditing have low overall representation.

### 🌍 Geographic & Location Insights
- **Work Mode:** 75% On-Site vs 25% Remote.  
- **Top States:** Ohio, Michigan, and Wisconsin host most employees.  
- **Trend (2000–2020):** Stable workforce with slight fluctuations; peak growth in 2000 and 2018.

---

## 💡 Recommendations

### 1. 📈 Strengthen Retention
- Address high turnover in **Auditing, Legal, and R&D** through engagement and career growth programs.  
- Implement mentorship or rotation opportunities to boost satisfaction.

### 2. 🌍 Foster Diversity & Inclusion
- Recruit from underrepresented racial and gender groups.  
- Support diversity awareness and leadership mentoring initiatives.

### 3. 👩‍🎓 Enhance Entry-Level Recruitment
- Launch graduate and internship programs to increase the **18–24** age group share.  
- Partner with universities for early-career hiring.

### 4. 🌐 Expand Remote Flexibility
- Increase remote/hybrid roles to attract diverse talent beyond the headquarters region.  

### 5. 🧭 Optimize Geographic Presence
- Target hiring in underrepresented states to balance workforce distribution.  
- Explore cost-effective regions for expansion.

### 6. 🔍 Continuous Monitoring
- Track KPIs quarterly: tenure, termination, satisfaction, diversity metrics.  
- Use dashboards for HR performance transparency and strategic review.


## ⚙️ Limitations

1. **📅 Data Completeness**  
   Some employee records contained missing or incomplete hire and termination dates, which may slightly affect the accuracy of calculated tenure and turnover metrics.

2. **🌍 Geographic Representation**  
   The dataset is heavily concentrated in a few states (e.g., Ohio and Michigan), limiting the generalizability of insights across a broader or global workforce.

3. **📊 Limited Scope of Variables**  
   The analysis focuses mainly on demographics and tenure; it lacks qualitative factors such as employee satisfaction, performance ratings, or engagement feedback that could provide deeper insights into turnover causes.
✅ Tips for GitHub Markdown:

---

## 🧠 Conclusion
The analysis highlights a **mature, experienced, and balanced workforce** with consistent retention and tenure across departments.  
However, opportunities exist in **diversity, early-career hiring, and turnover reduction** in select departments.  
By leveraging **SQL** for data transformation and **Power BI** for analytics, HR leaders can make data-driven decisions to enhance **inclusion, retention, and workforce efficiency**.

---
## 🧮 Selected SQL Queries

### 🧱 1. Calculate Average Tenure by Department
```sql
SELECT 
    Department,
    ROUND(AVG(DATEDIFF(DAY, Hire_Date, ISNULL(Termination_Date, GETDATE())) / 365.0), 2) AS Avg_Tenure_Years
FROM Employees
GROUP BY Department
ORDER BY Avg_Tenure_Years DESC;
📈 2. Compute Departmental Termination Rate
sql
Copy code
SELECT 
    Department,
    ROUND(SUM(CASE WHEN Status = 'Terminated' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Termination_Rate
FROM Employees
GROUP BY Department
ORDER BY Termination_Rate DESC;
👩‍💼 3. Gender Distribution Summary
sql
Copy code
SELECT 
    Gender,
    COUNT(*) AS Employee_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Employees), 2) AS Percentage
FROM Employees
GROUP BY Gender
ORDER BY Employee_Count DESC;
🌍 4. Employee Distribution by Location Type
sql
Copy code
SELECT 
    Location_Type,
    COUNT(*) AS Number_of_Employees,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Employees), 2) AS Percentage
FROM Employees
GROUP BY Location_Type;
📊 5. Race Diversity Overview
sql
Copy code
SELECT 
    Race,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Race
ORDER BY Employee_Count DESC;
---
