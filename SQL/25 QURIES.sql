CREATE DATABASE workforce_analytics;

USE workforce_analytics;

SELECT 
    COUNT(*) AS Total_Employees
FROM
    Employees;

SELECT 
    Employment_Status, COUNT(*) AS Employee_Count
FROM
    Employees
GROUP BY Employment_Status;

SELECT 
    *
FROM
    Employees
LIMIT 5;

CREATE TABLE Attendance (
    Attendance_ID VARCHAR(20) PRIMARY KEY,
    Employee_ID VARCHAR(20),
    Date DATE,
    Status VARCHAR(30),
    Work_Hours DECIMAL(5,2),
    Overtime_Hours DECIMAL(5,2),
    Late_Minutes INT,
    Remote_Work VARCHAR(30)
);

SELECT COUNT(*) AS Total_Attendance_Records
FROM Attendance;

SELECT *
FROM Attendance
LIMIT 5;

SELECT Status, COUNT(*) AS Record_Count
FROM Attendance
GROUP BY Status;

CREATE TABLE Performance (
    Review_ID VARCHAR(20) PRIMARY KEY,
    Employee_ID VARCHAR(20),
    Review_Date DATE,
    Performance_Score DECIMAL(5,2),
    Productivity_Score DECIMAL(5,2),
    Quality_Score DECIMAL(5,2),
    Manager_Rating DECIMAL(5,2),
    Target_Achievement DECIMAL(6,2),
    Promotion_Eligible VARCHAR(20)
);

SELECT COUNT(*) AS Total_Performance_Recods
FROM Performance;

SELECT 
    *
FROM
    Performance
LIMIT 10;

SELECT 
	Promotion_Eligible,
    COUNT(*) AS Employee_Count
FROM Performance 
GROUP BY Promotion_Eligible;

CREATE TABLE Employee_Engagement (
    Employee_ID VARCHAR(20),
    Survey_Date DATE,
    Job_Satisfaction DECIMAL(5,2),
    Work_Life_Balance DECIMAL(5,2),
    Manager_Satisfaction DECIMAL(5,2),
    Career_Growth DECIMAL(5,2),
    Environment_Satisfaction DECIMAL(5,2),
    Engagement_Score DECIMAL(5,2)
);

SELECT COUNT(*) AS Total_Engagement_Records
FROM Employee_Engagement;

SELECT *
FROM Employee_Engagement
LIMIT 5;

SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Employee_ID) AS Unique_Employees
FROM Employee_Engagement;

SELECT
    COUNT(*) AS Total_Employees
FROM Employees;

SELECT
    Employment_Status,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Employment_Status
ORDER BY Employee_Count DESC;

SELECT
    Department,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Department
ORDER BY Employee_Count DESC;

------------------ Query 1 Total Employees ------------------------------------
SELECT
    COUNT(*) AS Total_Employees
FROM Employees;

------------------- Query 2 Active vs Exited  ------------------------------------
SELECT
    Employment_Status,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Employment_Status
ORDER BY Employee_Count DESC;

------------------- Query 3 Department-wise Employee Count  --------------------------------------

SELECT 
	Department,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Department
ORDER BY Employee_Count DESC;

----------------------- Query 4 Average Salary by Department -------------------------

SELECT 
    Department,
    COUNT(*) AS Employee_Count,
    ROUND(AVG(Salary), 2) AS Average_Salary
FROM
    Employees
GROUP BY Department
ORDER BY Average_Salary DESC;

--------------------- Query 5 Highest Paid Employee -----------------------

SELECT 
    Employee_ID, Employee_Name, Department, Designation, Salary
FROM
    Employees
ORDER BY Salary DESC
LIMIT 10;

-------------------- Query 6 Lowest Paid Employee ----------------------------

SELECT 
    Employee_ID, Employee_Name, Department, Designation, Salary
FROM
    Employees
ORDER BY Salary ASC
LIMIT 10;

------------------------ Query 7 Active Employees By Department -------------------------------------

SELECT
    Department,
    COUNT(*) AS Active_Employees
FROM Employees
WHERE Employment_Status = 'Active'
GROUP BY Department
ORDER BY Active_Employees DESC;

------------------------- Query 8 	Department-wise Attrition -------------------------------------------------

SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE
        WHEN Employment_Status = 'Exited' THEN 1
        ELSE 0
    END) AS Exited_Employees,
    ROUND(SUM(CASE
                WHEN Employment_Status = 'Exited' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS Attrition_Rate
FROM
    Employees
GROUP BY Department
ORDER BY Attrition_Rate DESC;

------------------------ Query 9 Departments with High Attrition ----------------------------------------------

SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE
        WHEN Employment_Status = 'Exited' THEN 1
        ELSE 0
    END) AS Exited_Employees,
    ROUND(SUM(CASE
                WHEN Employment_Status = 'Exited' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS Attrition_Rate
FROM
    Employees
GROUP BY Department
HAVING Attrition_Rate > 20
ORDER BY Attrition_Rate DESC;

------------------------ Query 10 -------------------------------------------------------------

SELECT 
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    e.Salary,
    ROUND(d.Avg_Department_Salary, 2) AS Avg_Department_Salary
FROM
    Employees e
        JOIN
    (SELECT 
        Department, AVG(Salary) AS Avg_Department_Salary
    FROM
        Employees
    GROUP BY Department) d ON e.Department = d.Department
ORDER BY e.Salary DESC
LIMIT 10;

-------------------------------------- Query 11 Employees Above Department Average Salary ---------------------------

SELECT 
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    e.Salary,
    ROUND(d.Avg_Salary, 2) AS Department_Avg_Salary
FROM
    Employees e
        JOIN
    (SELECT 
        Department, AVG(Salary) AS Avg_Salary
    FROM
        Employees
    GROUP BY Department) d ON e.Department = d.Department
WHERE
    e.Salary > d.Avg_Salary
ORDER BY e.Salary DESC;

----------------------------------- Query 12 Performance Analysis ----------------------------------------------

SELECT 
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Performance_Score,
    p.Productivity_Score,
    p.Quality_Score,
    p.Target_Achievement
FROM
    Employees e
        JOIN
    Performance p ON e.Employee_ID = p.Employee_ID
ORDER BY p.Performance_Score DESC
LIMIT 10;

------------------------------------- Query 13 Employee Performance vs Department Average ----------------------------------------

SELECT 
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Performance_Score,
    ROUND(d.Department_Avg_Performance, 2) AS Department_Avg_Performance
FROM
    Employees e
        JOIN
    Performance p ON e.Employee_ID = p.Employee_ID
        JOIN
    (SELECT 
        e2.Department,
            AVG(p2.Performance_Score) AS Department_Avg_Performance
    FROM
        Employees e2
    JOIN Performance p2 ON e2.Employee_ID = p2.Employee_ID
    GROUP BY e2.Department) d ON e.Department = d.Department
WHERE
    p.Performance_Score > d.Department_Avg_Performance
ORDER BY p.Performance_Score DESC;

----------------------------------- Query 14 Performance Category Using Case ----------------------------------------------------

SELECT 
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Performance_Score,
    CASE
        WHEN p.Performance_Score >= 90 THEN 'Outstanding'
        WHEN p.Performance_Score >= 80 THEN 'High Performer'
        WHEN p.Performance_Score >= 70 THEN 'Meets Expectations'
        WHEN p.Performance_Score >= 60 THEN 'Needs Improvement'
        ELSE 'Critical'
    END AS Performance_Category
FROM
    Employees e
        JOIN
    Performance p ON e.Employee_ID = p.Employee_ID
ORDER BY p.Performance_Score DESC;

------------------------------------- Query 15 Average Performance by Department -----------------------------------------------

SELECT 
    e.Department,
    COUNT(*) AS Employees,
    ROUND(AVG(p.Performance_Score), 2) AS Avg_Performance,
    ROUND(AVG(p.Productivity_Score), 2) AS Avg_Productivity,
    ROUND(AVG(p.Quality_Score), 2) AS Avg_Quality,
    ROUND(AVG(p.Target_Achievement), 2) AS Avg_Target_Achievement
FROM
    Employees e
        JOIN
    Performance p ON e.Employee_ID = p.Employee_ID
GROUP BY e.Department
ORDER BY Avg_Performance DESC;

--------------------------------- Query 16 Employee Performance Ranking -----------------------------------

SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Performance_Score,
    RANK() OVER (
        PARTITION BY e.Department
        ORDER BY p.Performance_Score DESC
    ) AS Performance_Rank
FROM Employees e
JOIN Performance p
    ON e.Employee_ID = p.Employee_ID
ORDER BY e.Department, Performance_Rank;

------------------------- Query 17 Top 3 Performers from Each Department -------------------------------------------

WITH Employee_Ranking AS (
    SELECT
        e.Employee_ID,
        e.Employee_Name,
        e.Department,
        p.Performance_Score,
        RANK() OVER (
            PARTITION BY e.Department
            ORDER BY p.Performance_Score DESC
        ) AS Performance_Rank
    FROM Employees e
    JOIN Performance p
        ON e.Employee_ID = p.Employee_ID
)

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Performance_Score,
    Performance_Rank
FROM Employee_Ranking
WHERE Performance_Rank <= 3
ORDER BY Department, Performance_Rank;

-------------------------------------- Query 18 Employee Tenure ------------------------------------------------------------

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Joining_Date,
    TIMESTAMPDIFF(
        YEAR,
        Joining_Date,
        CURDATE()
    ) AS Tenure_Years
FROM Employees
ORDER BY Tenure_Years DESC;

DESCRIBE Employees;

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Joining_Date,
    TIMESTAMPDIFF(
        YEAR,
        STR_TO_DATE(Joining_Date, '%d-%m-%Y'),
        CURDATE()
    ) AS Tenure_Years
FROM Employees
ORDER BY Tenure_Years DESC;

---------------------------- Query 19 Employees with Excessive Overtime---------------------------------------------

SELECT 
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    ROUND(AVG(a.Overtime_Hours), 2) AS Avg_Overtime_Hours
FROM
    Employees e
        JOIN
    Attendance a ON e.Employee_ID = a.Employee_ID
GROUP BY e.Employee_ID , e.Employee_Name , e.Department
HAVING AVG(a.Overtime_Hours) > 1
ORDER BY Avg_Overtime_Hours DESC;

------------------------------- Query 20 Employee Attendance Summary ---------------------------------------------- 

SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    COUNT(a.Attendance_ID) AS Attendance_Records,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN a.Status = 'Present' THEN 1
                ELSE 0
            END
        ) / COUNT(a.Attendance_ID),
        2
    ) AS Attendance_Percentage,

    ROUND(AVG(a.Overtime_Hours), 2) AS Avg_Overtime_Hours

FROM Employees e
JOIN Attendance a
    ON e.Employee_ID = a.Employee_ID

GROUP BY
    e.Employee_ID,
    e.Employee_Name,
    e.Department

HAVING Attendance_Percentage < 85

ORDER BY Attendance_Percentage ASC;

--------------------------------------- Query 21 Employee Engagement Analysis -------------------------

SELECT
    e.Department,
    COUNT(*) AS Employees,
    ROUND(AVG(g.Job_Satisfaction), 2) AS Avg_Job_Satisfaction,
    ROUND(AVG(g.Work_Life_Balance), 2) AS Avg_Work_Life_Balance,
    ROUND(AVG(g.Manager_Satisfaction), 2) AS Avg_Manager_Satisfaction,
    ROUND(AVG(g.Career_Growth), 2) AS Avg_Career_Growth,
    ROUND(AVG(g.Environment_Satisfaction), 2) AS Avg_Environment_Satisfaction,
    ROUND(AVG(g.Engagement_Score), 2) AS Avg_Engagement_Score
FROM Employees e
JOIN Employee_Engagement g
    ON e.Employee_ID = g.Employee_ID
GROUP BY e.Department
ORDER BY Avg_Engagement_Score DESC;


--------------------------------------------- Query 22 Low Engagement Departments ------------------------------------

SELECT
    e.Department,
    ROUND(AVG(g.Engagement_Score), 2) AS Avg_Engagement_Score
FROM Employees e
JOIN Employee_Engagement g
    ON e.Employee_ID = g.Employee_ID
GROUP BY e.Department
HAVING AVG(g.Engagement_Score) < 70.5
ORDER BY Avg_Engagement_Score ASC;

-----------------------------------------  Quert 23 Engagement vs Attrition --------------------------------------------
SELECT
    e.Department,
    ROUND(AVG(g.Engagement_Score), 2) AS Avg_Engagement_Score,
    COUNT(*) AS Total_Employees,
    SUM(
        CASE
            WHEN e.Employment_Status = 'Exited' THEN 1
            ELSE 0
        END
    ) AS Exited_Employees,
    ROUND(
        SUM(
            CASE
                WHEN e.Employment_Status = 'Exited' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employees e
JOIN Employee_Engagement g
    ON e.Employee_ID = g.Employee_ID
GROUP BY e.Department
ORDER BY Avg_Engagement_Score ASC;


----------------------------------------- Query 24 High-Risk Employees ---------------------------------------------------

SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Performance_Score,
    g.Job_Satisfaction,
    g.Career_Growth,
    ROUND(AVG(a.Overtime_Hours), 2) AS Avg_Overtime,
    
    (
        CASE WHEN p.Performance_Score < 60 THEN 1 ELSE 0 END +
        CASE WHEN g.Job_Satisfaction < 60 THEN 1 ELSE 0 END +
        CASE WHEN g.Career_Growth < 60 THEN 1 ELSE 0 END +
        CASE WHEN AVG(a.Overtime_Hours) > 1 THEN 1 ELSE 0 END
    ) AS Risk_Factor_Count

FROM Employees e

JOIN Performance p
    ON e.Employee_ID = p.Employee_ID

JOIN Employee_Engagement g
    ON e.Employee_ID = g.Employee_ID

JOIN Attendance a
    ON e.Employee_ID = a.Employee_ID

GROUP BY
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Performance_Score,
    g.Job_Satisfaction,
    g.Career_Growth

HAVING Risk_Factor_Count >= 2

ORDER BY Risk_Factor_Count DESC;

------------------------------------- Query 25 Monthly Headcount ----------------------------------------------------

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Joining_Date, '%d-%m-%Y'),
        '%Y-%m'
    ) AS Joining_Month,
    COUNT(*) AS New_Employees
FROM Employees
GROUP BY Joining_Month
ORDER BY Joining_Month;