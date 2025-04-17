-- Find top income earners within each department by their monthly income.
-- Use: RANK() or DENSE_RANK() with PARTITION BY Department
WITH t1 AS (
	SELECT
		i.EmployeeNumber,
		i.Department,
		c.MonthlyIncome,
		RANK() OVER(PARTITION BY i.Department ORDER BY c.MonthlyIncome DESC) AS IncomeRank
	FROM emp_info i
	JOIN emp_comp c
		ON i.EmployeeNumber = c.ID
)
SELECT *
FROM t1
WHERE IncomeRank = 1;


-- Show the running total of monthly income for all employees ordered by employee number.
-- Use: SUM(MonthlyIncome) OVER (ORDER BY EmployeeNumber)
SELECT
	i.EmployeeNumber,
    c.MonthlyIncome,
    SUM(c.MonthlyIncome) OVER (ORDER BY i.EmployeeNumber) AS Running_MI
FROM emp_info i
JOIN emp_comp c
	ON i.EmployeeNumber = c.ID;


-- Find the difference between each employee's salary and the department average.
-- Use: AVG(MonthlyIncome) OVER (PARTITION BY Department)
WITH t1 AS (
	SELECT
		i.EmployeeNumber,
        i.Department,
        c.MonthlyIncome,
        ROUND(AVG(c.MonthlyIncome) OVER(PARTITION BY i.Department),2) AS Dept_Avg
	FROM emp_info i
	JOIN emp_comp c
		ON i.EmployeeNumber = c.ID
)
SELECT
	*,
	(MonthlyIncome - Dept_Avg) AS IncomeDiff
FROM t1;


-- Show employees and the highest salary in their department (next to their own salary).
-- Use:  MAX(MonthlyIncome) OVER (PARTITION BY Department)
SELECT
	i.EmployeeNumber,
    c.MonthlyIncome,	
    MAX(c.MonthlyIncome) OVER (PARTITION BY Department) AS MaxSalaryByDept
FROM emp_info i
JOIN emp_comp c
	ON i.EmployeeNumber = c.ID;


-- Assign row numbers to employees within each JobRole.
-- Use: ROW_NUMBER() OVER (PARTITION BY JobRole ORDER BY EmployeeNumber)
SELECT
	EmployeeNumber,
    JobRole,
    ROW_NUMBER() OVER (PARTITION BY JobRole ORDER BY EmployeeNumber) AS OrderedByJobRole
FROM emp_info;


-- Calculate the percentage of salary each employee contributes to their department's total salary.
-- Use: SUM(MonthlyIncome) OVER (PARTITION BY Department)
WITH t1 AS (
	SELECT
		i.EmployeeNumber,
        i.Department,
        c.MonthlyIncome,
        (SUM(c.MonthlyIncome) OVER (PARTITION BY i.Department)) AS Dept_Total
	FROM emp_info i
	JOIN emp_comp c
		ON i.EmployeeNumber = c.ID
)
SELECT
	*,
    ((MonthlyIncome / dept_total) * 100) AS ContributedPerc
FROM t1;


-- Find employees whose salary is above the department median.
-- Use: PERCENT_RANK() with PARTITION BY Department
WITH t1 AS (
	SELECT
		i.EmployeeNumber,
        i.Department,
        c.MonthlyIncome,
        PERCENT_RANK() OVER(PARTITION BY i.Department ORDER BY c.MonthlyIncome) AS Salary_Rank
	FROM emp_info i
	JOIN emp_comp c
	ON i.EmployeeNumber = c.ID
)
SELECT *
FROM t1
WHERE Salary_Rank > 0.5;


-- Find employees whose salary is above the department median.
-- NTILE() with PARTITION BY Department
WITH t1 AS (
	SELECT
		i.EmployeeNumber,
        i.Department,
        c.MonthlyIncome,
        NTILE(2) OVER(PARTITION BY i.Department ORDER BY c.MonthlyIncome) AS Salary_Rank
	FROM emp_info i
	JOIN emp_comp c
	ON i.EmployeeNumber = c.ID
)
SELECT *
FROM t1
WHERE Salary_Rank = 2;


-- Get the average years at company over the last 5 employees (rolling average).
-- Use: AVG(YearsAtCompany) OVER (ORDER BY EmployeeNumber ROWS BETWEEN 4 PRECEDING AND CURRENT ROW)
SELECT
	i.EmployeeNumber,
    i.JobRole,
    c.YearsAtCompany,
    (AVG(c.YearsAtCompany) OVER (ORDER BY i.EmployeeNumber ROWS BETWEEN 4 PRECEDING AND CURRENT ROW)) AS RollingAvgYrsAtCompany
FROM emp_info i
JOIN emp_comp c
ON i.EmployeeNumber = c.ID
ORDER BY i.EmployeeNumber;

 
-- Compare each employee’s salary to the previous one and following member with same years of work experience.
-- Use: LAG/LEAD(MonthlyIncome) OVER (PARTITION BY Department ORDER BY MonthlyIncome)
SELECT
	i.EmployeeNumber,
    c.TotalWorkingYears,
    c.MonthlyIncome AS OwnSalary,
	IFNULL(LEAD(c.MonthlyIncome) OVER (PARTITION BY c.TotalWorkingYears ORDER BY c.MonthlyIncome), 0) AS FollowingMemberSalary,
	IFNULL(LAG(c.MonthlyIncome) OVER (PARTITION BY c.TotalWorkingYears ORDER BY c.MonthlyIncome), 0) AS LeadingMemberSalary
FROM emp_info i
JOIN emp_comp c
ON i.EmployeeNumber = c.ID;