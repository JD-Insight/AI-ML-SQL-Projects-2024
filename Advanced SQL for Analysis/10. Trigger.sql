/*Use Case:
When a new record is inserted into the emp_info table, automatically insert relevant data into a combined table
employee_full_profile by joining with emp_comp.

Step-by-step Plan:
1. Create the 3 tables: emp_info, emp_comp, and employee_full_profile.
2. Write a function (plpgsql) that performs the insert into employee_full_profile.
3. Create a trigger on emp_info for AFTER INSERT.*/

-- Create Tables
CREATE TABLE emp_info (
    Age INT,
    Attrition TEXT,
    BusinessTravel TEXT,
    DailyRate INT,
    Department TEXT,
    DistanceFromHome INT,
    Education INT,
    EducationField TEXT,
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender TEXT,
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole TEXT,
    JobSatisfaction INT,
    MaritalStatus TEXT
);

CREATE TABLE emp_comp (
    EmpID INT PRIMARY KEY,
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime TEXT,
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

CREATE TABLE employee_full_profile (
    EmployeeNumber INT PRIMARY KEY,
    Age INT,
    Gender TEXT,
    Department TEXT,
    JobRole TEXT,
    MonthlyIncome INT,
    OverTime TEXT,
    YearsAtCompany INT,
    PerformanceRating INT
);

--Trigger Function
CREATE OR REPLACE FUNCTION insert_full_profile()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_full_profile (
        EmployeeNumber,
        Age,
        Gender,
        Department,
        JobRole,
        MonthlyIncome,
        OverTime,
        YearsAtCompany,
        PerformanceRating
    )
    SELECT
        NEW.EmployeeNumber,
        NEW.Age,
        NEW.Gender,
        NEW.Department,
        NEW.JobRole,
        ec.MonthlyIncome,
        ec.OverTime,
        ec.YearsAtCompany,
        ec.PerformanceRating
    FROM emp_comp ec
    WHERE ec.EmpID = NEW.EmployeeNumber;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create Trigger
CREATE TRIGGER trg_after_emp_info_insert
AFTER INSERT ON emp_info
FOR EACH ROW
EXECUTE FUNCTION insert_full_profile();

--Execute Trigger
INSERT INTO emp_info (
    Age, Attrition, BusinessTravel, DailyRate, Department,
    DistanceFromHome, Education, EducationField, EmployeeCount,
    EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate,
    JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus
) VALUES (
    45, 'No', 'Travel_Rarely', 1200, 'Sales',
    3, 3, 'Marketing', 1,
    2, 3, 'Female', 70,
    3, 2, 'Sales Executive', 4, 'Married'
);

SELECT * FROM employee_full_profile;