-- Query 1
DROP TABLE IF EXISTS Employee CASCADE; 
CREATE TABLE Employee(
	employee_id varchar(20) NOT NULL,
	first_name varchar(20) NOT NULL,
	last_name varchar(20) NOT NULL,
	dob TIMESTAMP,
	address TEXT,
	nationality varchar(20),
	gender varchar(10),
	disability boolean,
	salary bigint,
	employee_level varchar(20) NOT NULL,
	employee_location varchar(20),
	department varchar(20),
	contact varchar(30) NOT NULL,
	email varchar(30) NOT NULL,
	countrycode varchar(5)
);

-- Query 2
INSERT INTO Employee (employee_id, first_name, last_name, dob, address, nationality, gender, disability, salary, employee_level, employee_location, department, contact, email, countrycode)
VALUES ('alex001', 'Pushkar', 'JK', '08/21/1993', '2470 Mandeville Ln, Unit 522, Alexandria VA, 22314', 'Indian', 'M', FALSE, 750000, 'SSE', 'Palo Alto', 'Engineering', 8722034203, 'pushkarjk@gmail.com', '1'),
('alex002', 'Julie', 'Jong', '12/09/1995', '2470 Mandeville Ln, Unit 522, Alexandria VA, 22314', 'Korean', 'F', FALSE, 150000, 'SDE1', 'Sunnyvale', 'Engineering', 8579198185, 'eunjujong95@gmail.com', '1'),
('phil001', 'Vidhusha', 'Pavan', '05/22/1997', '3928 Haverford Ave, Philadelphia PA, 19104', 'Indian', 'F', FALSE, 250000, 'Associate', 'New York City', 'Logistics', 4847638948, 'vidhushapavan@gmail.com', '1'),
('phil002', 'Vivek', 'Nandakumar', '06/22/1993', '3928 Haverford Ave, Philadelphia PA, 19104', 'Indian', 'M', FALSE, 650000, 'PM', 'Houston', 'Logistics', 8325764200, 'viveknandakumar@gmail.com', '1'),
('moon002', 'Matt', 'Damon', '06/26/1990', '245 Moon Ave, Moon City, Moon', 'USA', 'M', FALSE, 750000, 'SDE2', 'Vancouver', 'Engineering', 9876541234, 'iamgorgeous@gmail.com', '1000');

-- Query 3
SELECT first_name, last_name FROM Employee WHERE salary = (SELECT MAX(salary) FROM Employee); 
SELECT * FROM Employee WHERE salary = (SELECT MAX(salary) FROM Employee);
SELECT * FROM Employee WHERE salary = (SELECT MAX(salary) FROM Employee) ORDER BY last_name ASC;

-- Query 4
SELECT first_name, last_name FROM Employee WHERE salary = (SELECT MIN(salary) FROM Employee); 
SELECT * FROM Employee WHERE salary = (SELECT MIN(salary) FROM Employee);
SELECT * FROM Employee WHERE salary = (SELECT MIN(salary) FROM Employee) ORDER BY last_name ASC;

-- Quesry 5
-- Update contact whose last name contains "ku"
UPDATE Employee SET contact ='7563321650' WHERE last_name LIKE '%ku%';

-- Query 6
-- DELETE FROM EMPLOYEE WHERE salary = (SELECT MIN(salary) FROM EMPLOYEE);

-- SELECT * FROM EMPLOYEE
-- DROP TABLE employee

-- Add primary key column to existing table
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
ALTER TABLE Employee ADD COLUMN unique_id uuid PRIMARY KEY DEFAULT uuid_generate_v4();

SELECT * FROM Employee;

-- Supervision Table Relations
-- ALTER TABLE Employee ADD COLUMN Supervision varchar(50) NULL;
DROP TABLE IF EXISTS Supervision CASCADE;
CREATE TABLE Supervision(
	unique_id uuid DEFAULT uuid_generate_v4(),
	team_member uuid,
	manager uuid,
	PRIMARY KEY(unique_id),
	FOREIGN KEY (team_member) REFERENCES Employee(unique_id),
	FOREIGN KEY (manager) REFERENCES Employee(unique_id)
);


