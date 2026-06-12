USE HR_Project;
GO

ALTER TABLE Attendance
ADD CONSTRAINT FK_Attendance_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmpID);
GO

ALTER TABLE Salaries
ADD CONSTRAINT FK_Salaries_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmpID);
GO
SELECT *
FROM sys.foreign_keys;