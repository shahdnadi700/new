--Exam Correction and insert degree in finalResult
Create or alter Trigger ExamCorrection
on Answer
After Insert
as 
begin
	declare @Q_Id int = (Select Q_Id from inserted)
	declare @type nvarchar(20) =( select type from Question where Q_Id = @Q_Id)
	if(@type = 'Multiple choice')
	begin
	declare @AnswerText varchar(400) = (select AnswerText from inserted)
	declare @CorrectOptions table (
	C_Option nvarchar(400)) 

	insert into @CorrectOptions
	select CorrectAnswer from CorrectChoice where Q_Id = @Q_Id


	if exists (Select C_Option from @CorrectOptions where C_Option = @AnswerText)
    begin
        Update Answer  
		set IsCorrect = 1
		where Ans_Id = (select Ans_Id from inserted)
    end
    else
    begin
		Update Answer  
		set IsCorrect = 0
		where Ans_Id = (select Ans_Id from inserted)	
	end
	end
	if(@type = 'True & False')
	begin
	declare @True_False varchar(5) = (select AnswerText from inserted)
	declare @Option varchar(5) = (select Answer from TrueOrFalse where Q_Id = 2)
	if(@Option = @True_False)
	begin 
		Update Answer  
		set IsCorrect = 1
		where Ans_Id = (select Ans_Id from inserted)
	end
	else
	begin 
	Update Answer  
		set IsCorrect = 0
		where Ans_Id = (select Ans_Id from inserted)
	end
	end
end

insert into Answer
values 
('var',8,null,29707040123456,6)

-- Verify ExamStartTime < ExamEndTime
Create Trigger trg_ValidateExamTimes
on TrackIntakeExamBranch
Instead of Insert, Update
as
begin
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE StartTime >= EndTime
    )
    begin
        Print ('Exam start time must be earlier than end time.');
        
    end
end;

insert into TrackIntakeExamBranch
values
(4 , 5,6,2,year(getdate()),'2:00:00','1:00:00')

-- Prevent multiple instructors for the same course, intake, and year
CREATE TRIGGER trg_PreventDuplicateInstructorAssignments
ON Instructor_Course_Intake
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT Crs_Code, Ink_Id, YEAR(GETDATE())
        FROM inserted
        GROUP BY Crs_Code, Ink_Id
        HAVING COUNT(Ins_Id) > 1
    )
    BEGIN
        RAISERROR ('A course cannot have more than one instructor for the same intake and year.', 16, 1);
        ROLLBACK;
    END
END;

insert into Instructor_Course_Intake
values
('CS121',5,5)

-- On Courses Table: Ensure MaxDegree > MinDegree
Create or alter Trigger trg_CheckCourseDegrees
on Course
Instead of Insert, Update
as
begin
    Set NoCount on;
    IF EXISTS (
        Select 1
        From inserted
        Where MaxDegree <= MinDegree
    )
    Begin
        print ('MaxDegree must be greater than MinDegree.');
        
		end
end;

insert into Course
values
('HR303','Human Resource',100,20)

Create Trigger trg_ValidateStdBranchTrackIntakeReferences
on StdBranchTrackIntake
Instead of INSERT, UPDATE
as
Begin
    
    SET NOCOUNT ON;

    
    IF NOT EXISTS (
        SElect 1
        From Student S
        Where S.NationalID = (Select Top 1 NationalID from inserted) 
    )
    Begin
        
        Print ('Invalid NationalID reference.');
        
        return; 
    end

    
    IF NOT EXISTS (
        Select 1
        From Intake I
        Where I.Ink_Id = (Select Top 1 Ink_Id from inserted) 
    )
    begin
        
        Print 'Invalid Intake reference.';
       
        return; 
    end

    
    IF NOT EXISTS (
        Select 1
        From Branch B
        WHere B.Brn_Id = (Select Top 1 Brn_Id From inserted) 
    )
    begin
        
        Print 'Invalid Branch reference.'
     
        return; 
    end

    
    IF NOT EXISTS (
        Select 1
        From Track T
        WHere T.Track_Id = (Select Top 1 Track_Id From inserted) -- Check the Track ID in the inserted data
    )
    begin
     
        Print ('Invalid Track reference.');
   
        return; 
    end
end;


--Trigger for add new branch
create trigger trgForAddBranch
on Branch
after INSERT 
as
begin

	print 'you added new Branch.....'
end

insert into Branch(Brn_Name)
values('newBracheadded') 
/**************************************************/
--Trigger for add new trak
create trigger trgForAddTrack
on Track
after INSERT 
as
begin

	print 'you added new Track.....'
end

insert into Track(Track_name,Dept_Id)
values('Trakaddednow',5)

/*****************************************/ 
--Trigger for add new Intake

create trigger trgForAddIntake
on Intake
after INSERT 
as
begin

	print 'you added new Intake.....'
end

insert into Intake(Ink_Name)
values('newInkadded')  

/****************************************************************/ 
--Trigger for add new student
create or alter trigger trgForAddstudent
on Student
after INSERT 
as
begin

	print 'you added new Student.....'
end

insert into Student
values('77332664412345',N'nStud','01201777567','monaa','pass@952','1998-03-01',4) 

