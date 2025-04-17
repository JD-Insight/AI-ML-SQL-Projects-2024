-- Let's use a virtual table to store our frequently used query.
CREATE VIEW emp_summary AS
SELECT
	i.EmployeeNumber,
    i.JobRole,
    i.Department,
    c.MonthlyIncome,
    c.OverTime
FROM emp_info i
JOIN emp_comp c
ON i.EmployeeNumber = c.ID;


-- Get the employee ID, department and monthly salary of the employees who work overtime beyond their standard hours.
SELECT
	EmployeeNumber,
    Department,
    MonthlyIncome
FROM emp_summary
WHERE OverTime = 'Yes';

    
-- Who are the employees older than 40 who also travel frequently?
SELECT
	EmployeeNumber,
    Age,
    JobRole,
    BusinessTravel
FROM emp_info
WHERE
	Age > 40 AND
	BusinessTravel LIKE 'Travel_Frequently';
    

-- Find no of employees with low job satisfaction (1 or 2) and who are single.
SELECT
	COUNT(*) AS LowSatisfactionEmployees
FROM emp_info
WHERE
	JobSatisfaction IN (1,2)
	AND
	MaritalStatus = 'Single';
	

-- Find average years at company by department.
SELECT
	i.Department,
	AVG(c.YearsAtCompany) AS AvgYrsAtCompany
FROM emp_info i
JOIN emp_comp c
	ON i.EmployeeNumber = c.ID
GROUP BY i.Department;
-- Interpretation: Employees at each department stats with the company on an average of 7 years.
    

-- Retrieve the performance ratings of the employees with higher satisfaction level.
SELECT
	EmployeeNumber,
    PerformanceRating
FROM emp_info i
JOIN emp_comp c
	ON i.EmployeeNumber = c.ID
WHERE JobSatisfaction = 4;
-- Interpretation: It is obvious that employees with higher performance rating displayed higher satisfaction level.
	

-- Compare the average hike percentage of employees who worked overtime with who have not in each department.
SELECT
	i.Department,
	c.OverTime,
    AVG(c.PercentSalaryHike) AS AvgHike
FROM emp_info i
JOIN emp_comp c
    ON i.EmployeeNumber = c.ID
GROUP BY i.Department, c.OverTime
ORDER BY i.Department, c.OverTime;
/* Interpretation: Those employees who have done overtime, seems to have slightly higher salary hike, as compared to 
those who have not, in all other departments except for R&D. */


-- Get the average job satisfaction, work life balance and years they stayed with the company in each department. Interpret them.
SELECT
	i.Department,
    AVG(i.JobSatisfaction) AS AvgSatisfaction,
    AVG(c.WorkLifeBalance) AS WLB,
    AVG(c.YearsAtCompany) AS YrsAtCompany
FROM emp_info i
JOIN emp_comp c
    ON i.EmployeeNumber = c.ID
GROUP BY i.Department;
/* Interpretation: On all the above metrics, it is clear that work-life balance in low for R&D department.
As a result, employees of that department have a shorter life span with the company.*/


-- Which department has the highest average performance rating?
SELECT
	i.Department,
    AVG(c.PerformanceRating) AS PerfRating
FROM emp_info i
JOIN emp_comp c
    ON i.EmployeeNumber = c.ID
GROUP BY i.Department;
-- Interpretation: R&D employees stays on top as compared to other departments when it comes to performance.


-- Find if distance from home has any relationship with attrition rate for each employee who left the company.
SELECT 
    Attrition,
    ROUND(AVG(DistanceFromHome), 2) AS AvgDistance
FROM emp_info
GROUP BY Attrition;
/* Interpretation: Comparing the average distance of employees who left vs who stayed back, it is 10.63 vs 8.92, which makes it one of the 
important feature to analyse. */