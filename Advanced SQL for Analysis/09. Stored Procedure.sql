/* Objective:
1. Insert a new employee into both 'emp_info' and 'emp_comp'
2. Use a stored procedure to:
	Automatically calculate the salary hike percentage based on performance rating.
	Insert data into both tables within a transaction.*/

/*INSERT INTO emp_info
VALUES (25, 'No', 'Non-Travel', 110, 'Sales', 6, 2, 'Marketing', 1, 2069, 4, 'Female', 56, 3, 4, 'Sales Executive', 4, 'Single');

INSERT INTO emp_comp
VALUES (1, 5993, 19479, 8, 'Y', 'Yes', 11, 3, 1, 80, 0, 8, 0, 1, 6, 4, 0, 5);*/

CREATE OR REPLACE PROCEDURE employees.insert_employee(
p_Age INT,
p_Attrition VARCHAR,
p_BusinessTravel VARCHAR,
p_DailyRate INT,
p_Department VARCHAR,
p_DistanceFromHome INT,
p_Education INT,
p_EducationField VARCHAR,
p_EmployeeNumber INT,
p_EnvironmentSatisfaction INT,
p_Gender VARCHAR,
p_HourlyRate INT,
p_JobInvolvement INT,
p_JobLevel INT,
p_JobRole VARCHAR,
p_JobSatisfaction INT,
p_MaritalStatus VARCHAR,

-- emp_comp columns excluding PercentSalaryHike now
p_EmpID INT,
p_MonthlyIncome INT,
p_MonthlyRate INT,
p_NumCompaniesWorked INT,
p_Over18 VARCHAR,
p_OverTime VARCHAR,
p_PerformanceRating INT,
p_RelationshipSatisfaction INT,
p_StockOptionLevel INT,
p_TotalWorkingYears INT,
p_TrainingTimesLastYear INT,
p_WorkLifeBalance INT,
p_YearsAtCompany INT,
p_YearsInCurrentRole INT,
p_YearsSinceLastPromotion INT,
p_YearsWithCurrManager INT
)
LANGUAGE plpgsql
AS $$
DECLARE
	v_SalaryHike INT;
BEGIN
	-- Determine PercentSalaryHike based on performance
	CASE p_PerformanceRating
		WHEN 1 THEN v_SalaryHike := 5;
		WHEN 2 THEN v_SalaryHike := 10;
		WHEN 3 THEN v_SalaryHike := 15;
		WHEN 4 THEN v_SalaryHike := 20;
		ELSE v_SalaryHike := 0;
	END CASE;

	-- Insert into emp_info table
	INSERT INTO employees.emp_info(
	"Age", "Attrition", "BusinessTravel", "DailyRate", "Department", "DistanceFromHome", "Education",
	"EducationField", "EmployeeCount", "EmployeeNumber", "EnvironmentSatisfaction", "Gender", "HourlyRate",
	"JobInvolvement", "JobLevel", "JobRole", "JobSatisfaction", "MaritalStatus"
	)
	VALUES(
	p_Age, p_Attrition, p_BusinessTravel, p_DailyRate, p_Department, p_DistanceFromHome, p_Education,
	p_EducationField, 1, p_EmployeeNumber, p_EnvironmentSatisfaction, p_Gender, p_HourlyRate,
	p_JobInvolvement, p_JobLevel, p_JobRole, p_JobSatisfaction, p_MaritalStatus
	);

	-- Insert into emp_comp table
	INSERT INTO employees.emp_comp(
	"EmpID", "MonthlyIncome", "MonthlyRate", "NumCompaniesWorked", "Over18", "OverTime", "PercentSalaryHike",
	"PerformanceRating", "RelationshipSatisfaction", "StandardHours", "StockOptionLevel", "TotalWorkingYears", 
	"TrainingTimesLastYear", "WorkLifeBalance", "YearsAtCompany", "YearsInCurrentRole",
	"YearsSinceLastPromotion", "YearsWithCurrManager"
	)
	VALUES(
	p_EmpID, p_MonthlyIncome, p_MonthlyRate, p_NumCompaniesWorked, p_Over18, p_OverTime, v_SalaryHike,
	p_PerformanceRating, p_RelationshipSatisfaction, 80, p_StockOptionLevel, p_TotalWorkingYears,
	p_TrainingTimesLastYear, p_WorkLifeBalance, p_YearsAtCompany, p_YearsInCurrentRole,
	p_YearsSinceLastPromotion, p_YearsWithCurrManager);
END;
$$;

CALL employees.insert_employee(
    30, 'No', 'Travel_Rarely', 1500, 'Research & Development', 3, 3, 'Life Sciences', 9, 3,
    'Female', 75, 3, 2, 'Research Scientist', 3, 'Single',
    30, 5000, 20000, 3, 'Y', 'Yes', 3, 3, 80, 1, 6, 3, 2, 2, 1, 0, 2
);

-- To run the procedure with explicit types.
/*CALL employees.insert_employee(
    30::INT,
    'No'::VARCHAR,
    'Travel_Rarely'::VARCHAR,
    1500::INT,
    'Research & Development'::VARCHAR,
    3::INT,
    3::INT,
    'Life Sciences'::VARCHAR,
    9::INT,
    3::INT,
    'Female'::VARCHAR,
    75::INT,
    3::INT,
    2::INT,
    'Research Scientist'::VARCHAR,
    3::INT,
    'Single'::VARCHAR,

    30::INT,
    5000::INT,
    20000::INT,
    3::INT,
    'Y'::VARCHAR,
    'Yes'::VARCHAR,
    3::INT,
    3::INT,
    1::INT,
    6::INT,
    3::INT,
    2::INT,
    2::INT,
    1::INT,
    0::INT,
    2::INT
);
