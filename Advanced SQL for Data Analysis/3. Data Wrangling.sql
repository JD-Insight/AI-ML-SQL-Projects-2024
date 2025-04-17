-- Unique values
SELECT DISTINCT (Department)
FROM emp_info
ORDER BY Department;

-- Concatenation
SELECT CONCAT(Department, ' - ', JobRole) AS Role_In_Department
FROM emp_info;

-- Filter duplicates
SELECT EmployeeNumber, COUNT(*)
FROM emp_info
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

-- Get NULL values
SELECT *
FROM emp_info
WHERE Age IS NULL;

-- Replace NULL values
SELECT IFNULL(Age, 18) AS Age
FROM emp_info
GROUP BY Age;

-- Conditional columns
SELECT EmployeeNumber,
CASE
	WHEN age < 30 THEN 'Young'
	WHEN age BETWEEN 30 AND 50 THEN 'Mid-Career'
	ELSE 'Senior'
END AS Career_Stage
FROM emp_info;

-- Create a derived column
SELECT MonthlyIncome, PercentSalaryHike,
ROUND(MonthlyIncome * ( 1 + PercentSalaryHike / 100), 2) AS Projected_Income
FROM emp_comp;

-- String cleanup
SELECT TRIM(JobRole) AS Cleaned_JobRole
FROM emp_info;

-- String extraction
SELECT
DISTINCT(SUBSTRING_INDEX(JobRole, ' ', 1)) AS FirstWord
FROM emp_info;

-- Job title that starts with letter S and M
SELECT JobRole
FROM emp_info
WHERE JobRole REGEXP '^[SM]';

-- Reformatting string data
SELECT DISTINCT(UPPER(Department)) AS DEPARTMENTS
FROM emp_info
ORDER BY 1;

SELECT DISTINCT(LOWER(Department)) AS departments
FROM emp_info
ORDER BY 1 DESC;

-- Length without Trim gives 25 characters
SELECT LENGTH('    Attrition Analysis   ');

-- Length with Trim gives 18 characters
SELECT LENGTH(TRIM('    Attrition Analysis   '));