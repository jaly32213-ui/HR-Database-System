USE HR_Project;
GO
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY IDENTITY(1,1),
    DeptName NVARCHAR(50) NOT NULL,
    Location NVARCHAR(100)
);


IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    EmpName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    JobTitle NVARCHAR(50),
    BaseSalary DECIMAL(10, 2),
    HireDate DATE DEFAULT GETDATE(),
    DeptID INT,
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Departments (DeptName, Location) VALUES 
('Human Resources', 'Cairo - Floor 1'),
('Information Technology', 'Cairo - Floor 2'),
('Finance', 'Alexandria'),
('Marketing', 'Cairo - Floor 3'),
('Sales', 'Giza'),
('Operations', 'Cairo - Floor 4');


DELETE FROM Employees;
INSERT INTO Employees (EmpName, Email, JobTitle, BaseSalary, HireDate, DeptID) VALUES 
('Somaya Mohmed', 'somaya.hr@company.com', 'Senior Developer', 5000, '2023-01-15', 2),
('Ahmed Hassan', 'ahmed.h@company.com', 'HR Specialist', 5500, '2023-05-10', 1),
('Sara Ibrahim', 'sara.i@company.com', 'Financial Analyst', 4800, '2023-02-20', 3),
('Mona Zaki', 'mona.z@company.com', 'Marketing Manager', 6000, '2024-01-05', 4),
('Omar Khaled', 'omar.k@company.com', 'System Admin', 5200, '2023-11-12', 2),
('Layla Ali', 'layla.a@company.com', 'Accountant', 4700, '2023-08-30', 3),
('Youssef Amr', 'youssef.a@company.com', 'Sales Executive', 5800, '2024-02-14', 5),
('Hoda Mansour', 'hoda.m@company.com', 'IT Support', 5100, '2023-12-01', 2),
('Zainab Mahmoud', 'zainab.m@company.com', 'Operations Lead', 6500, '2023-03-22', 6),
('Mostafa Taha', 'mostafa.t@company.com', 'Data Analyst', 7000, '2024-03-10', 2);

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY IDENTITY(1,1), 
    EmployeeID INT NOT NULL, 
    AttendanceDate DATE NOT NULL,
    Status VARCHAR(10) NOT NULL DEFAULT 'Present', 
	CONSTRAINT FK_Attendance_Employee 
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmpID),
);
GO


CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    BaseSalary DECIMAL(18, 2) NOT NULL,
    Deductions DECIMAL(18, 2) DEFAULT 0.00,
    NetSalary DECIMAL(18, 2) NOT NULL,
    SalaryMonth INT NOT NULL,
	CONSTRAINT FK_Salaries_Employee 
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmpID),
);
GO


DELETE FROM Attendance;
DELETE FROM Salaries;
GO


INSERT INTO Attendance (EmployeeID, AttendanceDate, Status) VALUES 
(1, '2026-05-01', 'Present'),
(2, '2026-05-01', 'Present'),
(3, '2026-05-01', 'Absent'),  
(4, '2026-05-01', 'Present'),
(5, '2026-05-01', 'Present'),
(6, '2026-05-01', 'Present'),
(7, '2026-05-01', 'Absent'),  
(8, '2026-05-01', 'Present'),
(9, '2026-05-01', 'Present'),
(10, '2026-05-01', 'Present'),


(1, '2026-05-02', 'Present'),
(3, '2026-05-02', 'Absent'),  
(7, '2026-05-02', 'Absent'),  


(3, '2026-05-03', 'Absent'),  
(7, '2026-05-03', 'Absent'),  


(3, '2026-05-04', 'Absent'),  
(7, '2026-05-04', 'Absent');  
GO


INSERT INTO Salaries (EmployeeID, BaseSalary, NetSalary, SalaryMonth) VALUES 
(1, 5000.00, 5000.00, 5),
(2, 5500.00, 5500.00, 5),
(3, 4800.00, 4800.00, 5),
(4, 6000.00, 6000.00, 5),
(5, 5200.00, 5200.00, 5),
(6, 4700.00, 4700.00, 5),
(7, 5800.00, 5800.00, 5),
(8, 5100.00, 5100.00, 5),
(9, 6500.00, 6500.00, 5),
(10, 7000.00, 7000.00, 5);
GO