-- Pushkar(manager) / Julie, Matt, Vidhusha (employees)
-- Vivek(manager) / Julie, Vidhusha (employees)
INSERT INTO Supervision VALUES (gen_random_uuid(), 
								(SELECT unique_id FROM Employee WHERE first_name = 'Julie' AND last_name = 'Jong'), 
								(SELECT unique_id FROM Employee WHERE first_name = 'Pushkar' AND last_name = 'JK'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT unique_id FROM Employee WHERE first_name = 'Matt' AND last_name = 'Damon'), 
								(SELECT unique_id FROM Employee WHERE first_name = 'Pushkar' AND last_name = 'JK'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT unique_id FROM Employee WHERE first_name = 'Vidhusha' AND last_name = 'Pavan'), 
								(SELECT unique_id FROM Employee WHERE first_name = 'Pushkar' AND last_name = 'JK'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT unique_id FROM Employee WHERE first_name = 'Julie' AND last_name = 'Jong'), 
								(SELECT unique_id FROM Employee WHERE first_name = 'Vivek' AND last_name = 'Nandakumar'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT unique_id FROM Employee WHERE first_name = 'Vidhusha' AND last_name = 'Pavan'), 
								(SELECT unique_id FROM Employee WHERE first_name = 'Vivek' AND last_name = 'Nandakumar'));


select * from supervision
select * from employee

-- Remove nationality, address, contact countrycode from Employee table
ALTER TABLE Employee DROP COLUMN nationality, 
DROP COLUMN address, 
DROP COLUMN employee_location, 
DROP COLUMN contact,
DROP COLUMN countrycode;

-- Create a table "Employee_info"
DROP TABLE IF EXISTS Employee_Info CASCADE; 
CREATE TABLE Employee_Info(
	unique_id uuid DEFAULT uuid_generate_v4(),
	employee_id uuid,
	employee_location varchar(20),
	nationality varchar(20),
	address TEXT,
	phone varchar(30) NOT NULL,
	countrycode varchar(5)
);

-- Add more rows to Employee table
INSERT INTO Employee
VALUES ('leon0076', 'Leonardo', 'DiCaprio', '07/22/1976', 'M', FALSE, 790000, 'SSE', 'Engineering', 'iamleo@gmail.com', gen_random_uuid()),
('denz3322', 'Denzel', 'Washington', '12/22/1961', 'M', FALSE, 850000, 'ED', 'PM', 'iamdenzelw@gmail.com', gen_random_uuid()),
('mery7781', 'Meryl', 'Streep', '05/24/1956', 'F', FALSE, 810000, 'PD', 'Logistics', 'iammeryl@gmail.com', gen_random_uuid()),
('juli9908', 'Julia', 'Roberts', '04/30/1969', 'F', FALSE, 560000, 'M', 'Finance', 'juliarob@gmail.com', gen_random_uuid()),
('jude2395', 'Jude', 'Law', '06/28/1972', 'M', FALSE, 350000, 'Junior', 'HR', 'iamjudelaw@gmail.com', gen_random_uuid());

-- insert info into employee_info table
INSERT INTO Employee_Info 
VALUES (gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Pushkar' AND last_name = 'JK'), 'Palo Alto', 'Indian', '2470 Mandeville Ln, Unit 522, Alexandria VA, 22314', 9997776654, '1'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Julie' AND last_name = 'Jong'), 'Sunnyvale', 'Korean', '2470 Mandeville Ln, Unit 522, Alexandria VA, 22314', 8579198185, '1'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Vidhusha' AND last_name = 'Pavan'), 'New York City', 'Indian', '234 Chimney Ave, Unit 22, Mngovalley MN, 11234', 3332224456, '1'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Vivek' AND last_name = 'Nandakumar'), 'Houston', 'Indian', '234 Chimney Ave, Unit 22, Mngovalley MN, 11234', 1239875673, '1'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Matt' AND last_name = 'Damon'), 'Vancouver', 'French', '315 S 45th St, Apt 2B, Philadelphia PA, 19104', 2229103847, '20'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Leonardo' AND last_name = 'DiCaprio'), 'New City', 'Mexican', '50 S Wisc Ave, Mountainview CA, 22346', 3439292002, '13'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Denzel' AND last_name = 'Washington'), 'Alexandria', 'Italian', '114 City View, Harford CT, 56798', 1203084738, '2'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Meryl' AND last_name = 'Streep'), 'Seattle', 'Malaysia', '990 Wearethebest Blvd, Boston MA, 30495', 3920291818, '5'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Julia' AND last_name = 'Roberts'), 'Colombia', 'Turkish', '23 Jamacan Place, MAdison WI, 22345', 1112234456, '12'),
(gen_random_uuid(), (SELECT unique_id FROM Employee WHERE first_name = 'Jude' AND last_name = 'Law'), 'Brazil', 'South African', '112 Urgent Ave, Unit 772, Chicago IL, 00765', 2029477728, '8');

