-- How many people are earning above the average salary of his/her department?
SELECT
	COUNT(*) AS AboveAverageEarners
FROM (
	SELECT
		s.EmployeeNumber,
        s.Department,
        s.MonthlyIncome,
        Dept_Avg.AvgIncome
	FROM emp_summary s
	JOIN (SELECT
			Department,
            AVG(MonthlyIncome) AS AvgIncome
		FROM emp_summary
		GROUP BY Department) AS Dept_Avg
	ON s.Department = Dept_Avg.Department
	WHERE s.MonthlyIncome > Dept_Avg.AvgIncome) AS Above_Avg_Employees;
-- Interpretation: Out of 1470 employees, 483 are earning above department's average income.


-- Who earns the most in the company? Provide the ID.
SELECT
	EmployeeNumber,
    Department,
    MonthlyIncome
FROM emp_summary
WHERE MonthlyIncome = (
	SELECT
		MAX(MonthlyIncome)
	FROM emp_summary
);


-- Who earns most in his/her own department?
SELECT
	s.EmployeeNumber,
	s.Department,
    s.JobRole,
    s.MonthlyIncome
FROM emp_summary s
WHERE s.MonthlyIncome = (
	SELECT
		MAX(s2.MonthlyIncome)
	FROM emp_summary s2
	WHERE s.Department = s2.Department
)
ORDER BY 2;
-- Interpretation: Looks like people having the higher most income are at Management level.

-- Find the second largest salary of each job role.
SELECT
	i1.JobRole, (
	SELECT DISTINCT c.MonthlyIncome
	FROM emp_info i
	JOIN emp_comp c
	ON i.EmployeeNumber = c.ID
	WHERE i1.JobRole = i.JobRole
	ORDER BY c.MonthlyIncome DESC
	LIMIT 1 OFFSET 1
	) AS SecondLargestSalary
FROM emp_info i1
GROUP BY i1.JobRole;