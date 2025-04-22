-- Find employees who worked in multiple companies and have high attrition risk
-- Use: INNER JOIN
SELECT
	i."EmployeeNumber",
	i."JobRole",
    c."NumCompaniesWorked"
FROM employees.emp_info i
JOIN employees.emp_comp c
ON i."EmployeeNumber" = c."EmpID"
WHERE c."NumCompaniesWorked" > 3 AND i."Attrition" = 'No';


-- Find mentors on each job role based on work experience using self-join.
-- Use: SELF-JOIN
SELECT
	i."EmployeeNumber" AS Junior,
    i1."EmployeeNumber" AS Senior,
    i."JobRole",
    c."TotalWorkingYears" AS JuniorExp,
    c1."TotalWorkingYears" AS SeniorExp
FROM employees.emp_info i
JOIN employees.emp_info i1
ON i."JobRole" = i1."JobRole" AND i."EmployeeNumber" <> i1."EmployeeNumber"
JOIN employees.emp_comp c
ON i."EmployeeNumber" = c."EmpID"
JOIN employees.emp_comp c1
ON i1."EmployeeNumber" = c1."EmpID"
WHERE c."TotalWorkingYears" < c1."TotalWorkingYears";


-- Find employees who do not have compensation details.
-- Use: ANTI-JOIN (finds records of one table that don't have matching entries in another)
SELECT
	i."EmployeeNumber",
	i."JobRole",
	c."MonthlyIncome"
FROM employees.emp_info i
LEFT JOIN employees.emp_comp c
ON i."EmployeeNumber" = c."EmpID"
WHERE c."EmpID" IS NULL;


-- Evaluate all gender and department combinations for diversity mapping.
-- Use: CROSS JOIN
SELECT
	g."Gender",
    d."Department"
FROM
	(SELECT DISTINCT "Gender" FROM employees.emp_info) g
CROSS JOIN
	(SELECT DISTINCT "Department" FROM employees.emp_info) d;


-- Show the average monthly income of each role, split by Gender.
-- Use: CASE WHEN
SELECT
	i."JobRole", 
	AVG(CASE WHEN i."Gender" = 'Female' THEN c."MonthlyIncome" END) AS AvgMonthlyIncome_Female,
	AVG(CASE WHEN i."Gender" = 'Male' THEN c."MonthlyIncome" END) AS AvgMonthlyIncome_Male
FROM employees.emp_info i
JOIN employees.emp_comp c
ON i."EmployeeNumber" = c."EmpID"
GROUP BY i."JobRole"
ORDER BY i."JobRole";


-- Convert environment satisfaction, job satisfaction and work life balance to rows.
-- Use: Simulated using UNION ALL
SELECT
	"EmployeeNumber",
	'EnvironmentSatisfaction' AS Satisfaction_Type,
	"EnvironmentSatisfaction" AS Rating
FROM employees.emp_info
UNION ALL
SELECT
	"EmployeeNumber",
	'JobSatisfaction' AS Satisfaction_Type,
	"JobSatisfaction" AS Rating
FROM employees.emp_info
UNION ALL
SELECT
	i."EmployeeNumber",
	'WorkLifeBalance' AS Satisfaction_Type,
	c."WorkLifeBalance" AS Rating
FROM employees.emp_info i
JOIN employees.emp_comp c
ON i."EmployeeNumber" = c."EmpID";