SELECT * FROM Employee_Info;

-- Create a table "Building"
DROP TABLE IF EXISTS Building CASCADE; 
CREATE TABLE Building(
	building_id uuid DEFAULT uuid_generate_v4(),
	building_name varchar(20),
	country varchar(20),
	country_state varchar(20),
	city varchar(20),
	zip varchar(10)
);

INSERT INTO building
VALUES (gen_random_uuid(), 'PUSHJUL_LA', 'USA', 'California', 'Los Angeles', '22394'),
(gen_random_uuid(), 'PUSHJUL_SJ', 'USA', 'California', 'San Jose', '22221'),
(gen_random_uuid(), 'PUSHJUL_SAC', 'USA', 'California', 'Sacramento', '22113'),
(gen_random_uuid(), 'PUSHJUL_IRV', 'USA', 'California', 'Irvine', '22112'),
(gen_random_uuid(), 'PUSHJUL_SUN', 'USA', 'California', 'Sunnyvale', '22100'),
(gen_random_uuid(), 'PUSHJUL_PAL', 'USA', 'California', 'Palo Alto', '20976'),
(gen_random_uuid(), 'PUSHJUL_NYC', 'USA', 'California', 'New York City', '12038'),
(gen_random_uuid(), 'PUSHJUL_NC', 'USA', 'New Mexico', 'New City', '00921'),
(gen_random_uuid(), 'PUSHJUL_ALX', 'USA', 'Virginia', 'Alexandria', '22394'),
(gen_random_uuid(), 'PUSHJUL_SEA', 'USA', 'Washington', 'Seattle', '22394'),
(gen_random_uuid(), 'PUSHJUL_HOU', 'USA', 'Texas', 'Houston', '46575'),
(gen_random_uuid(), 'PUSHJUL_CMB', 'Colombia', 'DC Bogota', 'Bogota', '22394'),
(gen_random_uuid(), 'PUSHJUL_BRZ', 'Brazil', 'Sao Paulo', 'Sao Paulo', '22394'),
(gen_random_uuid(), 'PUSHJUL_BCV', 'Canada', 'British Columbia', 'Vancouver', 'HG1032'),
(gen_random_uuid(), 'PUSHJUL_SEOUL', 'South Korea', 'Seoul', 'Gangnam', '11774'),
(gen_random_uuid(), 'PUSHJUL_PARIS', 'France', 'Paris', 'Paris', '09283HJ');

-- Add a column to the Employee table called "building"
ALTER TABLE Employee ADD building uuid;

SELECT * FROM Employee_info;

-- Insert values to builing col in Employee table
UPDATE Employee SET building = 'b778532f-8c7c-4b57-b7f7-d5ccbd6ca7e4' WHERE first_name = 'Pushkar' AND last_name = 'JK';
UPDATE Employee SET building = 'ec2a25b7-829f-422f-bf75-b873b2f84a70' WHERE first_name = 'Julie' AND last_name = 'Jong';
UPDATE Employee SET building = '835b62ec-49ef-4887-bad9-057202a72e4f' WHERE first_name = 'Vidhusha' AND last_name = 'Pavan';
UPDATE Employee SET building = '9cb10bbf-5334-4714-b813-8247d69e8c4e' WHERE first_name = 'Vivek' AND last_name = 'Nandakumar';
UPDATE Employee SET building = '109bd527-cba9-47bb-805a-0243135855b4' WHERE first_name = 'Matt' AND last_name = 'Damon';
UPDATE Employee SET building = 'd027e9dc-bff9-424d-a161-ba03fdeb889a' WHERE first_name = 'Leonardo' AND last_name = 'DiCaprio';
UPDATE Employee SET building = '3a341ec0-1d82-4296-9536-a821d0ae92b9' WHERE first_name = 'Denzel' AND last_name = 'Washington';
UPDATE Employee SET building = '95a7f99f-bcd2-4a89-8080-f4d0090240e6' WHERE first_name = 'Meryl' AND last_name = 'Streep';
UPDATE Employee SET building = '19bf5c1f-b924-4b41-bb52-1a2738fe0cad' WHERE first_name = 'Julia' AND last_name = 'Roberts';
UPDATE Employee SET building = '9c70645f-50f9-448e-86f6-0703329b4766' WHERE first_name = 'Jude' AND last_name = 'Law';

