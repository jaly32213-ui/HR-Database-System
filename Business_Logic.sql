USE HR_Project;
GO

CREATE PROCEDURE CalculateNetSalary
    @EmpID INT,
    @Month INT
AS
BEGIN
    DECLARE @AbsentDays INT;
    DECLARE @BaseSalary DECIMAL(18,2);
    DECLARE @DeductionRate DECIMAL(18,2) = 150.00;

    SELECT @BaseSalary = BaseSalary FROM Salaries WHERE EmployeeID = @EmpID AND SalaryMonth = @Month;

    SELECT @AbsentDays = COUNT(*) FROM Attendance 
    WHERE EmployeeID = @EmpID AND Status = 'Absent' AND MONTH(AttendanceDate) = @Month;

    UPDATE Salaries
    SET Deductions = (@AbsentDays * @DeductionRate),
        NetSalary = @BaseSalary - (@AbsentDays * @DeductionRate)
    WHERE EmployeeID = @EmpID AND SalaryMonth = @Month;
END;
GO


ALTER TRIGGER TRG_AbsenceAlert
ON Attendance
AFTER INSERT
AS
BEGIN
   
    DECLARE @AlertTable TABLE (
        EmployeeID INT,
        TotalAbsences INT,
        SystemMessage VARCHAR(100)
    );

    DECLARE @EmpID INT;
    DECLARE @TotalAbsent INT;

    
    DECLARE cur CURSOR FOR SELECT DISTINCT EmployeeID FROM inserted WHERE Status = 'Absent';
    
    OPEN cur;
    FETCH NEXT FROM cur INTO @EmpID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
       
        EXEC CalculateNetSalary @EmpID = @EmpID, @Month = 5;

       
        SELECT @TotalAbsent = COUNT(*) FROM Attendance 
        WHERE EmployeeID = @EmpID AND Status = 'Absent';

       
        IF @TotalAbsent > 3
        BEGIN
            INSERT INTO @AlertTable (EmployeeID, TotalAbsences, SystemMessage)
            VALUES (@EmpID, @TotalAbsent, '⚠️ CRITICAL: Exceeded 3 Absences - Salary Deducted');
        END

        FETCH NEXT FROM cur INTO @EmpID;
    END

    CLOSE cur;
    DEALLOCATE cur;

    
    IF EXISTS (SELECT 1 FROM @AlertTable)
    BEGIN
        SELECT * FROM @AlertTable;
    END
END;
GO