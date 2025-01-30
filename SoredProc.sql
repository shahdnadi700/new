--Stored for get FinalResult Of the courses specific student examined from view
Create proc sp_GetStudentFinalResultForAllCourses(@Name nvarchar(20))
as
begin 
	select * from GetFinalResult
	where [Student Name] = @Name
end

exec sp_GetStudentFinalResultForAllCourses 'Ali Mahmoud'


--Stored for get FinalResult Of specific course for specific student examined from view
Create proc sp_GetStdntResultInSpecificCrs(@Name nvarchar(20),@CourseName nvarchar(30))
as
begin 
	select * from GetFinalResult --View
	where [Student Name] = @Name and [Course Name] = @CourseName 
end

exec sp_GetStdntResultInSpecificCrs 'Ali Mahmoud' , 'Business Intelligence'


--Stored for get allowanceOptions For Specific Exam
Create Proc GetAllowanceOptionsForSpecificExam (@ExamName nvarchar(35))
as
begin
	select * from AllowanceOptions_VW 
	where [Exam Name] =  @ExamName ;
end

exec GetAllowanceOptionsForSpecificExam 'Introduction to CS Exam'

--Calculate Total Degrees of the exam which student examined
Create or alter proc CalculateFinal(@NationalId char(14),@E_Id int )
as
begin
declare @CalcResult int =
(select Sum(Q.Degree) 
from Answer A,Question Q ,Student S,Exam E
where S.NationalID = @NationalId and E.Exm_Id = @E_Id and
A.Exm_Id = E.Exm_Id and A.Q_Id = Q.Q_Id
and A.NationalId = S.NationalID and A.[IsCorrect] = 1
)

select @CalcResult as 'SumOfDegrees'
end

exec CalculateFinal 29707040123456,6



---proc to add branch by training manager
CREATE OR ALTER PROCEDURE addBranch_proc
    @Brn_Name NVARCHAR(20) 
AS
BEGIN
    BEGIN TRY
        INSERT INTO Branch (Brn_Name)  
        VALUES (@Brn_Name); 
    END TRY
    BEGIN CATCH
        PRINT 'Error in adding new branch...';
    END CATCH
END;


exec addBranch_proc  'npnew'
/*******************************************************************/ 
---proc to update branch by training manager
CREATE OR ALTER PROCEDURE updateBranch_proc
    @Brn_Id INT,       
    @Brn_Name NVARCHAR(20)   
AS
BEGIN
    BEGIN TRY
        UPDATE Branch
        SET Brn_Name = @Brn_Name  
        WHERE Brn_Id = @Brn_Id;  
    END TRY
    BEGIN CATCH
        PRINT 'Error in updating';
    END CATCH
END;


exec updateBranch_proc  1,'updatedp1' 


select *from Branch 
/*******************************************************/ 
---proc to add track by training manager

CREATE OR ALTER PROCEDURE addTrack_proc
    @Track_Name NVARCHAR(30),  
    @Dept_Id INT                
AS
BEGIN
    BEGIN TRY
        INSERT INTO Track ( Track_Name, Dept_Id)  
        VALUES ( @Track_Name, @Dept_Id); 
    END TRY
    BEGIN CATCH
        PRINT 'Error in adding new track...';
    END CATCH
END;


exec addTrack_proc 'newtrack3',2
select * from Department
select * from Track   

/***************************************************************/
---proc to update track by training manager
CREATE OR ALTER PROCEDURE updateTrack_proc
    @Track_Name NVARCHAR(20),  
    @Dept_Id INT                
AS
BEGIN
    BEGIN TRY
        UPDATE Track
        SET Track_Name = @Track_Name
        WHERE Dept_Id = @Dept_Id;

        PRINT 'Track updated successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error in updating: ' + ERROR_MESSAGE();
    END CATCH
END;
EXEC updateTrack_proc @Track_Name = 'nt22', @Dept_Id = 4;



/*****************************************************************/ 
--add intake
CREATE OR ALTER PROCEDURE addIntake_proc
    @Intake_Value NVARCHAR(20)  
AS
BEGIN
    BEGIN TRY
        INSERT INTO Intake (Ink_Name)  
        VALUES (@Intake_Value);

        PRINT 'Intake added successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error in adding new Intake: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC addIntake_proc @Intake_Value = 'new2026';

select * from Intake
/************************************************************/ 
--add student 
CREATE OR ALTER PROC addStudent_proc
    @NationalID CHAR(14),
    @Std_Name NVARCHAR(15),
    @Phone NVARCHAR(15),
    @Std_Username NVARCHAR(15),
    @Std_Password NVARCHAR(50),
    @BirthDate DATE
AS
BEGIN
    BEGIN TRY
        INSERT INTO Student (NationalID, Std_Name, Phone, Std_Username, Std_Password, BirthDate)
        VALUES (@NationalID, @Std_Name, @Phone, @Std_Username, @Std_Password, @BirthDate);
        
        PRINT 'Student added successfully!';
    END TRY
    BEGIN CATCH
        PRINT 'Error in adding new student: ' + ERROR_MESSAGE();
    END CATCH
END


