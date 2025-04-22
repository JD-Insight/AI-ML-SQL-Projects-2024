-- How many employees are there in the company and seggregate them gender-wise?
SELECT
	"Gender",
	COUNT("Gender") AS Total_Employees
FROM employees.emp_info
GROUP BY "Gender";


-- What percent of employees have left the company?
SELECT ROUND(100 * COUNT(CASE WHEN "Attrition" = 'Yes' THEN 1 END) / COUNT(*), 2) AS Attrition_Rate
FROM employees.emp_info;


-- Which job role has the highest attrition rate?
SELECT
	"JobRole" AS Job_Role,
	ROUND(100 * COUNT(CASE WHEN "Attrition" = 'Yes' THEN 1 END) / COUNT(*), 2) AS Attrition_Rate
from employees.emp_info
GROUP BY "JobRole"
ORDER BY "JobRole" DESC
LIMIT 1;


-- How many employees have more than 10 years of total working experience?
SELECT COUNT(*) AS Total_Senior_Employees
FROM employees.emp_comp
WHERE "TotalWorkingYears" > 10;


-- What is the most common job role?
SELECT
	"JobRole" AS Job_Role,
	COUNT(*) as Most_Common
FROM employees.emp_info
GROUP BY "JobRole"
ORDER BY COUNT(*) DESC
LIMIT 1;


-- What is the daily income distribution by gender group?
SELECT
	"Gender",
	MIN("DailyRate") AS Min_Daily_Income,
	MAX("DailyRate") AS Max_Daily_Income,
	ROUND(AVG("DailyRate"),2) AS Average_Daily_Income
FROM employees.emp_info
GROUP BY "Gender";


-- What is the median age of employees for each role?
SELECT
	"JobRole",
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Age") AS MedianAge
FROM employees.emp_info
GROUP BY "JobRole";


-- How much salary per day is the company spending for each department?
SELECT
	"Department",
	TO_CHAR(SUM("DailyRate"), '$999,999,999.99') AS Total_Daily_Income
FROM employees.emp_info
GROUP BY "Department";


-- How spread out are the salaries around the average salary on per day rate in each department?
-- Find which department has the higest salary spread out?
SELECT
	"Department",
	ROUND(AVG("DailyRate"), 2) AS Avg_Salary,
	ROUND(VAR_POP("DailyRate"), 2) AS Variance_Salary,
	ROUND(STDDEV_POP("DailyRate"), 2) AS Stddev_Salary
FROM employees.emp_info
GROUP BY "Department"
ORDER BY 4 DESC;


-- Count the no of employees who had business travels for each department?
SELECT
	"Department",
	"BusinessTravel",
	COUNT(*) AS Total_Employees_Travelled
FROM employees.emp_info
WHERE "BusinessTravel" LIKE 'Travel%'
GROUP BY "Department", "BusinessTravel"
ORDER BY "Department";