SELECT * from employee;

-- Inner Join
SELECT E.building FROM Employee E, Building B WHERE E.building = B.building_id;

SELECT E.building FROM Employee E INNER JOIN Building B ON E.building = B.building_id;

-- Left-outer Join
SELECT E.unique_id, E.first_name, E.last_name, E.building FROM Employee E LEFT JOIN Building B ON E.building = B.building_id;

-- Right-outer Join
SELECT B.building_id, B.building_name, B.country, B.city FROM Building B LEFT JOIN Employee E ON B.building_id = E.building;

-- Full-outer Join
SELECT E.unique_id, E.first_name, E.last_name, E.building, B.building_name, B.Country, B.city FROM Employee E 
FULL JOIN Building B on E.building = B.building_id;

-- Rename ID column names in different tables
ALTER TABLE Employee RENAME COLUMN employee_id TO id_;
ALTER TABLE Employee RENAME COLUMN unique_id TO employee_id;
ALTER TABLE Employee RENAME COLUMN building TO buidling_id;
ALTER TABLE Employee_Info RENAME COLUMN unique_id TO employee_info_id;
ALTER TABLE Supervision RENAME COLUMN unique_id TO supervision_id;

-- Add more data to Supervisions
-- Julia(manager) / Julie, Vidhusha, Jude (employees)
-- Denzel(manager) / Pushkar, Vivek, Meryl, Julia (employees)
-- Meryl(manager) / Julie, Matt, Jude (employees)
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Julie' AND last_name = 'Jong'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Julia' AND last_name = 'Roberts'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Vidhusha' AND last_name = 'Pavan'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Julia' AND last_name = 'Roberts'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Jude' AND last_name = 'Law'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Julia' AND last_name = 'Roberts'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Pushkar' AND last_name = 'JK'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Denzel' AND last_name = 'Washington'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Vivek' AND last_name = 'Nandakumar'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Denzel' AND last_name = 'Washington'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Meryl' AND last_name = 'Streep'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Denzel' AND last_name = 'Washington'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Julia' AND last_name = 'Roberts'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Denzel' AND last_name = 'Washington'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Julie' AND last_name = 'Jong'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Meryl' AND last_name = 'Streep'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Matt' AND last_name = 'Damon'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Meryl' AND last_name = 'Streep'));
INSERT INTO Supervision VALUES (gen_random_uuid(),
								(SELECT employee_id FROM Employee WHERE first_name = 'Jude' AND last_name = 'Law'), 
								(SELECT employee_id FROM Employee WHERE first_name = 'Meryl' AND last_name = 'Streep'));

-- Print employees and their managers
SELECT E.employee_id, ((E.first_name||' ')||E.last_name) AS employee_name, E.employee_level, E.salary, 
E2.employee_id, ((E2.first_name||' ')||E2.last_name) AS manager_name, E2.employee_level, E2.salary
FROM Employee E
JOIN Supervision S ON E.employee_id = S.team_member
JOIN Employee E2 ON S.manager = E2.employee_id
ORDER BY E.first_name, E.last_name;

-- Print Employee/manager location and contact from employee_info table
SELECT E.employee_id, ((E.first_name||' ')||E.last_name) AS employee_name, E.employee_level, E.salary, EI.employee_location, EI.phone,
E2.employee_id, ((E2.first_name||' ')||E2.last_name) AS manager_name, E2.employee_level, E2.salary, EI2.employee_location, EI2.phone
FROM Employee E 
LEFT JOIN Supervision S ON E.employee_id = S.team_member
JOIN Employee E2 ON S.manager = E2.employee_id
LEFT JOIN Employee_info EI ON E.employee_id = EI.employee_id
LEFT JOIN Employee_info EI2 ON E2.employee_id = EI2.employee_id
ORDER BY E.first_name, E.last_name;

SELECT * FROM Employee_info;
