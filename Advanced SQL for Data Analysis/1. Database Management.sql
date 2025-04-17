-- Create a database
CREATE DATABASE employees;

-- Create schema
CREATE SCHEMA employees;

-- Connect to the database and run
USE employees;

-- After creating database and connecting to it, create the tables
CREATE TABLE IF NOT EXISTS emp_info (
	Age INT CHECK (Age BETWEEN 18 AND 65),
	Attrition VARCHAR(5) CHECK (Attrition IN ('Yes', 'No')),
	BusinessTravel VARCHAR(20),

	DailyRate INT CHECK (DailyRate >= 0),
	Department VARCHAR(100),
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
	id INT PRIMARY KEY,

	MonthlyIncome INT CHECK (MonthlyIncome >= 0),
	MonthlyRate INT CHECK (MonthlyRate >= 0), 
	NumCompaniesWorked INT CHECK (NumCompaniesWorked >= 0),

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

    FOREIGN KEY (EmployeeNumber) REFERENCES emp_info(EmployeeNumber)
);

-- Once the table and its structure are created, insert values into the table from below options:
-- 1. To upload directly 
-- 		a. Right click on the database
--      b. Select Table Data Import Wizard
--      c. Browse to File Path
--      d. Select the required table from the drop down
--      e. Configure Import Settings
--          Encoding: uft-8
--          Columns: Verify the Source Column & Field Type
--      f. Import Data

-- 2. To upload into created tables via SQL command, use the below sample for each table
INSERT INTO emp_info
VALUES (41, 'Yes', 'Travel_Rarely', 1102, 'Sales', 1, 2, 'Life Sciences', 1, 1, 2, 'Female', 94, 3, 2, 'Sales Executive', 4, 'Single');
INSERT INTO emp_comp
VALUES (1, 5993, 19479, 8, 'Y', 'Yes', 11, 3, 1, 80, 0, 8, 0, 1, 6, 4, 0, 5);

-- Here, we've uploaded via option 1.

-- Read the uploaded data
SELECT * FROM emp_info
LIMIT 10;
SELECT * FROM emp_comp
LIMIT 10;


-- Maintain and manage
UPDATE emp_info
SET Attrition = 'Yes'
WHERE Attrition = 21;


-- Column constraints
/*
	NOT NULL : Cannot be NULL
    PRIMARY KEY : For uniqueness
    UNIQUE : Can contain only unique values. Applied for columns that are not mentioned as primary key
    CHECK : Apply a special condition check against the values in the column
    FOREIGN KEY : Relationship between tables 'emp_info' and 'emp_comp'
    REFERENCES : Used in foreign key referencing
    DEFAULT : Provides default value for a column if no value is assigned
    */