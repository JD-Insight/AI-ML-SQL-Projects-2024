-- How many employees are there in the company and seggregate them gender-wise?
SELECT Gender, COUNT(Gender) AS Total_Employees
FROM emp_info
GROUP BY Gender;


-- What percent of employees have left the company?
SELECT ((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / COUNT(*)) * 100) AS Attrition_Rate
FROM emp_info;


-- Which job role has the highest attrition rate?
SELECT JobRole AS Job_Role,
((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / COUNT(*)) * 100) AS Attrition_Rate
from emp_info
GROUP BY JobRole
ORDER BY JobRole DESC LIMIT 1;


-- How many employees have more than 10 years of total working experience?
SELECT COUNT(*) AS Total_Senior_Employees
FROM emp_comp
WHERE TotalWorkingYears > 10;


-- What is the most common job role?
SELECT JobRole AS Job_Role, COUNT(*) as Most_Common
FROM emp_info
GROUP BY JobRole
ORDER BY COUNT(*) DESC
LIMIT 1;


-- What is the daily income distribution by gender group?
SELECT Gender, MIN(DailyRate) AS Min_Daily_Income,
MAX(DailyRate) AS Max_Daily_Income,
AVG(DailyRate) AS Average_Daily_Income
FROM emp_info
GROUP BY Gender;


-- How much salary per day is the company spending for each department?
SELECT Department, CONCAT('$', FORMAT(SUM(DailyRate), 0)) AS Total_Daily_Income
FROM emp_info
GROUP BY Department;


-- How spread out are the salaries around the average salary on per day rate in each department?
-- Find which department has the higest salary spread out?
SELECT Department,
FORMAT(AVG(DailyRate), 2) AS Avg_Salary,
FORMAT(VAR_POP(DailyRate), 2) AS Variance_Salary,
FORMAT(STDDEV_POP(DailyRate), 2) AS Stddev_Salary
FROM emp_info
GROUP BY Department
ORDER BY 4 DESC;


-- Count the no of employees who had business travels for each department?
SELECT Department, BusinessTravel,
COUNT(*) AS Total_Employees_Travelled
FROM emp_info
WHERE BusinessTravel LIKE 'Travel%'
GROUP BY Department, BusinessTravel
ORDER BY Department;