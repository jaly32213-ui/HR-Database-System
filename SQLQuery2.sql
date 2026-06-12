USE HR_Project;
GO

TRUNCATE TABLE Attendance;
DELETE FROM Salaries;
DELETE FROM Employees;
DBCC CHECKIDENT('Employees',RESEED,0);
GO