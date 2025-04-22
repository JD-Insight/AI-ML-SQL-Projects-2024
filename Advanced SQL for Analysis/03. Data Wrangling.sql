-- Unique values
SELECT DISTINCT "Department"
FROM employees.emp_info
ORDER BY "Department";


-- Concatenation
SELECT CONCAT("Department", ' - ', "JobRole") AS Role_In_Department
FROM employees.emp_info;


-- Filter duplicates
SELECT
	"EmployeeNumber",
	COUNT(*) AS TotalEmployees
FROM employees.emp_info
GROUP BY "EmployeeNumber"
HAVING COUNT(*) > 1;


-- Get NULL values
SELECT *
FROM employees.emp_info
WHERE "Age" IS NULL;


-- Replace NULL values
SELECT COALESCE("Age", 18) AS Age
FROM employees.emp_info
GROUP BY "Age";


-- Conditional columns
SELECT
	"EmployeeNumber",
	CASE
		WHEN "Age" < 30 THEN 'Young'
		WHEN "Age" BETWEEN 30 AND 50 THEN 'Mid-Career'
		ELSE 'Senior'
	END AS Career_Stage
FROM employees.emp_info;


-- Create a derived column
SELECT
	"MonthlyIncome",
	"PercentSalaryHike",
	ROUND("MonthlyIncome" * ( 1 + "PercentSalaryHike" / 100), 2) AS Projected_Income
FROM employees.emp_comp;


-- String cleanup
SELECT TRIM("JobRole") AS Cleaned_JobRole
FROM employees.emp_info;


-- String extraction
SELECT
	CASE
		WHEN POSITION(' ' IN "JobRole") > 0 THEN SUBSTRING("JobRole" FROM 1 FOR POSITION(' ' IN "JobRole") - 1)
	END AS FirstWord
FROM employees.emp_info;


-- Job title that starts with letter S and M
SELECT "JobRole"
FROM employees.emp_info
WHERE "JobRole" ~ '^[SM]';


-- Reformatting string data
SELECT DISTINCT(UPPER("Department")) AS DEPARTMENTS
FROM employees.emp_info
ORDER BY 1;

SELECT DISTINCT(LOWER("Department")) AS departments
FROM employees.emp_info
ORDER BY 1 DESC;


-- Length without Trim gives 25 characters
SELECT LENGTH('    Attrition Analysis   ');

-- Length with Trim gives 18 characters
SELECT LENGTH(TRIM('    Attrition Analysis   '));
