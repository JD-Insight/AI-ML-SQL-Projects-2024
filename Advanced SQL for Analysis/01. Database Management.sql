-- Create database.
CREATE DATABASE employees;


-- Create schema.
CREATE SCHEMA IF NOT EXISTS employees;


-- Create tables.
CREATE TABLE IF NOT EXISTS emp_info (
	Age INT CHECK (Age BETWEEN 18 AND 65),
	Attrition VARCHAR(5) CHECK (Attrition IN ('Yes', 'No')),
	BusinessTravel VARCHAR(20),

	DailyRate INT CHECK (DailyRate >= 0),
	Department VARCHAR(50),
	DistanceFromHome INT CHECK (DistanceFromHome >= 0),

	Education INT NOT NULL,
	EducationField VARCHAR(100),
	EmployeeCount INT,
	EmployeeNumber INT PRIMARY KEY,
	EnvironmentSatisfaction INT CHECK (EnvironmentSatisfaction BETWEEN 1 AND 4),
	Gender VARCHAR(10),

	HourlyRate INT CHECK (HourlyRate >= 0),
	JobInvolvement INT CHECK (JobInvolvement BETWEEN 1 AND 4),
	JobLevel INT,
	JobRole VARCHAR(100),
	JobSatisfaction INT CHECK (JobSatisfaction BETWEEN 1 AND 4),
	MaritalStatus VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS emp_comp (
	EmpID INT,
	
	MonthlyIncome INT CHECK (MonthlyIncome >= 0),
	MonthlyRate INT CHECK (MonthlyRate >= 0),
	NumCompaniesWorked INT,

	Over18 VARCHAR(5) CHECK (Over18 = 'Y'),
	OverTime VARCHAR(5) CHECK (OverTime IN ('Yes', 'No')),

	PercentSalaryHike INT,
	PerformanceRating INT CHECK (PerformanceRating BETWEEN 1 AND 4),
	RelationshipSatisfaction INT CHECK (RelationshipSatisfaction BETWEEN 1 AND 4),
	StandardHours INT DEFAULT 80 CHECK (StandardHours = 80),
	StockOptionLevel INT,
	TotalWorkingYears INT CHECK (TotalWorkingYears >= 0),
	TrainingTimesLastYear INT CHECK (TrainingTimesLastYear >= 0),

	WorkLifeBalance INT CHECK (WorkLifeBalance BETWEEN 1 AND 4),
	YearsAtCompany INT NOT NULL CHECK (YearsAtCompany >= 0),
	YearsInCurrentRole INT CHECK (YearsInCurrentRole >= 0),
	YearsSinceLastPromotion INT CHECK (YearsSinceLastPromotion >= 0),
	YearsWithCurrManager INT CHECK (YearsWithCurrManager >= 0),

    CONSTRAINT fk_emp
		FOREIGN KEY (EmpID)
		REFERENCES emp_info(EmployeeNumber)
		ON DELETE CASCADE
);


/* The tables and its structures are now created and available for data load.
Python program is used to push data into these tables (attached with this project folder).
Alternatively, the below SQL can be used to upload data manually. */

-- Manually insert data into created tables.

INSERT INTO emp_info
VALUES (41, 'Yes', 'Travel_Rarely', 1102, 'Sales', 1, 2, 'Life Sciences', 1, 1, 2, 'Female', 94, 3, 2, 'Sales Executive', 4, 'Single');

INSERT INTO emp_comp
VALUES (1, 5993, 19479, 8, 'Y', 'Yes', 11, 3, 1, 80, 0, 8, 0, 1, 6, 4, 0, 5);


-- Read the uploaded data.
SELECT *
FROM employees.emp_info LIMIT 5;

SELECT *
FROM employees.emp_comp LIMIT 5;


-- Maintain and manage data.
UPDATE employees.emp_info
SET attrition = 'Yes'
WHERE employeenumber = 21;


-- Column constraints
/*
	NOT NULL : Cannot be NULL
    PRIMARY KEY : For uniqueness
    CHECK : Apply a special condition check against the values in the column
    FOREIGN KEY : Relationship between tables 'emp_info' and 'emp_comp'
    REFERENCES : Used in foreign key referencing
    DEFAULT : Provides default value for a column if no value is assigned
*/
