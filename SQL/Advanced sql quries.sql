-- SQL QUERY 1
-- Rank Departments by Attrition

SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(
        CASE
            WHEN Employment_Status = 'Exited' THEN 1
            ELSE 0
        END
    ) AS Exited_Employees,
    ROUND(
        SUM(
            CASE
                WHEN Employment_Status = 'Exited' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate,
    DENSE_RANK() OVER (
        ORDER BY
        SUM(
            CASE
                WHEN Employment_Status = 'Exited' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*) DESC
    ) AS Attrition_Rank
FROM Employees
GROUP BY Department
ORDER BY Attrition_Rank;


-- SQL QUERY 2
-- Find highest-paid employees

-- ADVANCED SQL QUERY 2
-- Highest-Paid Employees

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Designation,
    Salary,
    DENSE_RANK() OVER (
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM Employees
ORDER BY Salary_Rank
LIMIT 10;

-- SQL QUERY 3
-- Calculate department salary averages

WITH Department_Salary AS (
    SELECT
        Department,
        COUNT(*) AS Employee_Count,
        AVG(Salary) AS Avg_Salary
    FROM Employees
    GROUP BY Department
)

SELECT
    Department,
    Employee_Count,
    ROUND(Avg_Salary, 2) AS Avg_Salary,
    ROUND(
        AVG(Avg_Salary) OVER (),
        2
    ) AS Overall_Average_Salary
FROM Department_Salary
ORDER BY Avg_Salary DESC;

-- SQL QUERY 4 
-- Compare employee performance with department average

WITH Performance_Data AS (
    SELECT
        e.Employee_ID,
        e.Employee_Name,
        e.Department,
        p.Performance_Score,
        AVG(p.Performance_Score) OVER (
            PARTITION BY e.Department
        ) AS Department_Avg_Performance
    FROM Employees e
    JOIN Performance p
        ON e.Employee_ID = p.Employee_ID
)

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Performance_Score,
    ROUND(Department_Avg_Performance, 2) AS Department_Avg_Performance,
    ROUND(
        Performance_Score - Department_Avg_Performance,
        2
    ) AS Performance_Difference
FROM Performance_Data
WHERE Performance_Score > Department_Avg_Performance
ORDER BY Performance_Difference DESC;

-- SQL QUERY 5 
-- Identify employees with excessive overtime

WITH Overtime_Data AS (
    SELECT
        e.Employee_ID,
        e.Employee_Name,
        e.Department,
        AVG(a.Overtime_Hours) AS Avg_Overtime_Hours
    FROM Employees e
    JOIN Attendance a
        ON e.Employee_ID = a.Employee_ID
    GROUP BY
        e.Employee_ID,
        e.Employee_Name,
        e.Department
)

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    ROUND(Avg_Overtime_Hours, 2) AS Avg_Overtime_Hours,
    CASE
        WHEN Avg_Overtime_Hours > 2 THEN 'Very High Overtime'
        WHEN Avg_Overtime_Hours > 1 THEN 'High Overtime'
        ELSE 'Normal Overtime'
    END AS Overtime_Category
FROM Overtime_Data
WHERE Avg_Overtime_Hours > 1
ORDER BY Avg_Overtime_Hours DESC;

-- SQL QUERY 6
-- Calculate monthly headcount

WITH Months AS (
    SELECT DISTINCT
        DATE_FORMAT(
            STR_TO_DATE(Joining_Date, '%d-%m-%Y'),
            '%Y-%m'
        ) AS Month
    FROM Employees
)

SELECT
    Month,
    (
        SELECT COUNT(*)
        FROM Employees e
        WHERE STR_TO_DATE(e.Joining_Date, '%d-%m-%Y')
              <= LAST_DAY(
                  STR_TO_DATE(CONCAT(Month, '-01'), '%Y-%m-%d')
              )
    ) AS Headcount
FROM Months
ORDER BY Month;

-- QUERY 7 
-- Calculate employee tenure

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

-- QUERY 8
-- Identify high-risk employees


WITH Employee_Risk AS (
    SELECT
        e.Employee_ID,
        e.Employee_Name,
        e.Department,
        p.Performance_Score,
        g.Job_Satisfaction,
        g.Work_Life_Balance,
        g.Career_Growth,
        ROUND(AVG(a.Overtime_Hours), 2) AS Avg_Overtime,

        (
            CASE
                WHEN p.Performance_Score < 60 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN g.Job_Satisfaction < 60 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN g.Work_Life_Balance < 60 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN g.Career_Growth < 60 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN AVG(a.Overtime_Hours) > 1 THEN 1
                ELSE 0
            END
        ) AS Risk_Factor_Count

    FROM Employees e

    JOIN Performance p
        ON e.Employee_ID = p.Employee_ID

    JOIN Employee_Engagement g
        ON e.Employee_ID = g.Employee_ID

    JOIN Attendance a
        ON e.Employee_ID = a.Employee_ID

    WHERE e.Employment_Status = 'Active'

    GROUP BY
        e.Employee_ID,
        e.Employee_Name,
        e.Department,
        p.Performance_Score,
        g.Job_Satisfaction,
        g.Work_Life_Balance,
        g.Career_Growth
)

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Performance_Score,
    Job_Satisfaction,
    Work_Life_Balance,
    Career_Growth,
    Avg_Overtime,
    Risk_Factor_Count,

    CASE
        WHEN Risk_Factor_Count >= 4 THEN 'Very High Risk'
        WHEN Risk_Factor_Count >= 3 THEN 'High Risk'
        WHEN Risk_Factor_Count >= 2 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Level

FROM Employee_Risk

WHERE Risk_Factor_Count >= 2

ORDER BY
    Risk_Factor_Count DESC,
    Avg_Overtime DESC;