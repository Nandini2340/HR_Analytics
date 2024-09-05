---creating table education_level
CREATE TABLE education_level(
	EducationLevelID INT PRIMARY KEY,
	EducationLevel VARCHAR(100)
);


SELECT * FROM education_level;

--creating table Employee
CREATE TABLE Employee(
	EmployeeID	VARCHAR(50),
	FirstName	VARCHAR(100),
	LastName	VARCHAR(100),
	Gender	VARCHAR(50),
	Age	INT,
	BusinessTravel	VARCHAR(100),
	Department VARCHAR(150),
	DistanceFromHome INT,
	State	VARCHAR(2),
	Ethnicity	VARCHAR(100),
	Education	INT,
	EducationField	VARCHAR(200),
	JobRole	VARCHAR(100),
	MaritalStatus	VARCHAR(100),
	Salary	INT,
	StockOptionLevel	INT,
	OverTime	VARCHAR(100),
	HireDate DATE,
	Attrition	VARCHAR(100),
	YearsAtCompany	INT,
	YearsInMostRecentRole	INT,
	YearsSinceLastPromotion	INT,
	YearsWithCurrManager INT

);

SELECT * FROM Employee;

--Create table performance rating
CREATE TABLE PerformanceRating(
	PerformanceID VARCHAR(100),
	EmployeeID	VARCHAR(100),
	ReviewDate	DATE,
	EnvironmentSatisfaction	INT,
	JobSatisfaction	INT,
	RelationshipSatisfaction	INT,
	TrainingOpportunitiesWithinYear INT,	
	TrainingOpportunitiesTaken	INT,
	WorkLifeBalance	INT,
	SelfRating	INT,
	ManagerRating INT

);

SELECT * FROM PerformanceRating;

--create table rating level
CREATE TABLE RatingLevel(
	RatingID	INT,
	RatingLevel VARCHAR(200)
);

SELECT * FROM RatingLevel;

--create table Satisfied level
CREATE TABLE SatisfiedLevel(
	SatisfactionID	INT,
	SatisfactionLevel VARCHAR(100)
);

--- 1.TOTAL NUMBER OF EMPLOYEES 
SELECT COUNT(employeeid)AS Total_no_employees FROM employee;

--- 2.EDUCATION LEVEL OF EMPLOYEES 
SELECT edu.educationlevel, COUNT(employeeid) AS Total_employees
FROM education_level AS edu
JOIN employee AS emp
ON edu.educationlevelid = emp.education
GROUP BY edu.educationlevel;

--- 3.CONCATENATE FISRTNAME AND LASTNAME INTO FULLNAME
ALTER TABLE employee
ADD COLUMN fullname VARCHAR;

SELECT * FROM employee;

UPDATE employee
SET fullname = CONCAT(firstname, ' ', lastname); 

ALTER TABLE employee
DROP COLUMN firstname,
DROP COLUMN lastname;


--- 4.IDENTIFY NO. OF MALES AND FEMALES EMPLOYEES 
SELECT gender, count(gender) AS Total_employees FROM employee
WHERE gender = 'Male'
OR gender = 'Female'
GROUP BY gender;

--- 5.EMPLOYEES BY DEPARTMENT
SELECT department, COUNT(department) as Total_employees FROM employee
GROUP BY department;

--- 6.EDUCATION QUALIFICATION OF THE EMPLOYEES
SELECT educationfield, COUNT(employeeid) FROM employee 
GROUP BY educationfield;
SELECT DISTINCT educationfield FROM employee;

--- 7.NUMBER OF EMPLOYEES IN DIFFERENT JOB ROLE 
SELECT jobrole, COUNT(employeeid) AS Total_employees FROM employee
GROUP BY jobrole;

--- 8.EMPLOYEES WITH MAXIMUM SALARY 
SELECT max(salary) FROM employee;
--- EMPLOYEES WITH MINIMUN SALARY 
SELECT MIN(salary) FROM employee;

--- 9.EMPLOYEES WHO HAVE GREATER THAN 3L SALARY 
SELECT fullname, salary FROM employee
WHERE salary >= 300000;

--- 10.NUMBER OF EMPLOYEES HIRED BY YEAR
SELECT 
    EXTRACT(YEAR FROM hiredate) AS hire_year,
    COUNT(*) AS employees_hired
FROM 
    employee
GROUP BY 
    hire_year
ORDER BY 
    hire_year;


--- 11.EMPLOYEES WHO WORK 10 YEARS IN THE COMPANY 
SELECT fullname, jobrole, yearsatcompany FROM employee
where yearsatcompany >= 10
ORDER BY fullname ASC;

--- 12.MARITAL STATUS OF THE EMPLOYEES 
SELECT maritalstatus, COUNT(maritalstatus) AS Total_employees FROM employee
GROUP BY maritalstatus ;

--- 13.NUMBER OF EMPLOYEES DO OVERTIME 
SELECT COUNT(overtime) AS Total_emp_do_overtime FROM employee
WHERE overtime = 'Yes';

--- 14.SATISFACTION LEVEL OF THE EMPLOYEES
SELECT satisfactionlevel, COUNT(employeeid) AS Total_employees FROM performancerating AS per_rating
JOIN satisfiedlevel AS st_level
ON per_rating.jobsatisfaction = st_level.satisfactionid
GROUP BY satisfactionlevel;

--- 15.RATING LEVEL OF THE EMPLOYEES 
SELECT ratinglevel, COUNT(employeeid) AS Total_employees 
FROM performancerating AS per_rating
JOIN ratinglevel AS rate_level
ON per_rating.selfrating = rate_level.ratingid
GROUP BY ratinglevel;