EXEC addStudent_proc 
    @NationalID = '77332999412345',
    @Std_Name = N'Tasneem Mohammed',
    @Phone = '01201258567',
    @Std_Username = 'Tasneeme',
    @Std_Password = 'pass@256',
    @BirthDate = '1995-07-01';

select * from student
/***************************************************/
---proc to add new course by training manager 

CREATE OR ALTER PROCEDURE addCourse_proc
    @Crs_Code NVARCHAR(6),
    @Crs_Name NVARCHAR(30),
    @MinDegree INT,
    @MaxDegree INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Course (Crs_Code, Crs_Name, MinDegree, MaxDegree)
        VALUES (@Crs_Code, @Crs_Name, @MinDegree, @MaxDegree);

        PRINT 'Course added successfully!';
    END TRY
    BEGIN CATCH
        PRINT 'Error in adding new course: ' + ERROR_MESSAGE();
    END CATCH
END



EXEC addCourse_proc 
    @Crs_Code = 'CS1441',
    @Crs_Name = 'Computer Science 101',
    @MinDegree = 50,
    @MaxDegree = 100;

select * from Course 
/*************************************************************************/
---proc to update Course by training manager

CREATE OR ALTER PROCEDURE updateCourse_proc
    @Crs_Code NVARCHAR(6),   
    @Crs_Name NVARCHAR(30)   
AS
BEGIN
    BEGIN TRY
        UPDATE Course
        SET Crs_Code = @Crs_Code,    
            Crs_Name = @Crs_Name      
        WHERE Crs_Code = @Crs_Code;  
    END TRY
    BEGIN CATCH
        PRINT 'Error in updating';
    END CATCH
END;


exec updateCourse_proc 'WD444','os'  
select * from Course
/*******************************************************/ 
--show branch to only one student 
CREATE OR ALTER PROCEDURE showBranchtonlyStudent_proc
    @NationalID char(14)  
AS
BEGIN
    SELECT s.Std_Name, s.NationalID, b.Brn_Id, b.Brn_Name
    FROM Student AS s
    INNER JOIN StdBranchTrackIntake AS sbi ON s.NationalID = sbi.NationalID
    INNER JOIN Branch AS b ON b.Brn_Id = sbi.Brn_Id
    WHERE s.NationalID = @NationalID; 
END
exec showBranchtonlyStudent_proc '29603050123456'



/**************************************************************/
-- proc to show one student info by NationalID

CREATE OR ALTER PROCEDURE GetStudentInfo_proc
    @NationalID char(14) 
	as
BEGIN
    SELECT *
    FROM Student
    WHERE NationalID = @NationalID;  
END;

EXEC GetStudentInfo_proc '29804120123456';

/*******************************************************************/  
----proc to show intake for students 
create or alter proc showIntaketoStudent_proc 
as 
begin

	SELECT s.Std_Name, s.NationalID,i.Ink_Id ,i.Ink_Name
FROM Student AS s
INNER JOIN StdBranchTrackIntake AS sbi ON s.NationalID = sbi.NationalID
INNER JOIN Intake AS i ON sbi.Ink_Id = i.Ink_Id;

end 

exec showIntaketoStudent_proc  
/*********************************************************/ 
--proc give track and student info by NationalID
create or alter proc showTracktoOneStudent_proc 
@NationalID char(14)
as
begin

	SELECT s.Std_Name, s.NationalID,t.Track_Id ,t.Track_Name
FROM Student AS s
INNER JOIN StdBranchTrackIntake AS sbi ON s.NationalID = sbi.NationalID
INNER JOIN Track AS t ON sbi.Track_Id = t.Track_Id
    WHERE s.NationalID = @NationalID; 

end 
exec showTracktoOneStudent_proc'29506120123456'  

/*********************************************/
----proc to show track for students

create or alter proc showTracktoStudent_proc 
as 
begin

	SELECT s.Std_Name, s.NationalID,t.Track_Id ,t.Track_Name
FROM Student AS s
INNER JOIN StdBranchTrackIntake AS sbi ON s.NationalID = sbi.NationalID
INNER JOIN Track AS t ON sbi.Track_Id = t.Track_Id;

end 

exec showTracktoStudent_proc
/*************************************************************************/


----proc to show Branch for students
create or alter proc showBranchtoStudent_proc 
as 
begin

	SELECT s.Std_Name, s.NationalID,b.Brn_Id,b.Brn_Name
FROM Student AS s
INNER JOIN StdBranchTrackIntake AS sbi ON s.NationalID = sbi.NationalID
INNER JOIN Branch AS b ON b.Brn_Id = sbi.Brn_Id;

end 

exec showBranchtoStudent_proc



CREATE OR ALTER PROC sp_addQToExam
	@examId INT,
	@qId INT
AS 
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Exam WHERe Exam.Exm_Id = @examId)
		BEGIN
			PRINT 'The Exam Does not exist'
			return;
		END
	IF EXISTS (SELECT 1 FROM Question_Exam WHERE Q_Id = @qId and Exm_Id = @examId)
		BEGIN 
			PRINT 'The Question already added to the Exam'
			RETURN;
		END
	INSERT INTO Question_Exam(Q_Id , Exm_Id)
	VALUES (@qId , @examId);
	PRINT 'Question added successfully'
END

exec sp_addQToExam 1,26