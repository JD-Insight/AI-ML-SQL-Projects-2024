/* Store top 3 highest paid employees in a temporary table and filter only males.*/
CREATE TEMP TABLE TopPaid AS
	SELECT
		DISTINCT i."EmployeeNumber",
		i."Gender",
		i."JobRole",
		c."MonthlyIncome",
		DENSE_RANK() OVER(PARTITION BY i."Gender" ORDER BY c."MonthlyIncome" DESC) AS Ranking
	FROM employees.emp_info i
	JOIN employees.emp_comp c
	ON i."EmployeeNumber" = c."EmpID"
	ORDER BY c."MonthlyIncome" DESC;

SELECT * FROM TopPaid
WHERE TopPaid."Gender" = 'Male' and Ranking <= 3;


/* Create a temporary table to store employees whose monthly income is above the average income, then display it.*/
CREATE TEMP TABLE HighEarners AS
	SELECT
		DISTINCT i."EmployeeNumber",
		i."JobRole",
		c."MonthlyIncome",
		ROUND((AVG(c."MonthlyIncome") OVER(PARTITION BY i."JobRole")), 2) AS AvgIncomeByRole
	FROM employees.emp_info i
	JOIN employees.emp_comp c
	ON i."EmployeeNumber" = c."EmpID"
	ORDER BY i."JobRole";

SELECT * FROM HighEarners
WHERE "MonthlyIncome" > HighEarners.AvgIncomeByRole;

	
/* Create a temporary table to analyse employee survey points based on their ratings for job satisfaction,
environment satisfaction, work life balance and find those with average rating less than 3. */
CREATE TEMP TABLE Survey AS
SELECT
	DISTINCT i."EmployeeNumber",
	i."Department",
	i."EnvironmentSatisfaction",
	i."JobSatisfaction",
	c."WorkLifeBalance",
	(i."EnvironmentSatisfaction" + i."JobSatisfaction" + c."WorkLifeBalance") / 3 AS AvgSatisfaction
FROM employees.emp_info i
JOIN employees.emp_comp c
ON i."EmployeeNumber" = c."EmpID"
ORDER BY i."Department";

SELECT * FROM Survey
WHERE AvgSatisfaction < 3;
