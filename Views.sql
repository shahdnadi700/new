--View for display StdName with FinalResult Of the courses they examined
Create view GetFinalResult
as
	select Std_Name 'Student Name', Crs_Name 'Course Name', FinalResult 'Final Result'
	from Student S, Course C, Student_Course SC
	where SC.NationalId = S.NationalID and
	Sc.Crs_Code = C.Crs_Code

select * from GetFinalResult


--View show Exam with intake with branch with track in any department 
Create or ALter View ExamDetails
as
	Select CONCAT(C.Crs_Name,' Exam') as 'Exam Name',I.Ink_Name 'Intake',B.Brn_Name 'Branch'
	,T.Track_Name 'Track',D.Dept_Name 'Department',C.Crs_Name CourseName, Year,StartTime,EndTime
	from TrackIntakeExamBranch TIEB, Exam E,Intake I,Branch B,Track T,Course C,Department D
	where 
	TIEB.Brn_Id = B.Brn_Id and TIEB.Ink_Id = I.Ink_Id and TIEB.Track_Id = T.Track_Id
	and TIEB.Exm_Id = E.Exm_Id and E.Crs_Code = C.Crs_Code and T.Dept_Id = D.Dept_Id


select * from ExamDetails


--View display AllowanceOptions for exam
Create view AllowanceOptions_VW
as
	Select CONCAT(C.Crs_Name,' Exam') as 'Exam Name', EAO.AllowanceOptions
	from ExmAllowanceOptions EAO, Exam E,Course C
	where EAO.Exm_Id = E.Exm_Id and E.Crs_Code = C.Crs_Code


select * From AllowanceOptions_VW

--View for student (questions with options in exam)
Create or alter View VW_QuestionsInExam
as 
	Select Q.Q_Id, CONCAT(C.Crs_Name,' Exam') as 'Exam Name',Q.Q_Text
	from Question_Exam QE, Exam E,Question Q, Course C
	where E.Crs_Code = C.Crs_Code and 
	QE.Exm_Id = E.Exm_Id and QE.Q_Id = Q.Q_Id

select * from VW_QuestionsInExam

 
--view to course
create or alter view courseInfo_v 
as
select * from Course

select * from courseInfo_v 
/*******************************************************/ 
--view Department and track
create or alter view courseInDepartmentInfo_v 
as
select Dept_Name, Track_Name from Track t,Department d
where t.Dept_Id=d.Dept_Id 

select * from courseInDepartmentInfo_v 

--show students with course
create or alter view showStudents_v 
as
SELECT s.Std_Name, sc.Crs_Code, c.Crs_Name
FROM Student AS s
INNER JOIN Student_Course AS sc ON s.NationalID = sc.NationalId
INNER JOIN Course AS c ON sc.Crs_Code = c.Crs_Code;

select * from showStudents_v
/*************************************************************************/ 
--show Instractor with course
create or alter view showInistractor_v 
as
SELECT i.Ins_ID,i.Ins_Name,c.Crs_Name, c.Crs_Code
FROM Instructor AS i
INNER JOIN Instructor_Course_Intake AS ici ON i.Ins_ID = ici.Ins_Id
INNER JOIN Course AS c ON ici.Crs_Code = c.Crs_Code;

select * from showInistractor_v 

--show Departments
create or alter view showDepartment_v 
as
SELECT Dept_Id,Dept_Name
FROM Department AS d

select * from showDepartment_v 

-- Student with courses
CREATE OR ALTER VIEW vw_InstructorStudent
AS 
	SELECT I.Ins_ID , I.Ins_Name, C.Crs_Code, C.Crs_Name, S.Std_Name , S.Phone
	FROM Instructor I INNER JOIN Instructor_Course_Intake ICI ON I.Ins_ID = ICI.Ins_Id INNER JOIN Course C ON ICI.Crs_Code = C.Crs_Code INNER JOIN StdBranchTrackIntake SB ON ICI.Ink_Id = SB.Ink_Id INNER JOIN Student S ON SB.NationalID = S.NationalID
	WHERE ICI.Crs_Code = C.Crs_Code AND ICI.Ink_Id = SB.Ink_Id AND SB.NationalID = S.NationalID

select  * from dbo.vw_InstructorStudent