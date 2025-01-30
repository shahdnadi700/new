-- Indexes for Instructor Table
-- This index improves search performance on usernames
CREATE NONCLUSTERED INDEX IDX_Instructor_UserName ON Instructor (Ins_UserName);

-- This index improves performance for queries filtering or sorting by salary
CREATE NONCLUSTERED INDEX IDX_Instructor_Salary ON Instructor (Ins_Salary);

-- Indexes for Student Table
-- This index improves search performance on usernames
CREATE NONCLUSTERED INDEX IDX_Student_Username ON Student (Std_Username);

-- This index improves performance for queries involving birth dates
CREATE NONCLUSTERED INDEX IDX_Student_BirthDate ON Student (BirthDate);

-- Index for Course Table
-- This index improves search performance on course names
CREATE NONCLUSTERED INDEX IDX_Course_Name ON Course (Crs_Name);

-- Index for Branch Table
-- This index improves search performance on branch names
CREATE NONCLUSTERED INDEX IDX_Branch_Name ON Branch (Brn_Name);

-- Index for Department Table
-- This index improves search performance on department names
CREATE NONCLUSTERED INDEX IDX_Department_Name ON Department (Dept_Name);

-- Indexes for Track Table
-- This index improves search performance on track names
CREATE NONCLUSTERED INDEX IDX_Track_Name ON Track (Track_Name);

-- This index improves performance for queries filtering by department ID
CREATE NONCLUSTERED INDEX IDX_Track_Dept_Id ON Track (Dept_Id);

-- Indexes for Exam Table
-- This index improves performance for queries filtering by exam type
CREATE NONCLUSTERED INDEX IDX_Exam_Type ON Exam (Type);

-- This index improves performance for queries filtering by course code
CREATE NONCLUSTERED INDEX IDX_Exam_Crs_Code ON Exam (Crs_Code);

-- This index improves performance for queries filtering by instructor ID
CREATE NONCLUSTERED INDEX IDX_Exam_Ins_Id ON Exam (Ins_Id);

-- Index for Instructor_Course_Intake Table
-- This index optimizes queries joining or filtering by course, instructor, and intake
CREATE NONCLUSTERED INDEX IDX_Instructor_Course_Intake ON Instructor_Course_Intake (Crs_Code, Ins_Id, Ink_Id);

-- Index for TrackIntakeExamBranch Table
-- This index optimizes queries joining or filtering by intake, track, branch, and exam
CREATE NONCLUSTERED INDEX IDX_TrackIntakeExamBranch ON TrackIntakeExamBranch (Ink_Id, Track_Id, Brn_Id, Exm_Id);

-- Index for Question Table
-- This index improves search performance on question types
CREATE NONCLUSTERED INDEX IDX_Question_Type ON Question (Type);

-- Index for CorrectChoice Table
-- This index improves performance for queries filtering by correct answers
CREATE NONCLUSTERED INDEX IDX_CorrectChoice_Answer ON CorrectChoice (CorrectAnswer);

-- Index for WrongChoice Table
-- This index improves performance for queries filtering by wrong answers
CREATE NONCLUSTERED INDEX IDX_WrongChoice_Answer ON WrongChoice (WrongAnswer);

-- Index for TextQuestion Table
-- This index improves performance for queries filtering by text answers
CREATE NONCLUSTERED INDEX IDX_TextQuestion_Answer ON TextQuestion (Answer);

-- Index for Question_Exam Table
-- This index improves query performance for question-exam relationships
CREATE NONCLUSTERED INDEX IDX_Question_Exam ON Question_Exam (Q_Id, Exm_Id);

-- Indexes for Answer Table
-- This index improves performance for queries filtering by question ID
CREATE NONCLUSTERED INDEX IDX_Answer_Question ON Answer (Q_Id);

-- This index improves performance for queries filtering by student ID
CREATE NONCLUSTERED INDEX IDX_Answer_Student ON Answer (NationalId);

-- This index improves performance for queries filtering by exam ID
CREATE NONCLUSTERED INDEX IDX_Answer_Exam ON Answer (Exm_Id);

-- Index for StdBranchTrackIntake Table
-- This index optimizes queries joining or filtering by student, intake, branch, and track
CREATE NONCLUSTERED INDEX IDX_StdBranchTrackIntake ON StdBranchTrackIntake (NationalID, Ink_Id, Brn_Id, Track_Id);

-- Index for Role Table
-- This index improves search performance on role names
CREATE NONCLUSTERED INDEX IDX_Role_Name ON Role (roleName);

-- Index for Permission Table
-- This index improves search performance on permission names
CREATE NONCLUSTERED INDEX IDX_Permission_Name ON Permission (permissionName);

-- Index for RolePermissions Table
-- This index improves performance for queries joining or filtering by role and permission IDs
CREATE NONCLUSTERED INDEX IDX_RolePermissions ON rolePermissions (roleID, permissionID);
select Ins_Salary from Instructor